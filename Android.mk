#
# Copyright (C) 2023 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

LOCAL_PATH := $(call my-dir)

ifneq ($(filter a53x, $(TARGET_DEVICE)),)
include $(call all-subdir-makefiles,$(LOCAL_PATH))

RECOVERY_KERNEL_MODULES := $(shell cat device/samsung/a53x/modules.load)
RECOVERY_KERNEL_MODULES_PATH := $(addprefix $(TARGET_RECOVERY_ROOT_OUT)/lib/modules/,$(shell cat device/samsung/a53x/modules.load))

INSTALLED_KERNEL_TARGET := $(PRODUCT_OUT)/kernel
INTERNAL_RECOVERY_RAMDISK_FILES_TIMESTAMP := $(call intermediates-dir-for,PACKAGING,recovery)/ramdisk_files-timestamp

$(RECOVERY_KERNEL_MODULES_PATH): $(INSTALLED_KERNEL_TARGET)
	@echo "Copying kernel modules to recovery ramdisk: $@"
	@mkdir -p $(dir $@)
	cp -r $(VENDOR_RAMDISK_FRAGMENT.dlkm.STAGING_DIR)/lib/ $(TARGET_RECOVERY_ROOT_OUT)/

$(INTERNAL_RECOVERY_RAMDISK_FILES_TIMESTAMP): $(RECOVERY_KERNEL_MODULES_PATH)
endif
