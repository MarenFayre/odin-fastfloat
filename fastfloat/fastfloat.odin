package fastfloat

foreign import FastFloat "lib/fastfloat.lib" 

Chars_Format :: enum i32{
    scientific = 1<<0,
    fixed = 1<<2,
    hex = 1<<3,
    general = fixed | scientific,
};

From_Chars_Result :: struct {
		ptr: [^]u8,   /* pointing behind the last valid valid it found when successful */
		ec: i32,      /* std::errc error code */
}

@(default_calling_convention="c")
foreign FastFloat {
	fastfloat_parse_f32 :: proc (first: [^]u8, last: [^]u8, value: ^f32, fmt: Chars_Format) -> From_Chars_Result ---
	fastfloat_parse_f64 :: proc (first: [^]u8, last: [^]u8, value: ^f64, fmt: Chars_Format) -> From_Chars_Result ---
}


parse_f32 :: #force_inline proc "c" (s: string, fmt: Chars_Format = Chars_Format.general) -> (value: f32, ok: bool) {
	value, _, ok = parse_f32_substring(s, fmt)
	return 
}

parse_f32_substring :: #force_inline proc "c" (s: string, fmt: Chars_Format = Chars_Format.general) -> (value: f32, substring: string, ok: bool) {
	result := fastfloat_parse_f32(raw_data(s), raw_data(s)[len(s):], &value, fmt)
	if result.ec == 0 {
		ok = true
		substring = s[:uintptr(result.ptr)-uintptr(raw_data(s))]
	} 
	return
}


parse_f64 :: #force_inline proc "c" (s: string, fmt: Chars_Format = Chars_Format.general) -> (value: f64, ok: bool) {
	value, _, ok = parse_f64_substring(s, fmt)
	return 
}

parse_f64_substring :: #force_inline proc "c" (s: string, fmt: Chars_Format = Chars_Format.general) -> (value: f64, substring: string, ok: bool) {
	result := fastfloat_parse_f64(raw_data(s), raw_data(s)[len(s):], &value, fmt)
	if result.ec == 0 {
		ok = true
		substring = s[:uintptr(result.ptr)-uintptr(raw_data(s))]
	} 
	return
}
