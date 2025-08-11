import 'package:equatable/equatable.dart';

class Budget extends Equatable {
  final String id;
  final String categoryId;
  final double amount;
  final double spent;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Budget({
    required this.id,
    required this.categoryId,
    required this.amount,
    required this.spent,
    required this.startDate,
    required this.endDate,
    required this.createdAt,
    required this.updatedAt,
  });

  Budget copyWith({
    String? id,
    String? categoryId,
    double? amount,
    double? spent,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Budget(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      amount: amount ?? this.amount,
      spent: spent ?? this.spent,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  double get remaining => amount - spent;
  double get percentage => spent / amount;
  bool get isExceeded => spent > amount;
  bool get isActive {
    final now = DateTime.now();
    return now.isAfter(startDate) && now.isBefore(endDate);
  }

  @override
  List<Object?> get props => [
        id,
        categoryId,
        amount,
        spent,
        startDate,
        endDate,
        createdAt,
        updatedAt,
      ];
}
