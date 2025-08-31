.syntax unified
.cpu cortex-m3
.thumb

.section .isr_vector, "a", %progbits
.word _estack
.word Reset_Handler

.section .text.Reset_Handler
.global Reset_Handler
.type Reset_Handler, %function
Reset_Handler:
    // Copy .data section from flash to RAM
        ldr r0, =_sdata      // Destination
            ldr r1, =_edata      // End of .data
                ldr r2, =_sidata     // Source in flash
                CopyData:
                    cmp r0, r1
                        bge ZeroBss
                            ldr r3, [r2], #4
                                str r3, [r0], #4
                                    b CopyData

                                    ZeroBss:
                                        // Zero initialize .bss section
                                            ldr r0, =_sbss
                                                ldr r1, =_ebss
                                                ZeroLoop:
                                                    cmp r0, r1
                                                        bge CallMain
                                                            movs r2, #0
                                                                str r2, [r0], #4
                                                                    add r0, r0, #4
                                                                        b ZeroLoop

                                                                        CallMain:
                                                                            bl main

                                                                            LoopForever:
                                                                                b LoopForever