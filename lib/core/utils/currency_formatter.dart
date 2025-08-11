import 'package:intl/intl.dart';

class CurrencyFormatter {
  static final NumberFormat _currencyFormat = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );
  
  static final NumberFormat _numberFormat = NumberFormat('#,##0', 'id_ID');
  
  /// Format amount to currency string
  static String formatCurrency(double amount) {
    return _currencyFormat.format(amount);
  }
  
  /// Format amount to number string without currency symbol
  static String formatNumber(double amount) {
    return _numberFormat.format(amount);
  }
  
  /// Parse currency string to double
  static double parseCurrency(String currencyString) {
    // Remove currency symbol and whitespace
    String cleanString = currencyString
        .replaceAll('Rp', '')
        .replaceAll(' ', '')
        .replaceAll('.', '')
        .replaceAll(',', '.');
    
    return double.tryParse(cleanString) ?? 0.0;
  }
  
  /// Format amount with sign (+ for income, - for expense)
  static String formatAmountWithSign(double amount, bool isIncome) {
    String formattedAmount = formatCurrency(amount.abs());
    return isIncome ? '+$formattedAmount' : '-$formattedAmount';
  }
  
  /// Get short format for large amounts (e.g., 1.2M, 500K)
  static String getShortFormat(double amount) {
    if (amount.abs() >= 1000000000) {
      return '${(amount / 1000000000).toStringAsFixed(1)}B';
    } else if (amount.abs() >= 1000000) {
      return '${(amount / 1000000).toStringAsFixed(1)}M';
    } else if (amount.abs() >= 1000) {
      return '${(amount / 1000).toStringAsFixed(1)}K';
    } else {
      return amount.toStringAsFixed(0);
    }
  }
}
