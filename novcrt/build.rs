fn main() {
	println!("cargo:rustc-link-lib=./musl/lib/mem");
	println!("cargo:rustc-link-arg=/ENTRY:main");
}
