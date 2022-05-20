/******************************************************************************
* Copyright (C) 2006 - 2020 Xilinx, Inc.  All rights reserved.
* SPDX-License-Identifier: MIT
******************************************************************************/

#include "platform.h"
#include "sleep.h"
#include "xparameters.h"
#include "xgpio.h"

// Definitions for peripheral MB_SYSTEM_AXI_GPIO_0 located on xparameters.h
//#define XPAR_MB_SYSTEM_AXI_GPIO_0_BASEADDR 0x00080000
//#define XPAR_MB_SYSTEM_AXI_GPIO_0_HIGHADDR 0x00080FFF
//#define XPAR_MB_SYSTEM_AXI_GPIO_0_DEVICE_ID 0
//#define XPAR_MB_SYSTEM_AXI_GPIO_0_INTERRUPT_PRESENT 0
//#define XPAR_MB_SYSTEM_AXI_GPIO_0_IS_DUAL 0

XGpio axi_gpio_0;

int main(void)
{
	int stat;
	init_platform();

	// init gpio
    stat = XGpio_Initialize(&axi_gpio_0, XPAR_MB_SYSTEM_AXI_GPIO_0_DEVICE_ID);
    if(stat != XST_SUCCESS){
        xil_printf("gpio init failed\n");
        return XST_FAILURE;
    }

    // set gpio channel 1 all output
    XGpio_SetDataDirection(&axi_gpio_0, 1, 0x0);

    // blink gpio
    u32 gpio_out = 0x00000000U;
    while (1) {
    	XGpio_DiscreteWrite(&axi_gpio_0, 1, gpio_out);
    	gpio_out = ~gpio_out;
    	usleep(500000);
    }
	return XST_SUCCESS;
}
