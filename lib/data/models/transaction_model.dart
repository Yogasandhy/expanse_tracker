import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/transaction.dart';

part 'transaction_model.g.dart';

@JsonSerializable()
class TransactionModel {
  final String id;
  final String description;
  final double amount;
  final String type; // 'income' or 'expense'
  final String categoryId;
  final String subcategoryId;
  final String paymentMethodId;
  final String date; // ISO 8601 string
  final String createdAt; // ISO 8601 string
  final String updatedAt; // ISO 8601 string

  const TransactionModel({
    required this.id,
    required this.description,
    required this.amount,
    required this.type,
    required this.categoryId,
    required this.subcategoryId,
    required this.paymentMethodId,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionModelToJson(this);

  factory TransactionModel.fromEntity(Transaction transaction) {
    return TransactionModel(
      id: transaction.id,
      description: transaction.description,
      amount: transaction.amount,
      type: transaction.type == TransactionType.income ? 'income' : 'expense',
      categoryId: transaction.categoryId,
      subcategoryId: transaction.subcategoryId,
      paymentMethodId: transaction.paymentMethodId,
      date: transaction.date.toIso8601String(),
      createdAt: transaction.createdAt.toIso8601String(),
      updatedAt: transaction.updatedAt.toIso8601String(),
    );
  }

  Transaction toEntity() {
    return Transaction(
      id: id,
      description: description,
      amount: amount,
      type: type == 'income' ? TransactionType.income : TransactionType.expense,
      categoryId: categoryId,
      subcategoryId: subcategoryId,
      paymentMethodId: paymentMethodId,
      date: DateTime.parse(date),
      createdAt: DateTime.parse(createdAt),
      updatedAt: DateTime.parse(updatedAt),
    );
  }
}
