#![no_std]
#![no_main]

use core::ptr::null_mut as null;
use windows_sys::Win32::System::Threading::ExitProcess;
use windows_sys::Win32::System::Console::{GetStdHandle, STD_OUTPUT_HANDLE};
use windows_sys::Win32::Storage::FileSystem::WriteFile;
use windows_sys::Win32::Foundation::GetLastError;

#[no_mangle]
extern "C" fn main() -> i32 {
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
	unsafe { ExitProcess(u32::MAX) }
}

// wrong signature but doesn't matter
// note: this should not be necessary
#[no_mangle]
#[allow(nonstandard_style)]
extern "C" fn __CxxFrameHandler3() {
	unsafe { ExitProcess(u32::MAX) };
}
