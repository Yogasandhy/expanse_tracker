import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/transaction_entity.dart';

part 'transaction_model.g.dart';

@JsonSerializable()
class TransactionModel {
  final String id;
  final String description;
  final double amount;
  final String type; // 'income' or 'expense'
  @JsonKey(name: 'category_id')
  final String categoryId;
  @JsonKey(name: 'subcategory_id')
  final String? subcategoryId; // Made nullable
  final String date; // ISO 8601 string
  @JsonKey(name: 'created_at')
  final String? createdAt; // Made nullable
  @JsonKey(name: 'updated_at')
  final String? updatedAt; // Made nullable

  const TransactionModel({
    required this.id,
    required this.description,
    required this.amount,
    required this.type,
    required this.categoryId,
    this.subcategoryId, // Made optional
    required this.date,
    this.createdAt, // Made optional
    this.updatedAt, // Made optional
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
      date: transaction.date.toIso8601String(),
      createdAt: transaction.createdAt?.toIso8601String(),
      updatedAt: transaction.updatedAt?.toIso8601String(),
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
      date: DateTime.parse(date),
      createdAt: createdAt != null ? DateTime.parse(createdAt!) : null,
      updatedAt: updatedAt != null ? DateTime.parse(updatedAt!) : null,
    );
  }
}
