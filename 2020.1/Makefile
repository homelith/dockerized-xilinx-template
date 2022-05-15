################################################################################
# Makefile for providing xilinx tools introduced environment via docker
#
# usage:
#   $ make docker  # get console on xilinx-tools container
#   $ make clean   # cleanup generated files
################################################################################

.PHONY: default image docker clean

# dump variables
#@$(foreach v,$(.VARIABLES),$(info $v=$($v)))

SCRIPT_DIR     := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
PROJ_ROOT      := .
INSTALL_ROOT   := /opt

IMAGE_NAME     := xilinx-tools
IMAGE_TAG      := 2020.1
INTERNAL_USER  := xuser
BUILD_REQUIRED := \
	$(shell if ! (type docker > /dev/null 2>&1); then echo 0; \
	elif ! (docker inspect $(IMAGE_NAME):$(IMAGE_TAG) > /dev/null 2>&1); then echo 1; \
	elif [ $$(date -r Dockerfile +%s) -gt $$(date -d $$(docker inspect -f '{{.Created}}' $(IMAGE_NAME):$(IMAGE_TAG) ) +%s) ]; then echo 1 ; \
	else echo 0 ; \
	fi )

default: docker

image:
	time docker build -t $(IMAGE_NAME):$(IMAGE_TAG) .


# get vivado & xsdk & petalinux PATH introduced shell on a container
# VendorID / ProductID
#   10c4:ea70 = CP2105 Dual UART Bridge
#   0403:6014 = FT232H Single HS USB-UART
#   0403:6010 = FT2232C/D/H Dual UART/FIFO IC
docker:
	@if !(type docker > /dev/null 2>&1); then echo "command 'docker' not found." ; exit 1 ; fi
	@if [ $(BUILD_REQUIRED) -eq 1 ]; then time docker build -t $(IMAGE_NAME):$(IMAGE_TAG) . ; fi
	docker run --rm --net host -it -w $(SCRIPT_DIR) \
		-v $(SCRIPT_DIR)/$(PROJ_ROOT)/:$(SCRIPT_DIR)/$(PROJ_ROOT)/ \
		-v ${INSTALL_ROOT}:/opt -e USER_ID=`id -u` -e GROUP_ID=`id -g` \
		$(shell if [ -n "`lsusb -d 10c4:ea70`" ] ; then echo "--device `lsusb -d 10c4:ea70`" | perl -pe 's!Bus\s(\d{3})\sDevice\s(\d{3}).*!/dev/bus/usb/\1/\2!' ; fi) \
		$(shell if [ -n "`lsusb -d 0403:6014`" ] ; then echo "--device `lsusb -d 0403:6014`" | perl -pe 's!Bus\s(\d{3})\sDevice\s(\d{3}).*!/dev/bus/usb/\1/\2!' ; fi) \
		$(shell if [ -n "`lsusb -d 0403:6010`" ] ; then echo "--device `lsusb -d 0403:6010`" | perl -pe 's!Bus\s(\d{3})\sDevice\s(\d{3}).*!/dev/bus/usb/\1/\2!' ; fi) \
		$(shell if [ -e /dev/ttyUSB0 ] ; then echo "--device /dev/ttyUSB0"; fi) \
		$(shell if [ -e /dev/ttyUSB1 ] ; then echo "--device /dev/ttyUSB1"; fi) \
		$(shell if [ -e /dev/ttyUSB2 ] ; then echo "--device /dev/ttyUSB2"; fi) \
		$(shell if [ -e /dev/ttyUSB3 ] ; then echo "--device /dev/ttyUSB3"; fi) \
		$(shell if [ -e /dev/ttyUSB4 ] ; then echo "--device /dev/ttyUSB4"; fi) \
		$(shell if [ -e /dev/ttyUSB5 ] ; then echo "--device /dev/ttyUSB5"; fi) \
		-e DISPLAY=$(DISPLAY) -v /tmp/.X11-unix:/tmp/.X11-unix -v $(HOME)/.Xauthority:/home/$(INTERNAL_USER)/.Xauthority \
		$(IMAGE_NAME):$(IMAGE_TAG) bash && true

docker-xrdp:
	@if !(type docker > /dev/null 2>&1); then echo "command 'docker' not found." ; exit 1 ; fi
	@if [ $(BUILD_REQUIRED) -eq 1 ]; then time docker buiild -t $(IMAGE_NAME):$(IMAGE_TAG) . ; fi
	docker run --rm -it -w $(SCRIPT_DIR) \
		-p 13389:3389 \
		-v $(SCRIPT_DIR)/$(PROJ_ROOT)/:$(SCRIPT_DIR)/$(PROJ_ROOT)/ \
		-v ${INSTALL_ROOT}:/opt -e USER_ID=`id -u` -e GROUP_ID=`id -g` \
		$(shell if [ -n "`lsusb -d 10c4:ea70`" ] ; then echo "--device `lsusb -d 10c4:ea70`" | perl -pe 's!Bus\s(\d{3})\sDevice\s(\d{3}).*!/dev/bus/usb/\1/\2!' ; fi) \
		$(shell if [ -n "`lsusb -d 0403:6014`" ] ; then echo "--device `lsusb -d 0403:6014`" | perl -pe 's!Bus\s(\d{3})\sDevice\s(\d{3}).*!/dev/bus/usb/\1/\2!' ; fi) \
		$(shell if [ -n "`lsusb -d 0403:6010`" ] ; then echo "--device `lsusb -d 0403:6010`" | perl -pe 's!Bus\s(\d{3})\sDevice\s(\d{3}).*!/dev/bus/usb/\1/\2!' ; fi) \
		$(shell if [ -e /dev/ttyUSB0 ] ; then echo "--device /dev/ttyUSB0"; fi) \
		$(shell if [ -e /dev/ttyUSB1 ] ; then echo "--device /dev/ttyUSB1"; fi) \
		$(shell if [ -e /dev/ttyUSB2 ] ; then echo "--device /dev/ttyUSB2"; fi) \
		$(shell if [ -e /dev/ttyUSB3 ] ; then echo "--device /dev/ttyUSB3"; fi) \
		$(shell if [ -e /dev/ttyUSB4 ] ; then echo "--device /dev/ttyUSB4"; fi) \
		$(shell if [ -e /dev/ttyUSB5 ] ; then echo "--device /dev/ttyUSB5"; fi) \
		$(IMAGE_NAME):$(IMAGE_TAG) && true


# remove docker image
clean:
	@if !(type docker > /dev/null 2>&1); then echo "command 'docker' not found." ; exit 1 ; fi
	@if !(docker inspect $(IMAGE_NAME):$(IMAGE_TAG) > /dev/null 2>&1); then echo "no '$(IMAGE_NAME):$(IMAGE_TAG)' image, do nothing."; exit 1 ; fi
	docker image rm $(IMAGE_NAME):$(IMAGE_TAG)
