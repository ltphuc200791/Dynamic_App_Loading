
#include "syscall.h"

uint8_t led_num = 0x02;
uint8_t led_status;

uint8_t dummy_function_2(){
    return 0x01;
}

uint8_t dummy_function(){
    uint8_t led_status = dummy_function_2();
    return led_status;
}

#define DUMMY_SYS_ADDR 0xA5A5A5A5
const sys_struct *sys __attribute__((unused,section(".sys_struct"))) = (sys_struct*)(DUMMY_SYS_ADDR);

// dummy_function, dummy_function_2 and the global variables
// are there just to verify if the relocation is actually working

int main() {
    sys->printf("main function of application is called\n");
	led_num-=1;
	led_status=dummy_function();
	sys->SetLed(led_num, led_status);
    return 0;
}
