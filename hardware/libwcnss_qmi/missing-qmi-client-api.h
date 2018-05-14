/*
 * Copyright (C) 2018 The LineageOS Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#define QMI_PORT_RMNET_0               "rmnet0"
#define DMS_DEVICE_MAC_WLAN_V01         0
#define QMI_DMS_GET_MAC_ADDRESS_REQ_V01 0x5Cull

void *dms_get_service_object_internal_v01(int32_t, int32_t, int32_t);
int   qmi_client_send_msg_sync(void*, unsigned int, void*, unsigned int,
                               void*, unsigned int, unsigned int);
int   qmi_client_init(const char*, void*, void*, void*, void**);
int   qmi_client_release(void*);
int   qmi_init(void*, void*);
int   qmi_release(int);

struct dms_get_mac_address_req_msg_v01 {
	int device;
};

struct dms_get_mac_address_resp_msg_v01 {
	uint8_t  pad1[8];
	uint8_t  mac_address_valid;
	uint32_t mac_address_len;
	uint8_t  mac_address[6];
	uint8_t  pad2[2];
};

