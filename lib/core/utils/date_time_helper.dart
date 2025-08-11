import 'package:intl/intl.dart';

class DateTimeHelper {
  static final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');
  static final DateFormat _timeFormat = DateFormat('HH:mm');
  static final DateFormat _monthYearFormat = DateFormat('MMMM yyyy');
  static final DateFormat _dayMonthFormat = DateFormat('dd MMM');
  static final DateFormat _fullDateTimeFormat = DateFormat('dd/MM/yyyy HH:mm');
  
  /// Format date to string (dd/MM/yyyy)
  static String formatDate(DateTime date) {
    return _dateFormat.format(date);
  }
  
  /// Format time to string (HH:mm)
  static String formatTime(DateTime date) {
    return _timeFormat.format(date);
  }
  
  /// Format date and time to string (dd/MM/yyyy HH:mm)
  static String formatDateTime(DateTime date) {
    return _fullDateTimeFormat.format(date);
  }
  
  /// Format date to month year (January 2024)
  static String formatMonthYear(DateTime date) {
    return _monthYearFormat.format(date);
  }
  
  /// Format date to day month (15 Jan)
  static String formatDayMonth(DateTime date) {
    return _dayMonthFormat.format(date);
  }
  
  /// Get relative time string (Today, Yesterday, etc.)
  static String getRelativeTime(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final dateOnly = DateTime(date.year, date.month, date.day);
    
    if (dateOnly == today) {
      return 'Today';
    } else if (dateOnly == yesterday) {
      return 'Yesterday';
    } else if (dateOnly.isAfter(today.subtract(const Duration(days: 7)))) {
      return DateFormat('EEEE').format(date); // Day name
    } else if (dateOnly.year == now.year) {
      return formatDayMonth(date);
    } else {
      return formatDate(date);
    }
  }
  
  /// Get start of month
  static DateTime getStartOfMonth(DateTime date) {
    return DateTime(date.year, date.month, 1);
  }
  
  /// Get end of month
  static DateTime getEndOfMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0, 23, 59, 59);
  }
  
  /// Get start of year
  static DateTime getStartOfYear(DateTime date) {
    return DateTime(date.year, 1, 1);
  }
  
  /// Get end of year
  static DateTime getEndOfYear(DateTime date) {
    return DateTime(date.year, 12, 31, 23, 59, 59);
  }
  
  /// Check if two dates are in same month
  static bool isSameMonth(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month;
  }
  
  /// Check if two dates are in same day
  static bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year && 
           date1.month == date2.month && 
           date1.day == date2.day;
  }
  
  /// Get list of months for current year
  static List<DateTime> getMonthsInYear(int year) {
    return List.generate(12, (index) => DateTime(year, index + 1, 1));
  }
  
  /// Parse date string to DateTime
  static DateTime? parseDate(String dateString) {
    try {
      return _dateFormat.parse(dateString);
    } catch (e) {
      return null;
    }
  }
  
  /// Get age of date in days
  static int getDaysAgo(DateTime date) {
    final now = DateTime.now();
    return now.difference(date).inDays;
  }
}
