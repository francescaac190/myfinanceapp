class Validators {
  static final _emailRegex = RegExp(r'^[\w\.\-]+@([\w\-]+\.)+[\w\-]{2,}$');

  static String? required(String? value, {String field = 'Field'}) {
    if (value == null || value.trim().isEmpty) return '$field is required';
    return null;
  }

  static String? name(String? value, {String field = 'Name'}) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return '$field is required';
    if (v.length < 2) return '$field must be at least 2 characters';
    if (v.length > 50) return '$field must be at most 50 characters';
    return null;
  }

  static String? email(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return 'Email is required';
    if (!_emailRegex.hasMatch(v)) return 'Enter a valid email';
    return null;
  }

  static String? password(String? value) {
    final v = value ?? '';
    if (v.isEmpty) return 'Password is required';
    if (v.length < 8) return 'Password must be at least 8 characters';
    if (!RegExp('[A-Za-z]').hasMatch(v)) {
      return 'Password must contain a letter';
    }
    if (!RegExp(r'\d').hasMatch(v)) return 'Password must contain a number';
    return null;
  }
}
