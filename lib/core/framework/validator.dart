class AppValidator {
  /// Helper method to validate for malicious patterns

  /// Validate Email
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    }

    // Email-specific validation
    final RegExp emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    final RegExp emailRegexTwo = RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$');

    if (!emailRegexTwo.hasMatch(value)) {
      return 'Enter valid Gmail address ending with @gmail.com';
    }
    return null; // Email is valid
  }

  static String? validateMessage(String? value) {
    if (value == null || value.isEmpty) {
      return 'Message cannot be empty';
    }

    return null; // Email is valid
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    }

    // Password-specific validation
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one digit';
    }
    if (!RegExp(r'[#?!@$%^&*-]').hasMatch(value)) {
      return 'Password must contain at least one special character';
    }

    return null; // Password is valid
  }

  static String? validateLoginPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    }

    return null; // Password is valid
  }

  static String? validateConfirmPassword(String? value, password) {
    if (value == null || value.isEmpty) {
      return 'Confirm Password cannot be empty';
    }

    // Password-specific validation
    if (password != value) {
      return 'Passwords do not match';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one digit';
    }
    if (!RegExp(r'[#?!@$%^&*-]').hasMatch(value)) {
      return 'Password must contain at least one special character';
    }

    return null; // Password is valid
  }

  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number cannot be empty';
    }
    // Phone-specific validation
    if (value.length != 11) {
      return 'Phone number must be 11 digits long';
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Phone number must contain only digits';
    }
    if (!RegExp(r'^\d{11}$').hasMatch(value)) {
      return 'Phone number must be 11 digits and contain only numbers';
    }
    return null; // Phone number is valid
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name cannot be empty';
    }
    final RegExp nameRegex = RegExp(r'^[a-zA-Z\s]+$');
    if (!nameRegex.hasMatch(value)) {
      return 'Name can only contain letters and spaces';
    }
    if (value.length < 3) {
      return 'Name must be at least 3 characters long';
    }

    return null;
  }

  static String? validateUserName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Username cannot be empty';
    }

    value = value.trim();

    if (value.length < 3 || value.length > 20) {
      return 'Username must be between 3 and 20 characters long';
    }

    // تأكد إنه مفيش مسافات
    if (value.contains(' ')) {
      return 'Username must not contain spaces';
    }

    // مسموح فقط بالحروف الإنجليزية، الأرقام، والرموز البسيطة
    final RegExp allowed = RegExp(r'^[a-zA-Z0-9_.-]+$');
    if (!allowed.hasMatch(value)) {
      return 'Username can only contain letters, numbers, _, -, or .';
    }

    // لازم فيه حرف واحد على الأقل
    if (!RegExp(r'[a-zA-Z]').hasMatch(value)) {
      return 'Username must include at least one letter';
    }

    // لازم فيه رقم واحد على الأقل
    if (!RegExp(r'\d').hasMatch(value)) {
      return 'Username must include at least one number';
    }

    // لازم فيه رمز واحد على الأقل من التلاتة دول
    if (!RegExp(r'[_.-]').hasMatch(value)) {
      return 'Username must include at least one symbol (_, -, .)';
    }

    // لا يبدأ أو ينتهي برمز
    if (RegExp(r'^[_.-]|[_.-]$').hasMatch(value)) {
      return 'Username must not start or end with a symbol';
    }

    // لا يحتوي على رمزين متتاليين متشابهين
    if (RegExp(r'(\.\.|--|__)').hasMatch(value)) {
      return 'Username must not contain repeated symbols like .., __, or --';
    }

    return null;
  }
}
