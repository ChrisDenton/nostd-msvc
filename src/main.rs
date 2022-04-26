#![no_std]
#![feature(lang_items)]
#![no_main]

#[no_mangle]
extern fn main() -> i32 {
    return 0;
}

#[panic_handler]
fn panic(_info: &core::panic::PanicInfo) -> ! {
    loop {}
}

#[lang = "eh_personality"]
fn eh_personality() {}