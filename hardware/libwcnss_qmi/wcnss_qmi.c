/*--------------------------------------------------------------------------
Copyright (c) 2013, The Linux Foundation. All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of The Linux Foundation nor
      the names of its contributors may be used to endorse or promote
      products derived from this software without specific prior written
      permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NON-INFRINGEMENT ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR
CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
--------------------------------------------------------------------------*/

/*
 * Loosely based on hardware/qcom/wlan/wcnss-service/wcnss_qmi_client.c
 * from the Lenovo code drop (lenovo_tab_3_plus_osc_v1.0_201609.zip).
 * Library is being dlopened by the Lineage wcnss_service (compiled with
 * TARGET_PROVIDES_WCNSS_QMI).
 * Its role is to retrieve the Wi-Fi MAC address from the QMI services,
 * so that wlan0 will not have an auto-generated, random MAC
 * (like 00:0a:f5:2b:eb:4c). Some access points might kick the tablet
 * out of their network otherwise.
 * Later on, the WLAN MAC is written, based on the result we provide, in the
 * /sys/devices/soc.0/a000000.qcom,wcnss-wlan/wcnss_mac_addr
 * kernel sysfs entry, for the driver to process.
 * Normally, a copy of the WLAN MAC address is also kept in the persistent
 * /userstore/wifimac file, however that may get deleted or modified
 * accidentally by users. If that happens, the user should just run
 * "cat /sys/devices/soc.0/a000000.qcom,wcnss-wlan/wcnss_mac_addr > /userstore/wifimac"
 * for the file to be restored.
 */

#if defined(__BIONIC_FORTIFY)
#include <sys/system_properties.h>
#define MODEM_BASEBAND_PROPERTY_SIZE  PROP_VALUE_MAX
#else
#define MODEM_BASEBAND_PROPERTY_SIZE  10
#endif

#define LOG_TAG "libwcnss_qmi_YTX703"
#include <cutils/log.h>
#include <cutils/properties.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include "missing-qmi-client-api.h"

#define SUCCESS 0
#define FAILED -1

#define WLAN_ADDR_SIZE   6
#define DMS_QMI_TIMEOUT (2000)

static void *dms_qmi_client;
static int qmi_handle;
static int dms_init_done = FAILED;

/* Android system property values for various modem types */
#define QMI_UIM_PROP_BASEBAND_VALUE_MSM "msm"
#define QMI_UIM_PROP_BASEBAND_VALUE_APQ "apq"

/* Returns QMI_PORT_RMNET_0 in case of valid baseband, or NULL otherwise.
 */
static const char *dms_find_modem_port()
{
	char ro_baseband[PROPERTY_VALUE_MAX];
	/* Find out the modem type:
	 *   - "msm" for YTX703L
	 *   - "apq" for YTX703F.
	 * Not much use in performing this test really, except to
	 * make sure we're not running on some weird hardware.
	 */
	memset(ro_baseband, 0, sizeof(ro_baseband));
	property_get("ro.baseband", ro_baseband, "");
	const char *qmi_modem_port_ptr = QMI_PORT_RMNET_0;

	/* Map the port based on the read property */
	if ((strcmp(ro_baseband, QMI_UIM_PROP_BASEBAND_VALUE_MSM) == 0) ||
	    (strcmp(ro_baseband, QMI_UIM_PROP_BASEBAND_VALUE_APQ) == 0)) {
		qmi_modem_port_ptr = QMI_PORT_RMNET_0;
	} else {
		ALOGE("%s: Unknown property ro.baseband=%s."
		      "Don't know what modem port to access through QMI.",
		      __func__, ro_baseband);
		qmi_modem_port_ptr = NULL;
	}
	ALOGE("%s: QMI port found for modem: %s",
	      __func__, qmi_modem_port_ptr);

	return qmi_modem_port_ptr;
}

