// import 'dart:convert';

// dynamic parseJsonSafely(String raw) {
//   try {
//     // Try direct parse
//     return jsonDecode(raw);
//   } catch (_) {
//     // Try to clean markdown wrapping (e.g., ```json ... ```)
//     final cleaned = raw
//         .replaceAll(RegExp(r'```json'), '')
//         .replaceAll(RegExp(r'```'), '');
//     return jsonDecode(cleaned);
//   }
// }

import 'dart:convert';

/// Safely parse a JSON string, even if AI wraps it in markdown or extra text
dynamic parseJsonSafely(String raw) {
  try {
    // Try direct parse first
    return jsonDecode(raw);
  } catch (_) {
    // Remove markdown code fences and trim whitespace
    String cleaned = raw
        .replaceAll(RegExp(r'```json', caseSensitive: false), '')
        .replaceAll(RegExp(r'```', caseSensitive: false), '')
        .trim();

    // Try to extract JSON substring using first { to last }
    final start = cleaned.indexOf('{');
    final end = cleaned.lastIndexOf('}');
    if (start != -1 && end != -1 && end > start) {
      final jsonSubstring = cleaned.substring(start, end + 1);
      try {
        return jsonDecode(jsonSubstring);
      } catch (e) {
        print("Failed parsing JSON substring: $e");
        return null;
      }
    }
    print("Failed to parse JSON from raw response");
    return null;
  }
}
