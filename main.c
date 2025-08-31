#include <stdint.h>

// Optional: define LED pin addresses if using GPIO
// #define LED_PORT (volatile uint32_t*) 0x4001100C

void main(void) {
    // Example: just an infinite loop
    while (1) {
        // Optionally toggle an LED or perform a no-op
        // *LED_PORT ^= 1 << 5;
    }
}