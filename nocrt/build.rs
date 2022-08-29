fn main() {
    println!("cargo:rustc-link-lib=libvcruntime");
	println!("cargo:rustc-link-arg=/ENTRY:main");
}
