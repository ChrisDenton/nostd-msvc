#![no_std]
#![no_main]

use core::ptr::null_mut as null;
use windows_sys::Win32::System::Threading::ExitProcess;
use windows_sys::Win32::System::Console::{GetStdHandle, STD_OUTPUT_HANDLE};
use windows_sys::Win32::Storage::FileSystem::WriteFile;
use windows_sys::Win32::Foundation::GetLastError;

#[no_mangle]
extern fn main() -> i32 {
	let stdout = unsafe { GetStdHandle(STD_OUTPUT_HANDLE) };
	if stdout > 0 {
		let msg = b"Hello World";
		write(stdout, msg);
	}
	0
}

fn write(handle: isize, msg: &[u8]) {
	unsafe {
		let result = WriteFile(handle, msg.as_ptr().cast(), msg.len() as u32, null(), null());
		if result == 0 {
			ExitProcess(GetLastError());
		}
	}
}

#[panic_handler]
fn panic(_info: &core::panic::PanicInfo) -> ! {
	unsafe { ExitProcess(1) }
}
