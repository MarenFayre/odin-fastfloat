#include "fastfloat.3.9.0.h"

using namespace fast_float;
extern "C" {
	from_chars_result fastfloat_parse_f32(const char *first, const char *last, float &value, chars_format fmt) {
		return from_chars<float>(first, last, value, fmt);
	}
	from_chars_result fastfloat_parse_f64(const char *first, const char *last, double &value, chars_format fmt) {
		return from_chars<double>(first, last, value, fmt);
	}
}
