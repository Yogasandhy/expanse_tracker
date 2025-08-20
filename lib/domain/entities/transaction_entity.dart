import 'package:equatable/equatable.dart';

enum TransactionType { income, expense }

class Transaction extends Equatable {
  final String id;
  final String description;
  final double amount;
  final TransactionType type;
  final String categoryId;
  final String? subcategoryId;
  final String paymentMethodId;
  final DateTime date;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Transaction({
    required this.id,
    required this.description,
    required this.amount,
    required this.type,
    required this.categoryId,
    this.subcategoryId,
    required this.paymentMethodId,
    required this.date,
    this.createdAt,
    this.updatedAt,
  });

  Transaction copyWith({
    String? id,
    String? description,
    double? amount,
    TransactionType? type,
    String? categoryId,
    String? subcategoryId,
    String? paymentMethodId,
    DateTime? date,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Transaction(
      id: id ?? this.id,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      categoryId: categoryId ?? this.categoryId,
      subcategoryId: subcategoryId ?? this.subcategoryId,
      paymentMethodId: paymentMethodId ?? this.paymentMethodId,
      date: date ?? this.date,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  bool get isIncome => type == TransactionType.income;
  bool get isExpense => type == TransactionType.expense;

  String get typeString {
    switch (type) {
      case TransactionType.income:
        return 'income';
      case TransactionType.expense:
        return 'expense';
    }
  }

  @override
  List<Object?> get props => [
        id,
        description,
        amount,
        type,
        categoryId,
        subcategoryId,
        paymentMethodId,
        date,
        createdAt,
        updatedAt,
      ];
}