int wcnss_init_qmi()
{
	void *dms_service;
	const char *qmi_modem_port;
	int rc;

	ALOGE("%s: Initialize wcnss QMI Interface", __func__);

	qmi_handle = qmi_init(NULL, NULL);
	if (qmi_handle < 0) {
		ALOGE("%s: Error while initializing qmi", __func__);
		return FAILED;
	}

	/* Magic constants, don't ask */
	dms_service = dms_get_service_object_internal_v01(1, 55, 6);
	if (dms_service == NULL) {
		ALOGE("%s: Not able to get a handle to the device management service",
		      __func__);
		goto exit;
	}

	/* Map to a respective QMI port */
	qmi_modem_port = dms_find_modem_port();
	if (qmi_modem_port == NULL) {
		ALOGE("%s: qmi_modem_port is NULL", __func__);
		goto exit;
	}

	rc = qmi_client_init((const char *)qmi_modem_port,
	                     dms_service, NULL, dms_service, &dms_qmi_client);
	if (rc) {
		ALOGE("%s: Error while Initializing QMI Client: %d",
		      __func__, rc);
		goto exit;
	}

	dms_init_done = SUCCESS;
	return SUCCESS;

exit:
	rc = qmi_release(qmi_handle);
	if (rc) {
		ALOGE("%s: Error %d while releasing qmi %d",
		      __func__, rc, qmi_handle);
	}
	return FAILED;
}

int wcnss_qmi_get_wlan_address(unsigned char *mac_addr)
{
	struct dms_get_mac_address_req_msg_v01  addr_req;
	struct dms_get_mac_address_resp_msg_v01 addr_resp;
	int i = 0;
	int rc;

	/* Protect against stupid users */
	if ((dms_init_done == FAILED) || (mac_addr == NULL)) {
		ALOGE("%s: DMS init fail or mac_addr is NULL", __func__);
		return FAILED;
	}

	/* Clear the request content */
	memset(&addr_req, 0, sizeof(addr_req));

	/* Request to get the WLAN MAC address */
	addr_req.device = DMS_DEVICE_MAC_WLAN_V01;

	rc = qmi_client_send_msg_sync(dms_qmi_client,
	                              QMI_DMS_GET_MAC_ADDRESS_REQ_V01,
	                              &addr_req,  sizeof(addr_req),
	                              &addr_resp, sizeof(addr_resp),
	                              DMS_QMI_TIMEOUT);
	if (rc) {
		ALOGE("%s: Failed to get response from modem (error %d)",
		      __func__, rc);
		return FAILED;
	}

	ALOGE("%s: Mac Address_valid: %d Mac Address Len: %d",
	      __func__, addr_resp.mac_address_valid,
	      addr_resp.mac_address_len);

	if (addr_resp.mac_address_valid == 0 ||
	   (addr_resp.mac_address_len != WLAN_ADDR_SIZE)) {
		ALOGE("%s: Failed to Read WLAN MAC Address", __func__);
		return FAILED;
	}
	/* MAC address comes byte-swapped from the QMI gods */
	for (i = 0; i < WLAN_ADDR_SIZE; i++) {
		mac_addr[WLAN_ADDR_SIZE - i - 1] = addr_resp.mac_address[i];
	}
	ALOGE("%s: Succesfully Read WLAN MAC Address", __func__);

	return SUCCESS;
}

void wcnss_qmi_deinit()
{
	int rc;

	ALOGI("%s: Deinitialize wcnss QMI interface", __func__);

	if (dms_init_done == FAILED) {
		ALOGE("%s: DMS Service was not Initialized", __func__);
		return;
	}

	rc = qmi_client_release(dms_qmi_client);
	if (rc) {
		ALOGE("%s: Error while releasing qmi_client: %d",
		      __func__, rc);
	}

	qmi_handle = qmi_release(qmi_handle);
	if (qmi_handle < 0)    {
		ALOGE("%s: Error while releasing qmi %d",
		      __func__, qmi_handle);
	}
	dms_init_done = FAILED;
}
