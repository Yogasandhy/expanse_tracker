import 'dart:math' as math;

class ValidationHelper {
  /// Validate amount input
  static String? validateAmount(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Amount is required';
    }
    
    final amount = double.tryParse(value.replaceAll(RegExp(r'[,.]'), ''));
    if (amount == null || amount <= 0) {
      return 'Please enter a valid amount';
    }
    
    if (amount > 999999999999) {
      return 'Amount is too large';
    }
    
    return null;
  }
  
  /// Validate description input
  static String? validateDescription(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Description is required';
    }
    
    if (value.trim().length < 3) {
      return 'Description must be at least 3 characters';
    }
    
    if (value.trim().length > 100) {
      return 'Description must be less than 100 characters';
    }
    
    return null;
  }
  
  /// Validate category selection
  static String? validateCategory(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please select a category';
    }
    
    return null;
  }
  
  /// Validate payment method selection
  static String? validatePaymentMethod(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please select a payment method';
    }
    
    return null;
  }
  
  /// Validate PIN input
  static String? validatePIN(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'PIN is required';
    }
    
    if (value.length != 4) {
      return 'PIN must be 4 digits';
    }
    
    if (!RegExp(r'^\d{4}$').hasMatch(value)) {
      return 'PIN must contain only numbers';
    }
    
    return null;
  }
  
  /// Validate budget amount
  static String? validateBudget(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Budget amount is required';
    }
    
    final amount = double.tryParse(value.replaceAll(RegExp(r'[,.]'), ''));
    if (amount == null || amount < 0) {
      return 'Please enter a valid budget amount';
    }
    
    if (amount > 999999999999) {
      return 'Budget amount is too large';
    }
    
    return null;
  }
  
  /// Check if email is valid
  static bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
  
  /// Check if phone number is valid (Indonesian format)
  static bool isValidPhoneNumber(String phone) {
    return RegExp(r'^(\+62|62|0)[0-9]{9,12}$').hasMatch(phone);
  }
  
  /// Generate random PIN
  static String generateRandomPIN() {
    final random = math.Random();
    return List.generate(4, (index) => random.nextInt(10)).join();
  }
  
  /// Check if string contains only numbers
  static bool isNumeric(String str) {
    return RegExp(r'^[0-9]+$').hasMatch(str);
  }
  
  /// Clean amount string for parsing
  static String cleanAmountString(String amount) {
    return amount
        .replaceAll('Rp', '')
        .replaceAll(' ', '')
        .replaceAll('.', '')
        .replaceAll(',', '');
  }
}
