import 'package:equatable/equatable.dart';

class DashboardSummary extends Equatable {
  final double totalIncome;
  final double totalExpense;
  final double balance;
  final List<CategoryExpense> expenseByCategory;
  final List<MonthlyTrend> monthlyTrends;

  const DashboardSummary({
    required this.totalIncome,
    required this.totalExpense,
    required this.balance,
    required this.expenseByCategory,
    required this.monthlyTrends,
  });

  @override
  List<Object?> get props => [
        totalIncome,
        totalExpense,
        balance,
        expenseByCategory,
        monthlyTrends,
      ];
}

class CategoryExpense extends Equatable {
  final String categoryId;
  final String categoryName;
  final double amount;
  final double percentage;
  final String colorHex;

  const CategoryExpense({
    required this.categoryId,
    required this.categoryName,
    required this.amount,
    required this.percentage,
    required this.colorHex,
  });

  @override
  List<Object?> get props => [
        categoryId,
        categoryName,
        amount,
        percentage,
        colorHex,
      ];
}

class MonthlyTrend extends Equatable {
  final String month;
  final double income;
  final double expense;
  final double balance;

  const MonthlyTrend({
    required this.month,
    required this.income,
    required this.expense,
    required this.balance,
  });

  @override
  List<Object?> get props => [month, income, expense, balance];
}
