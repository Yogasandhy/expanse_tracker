import 'package:equatable/equatable.dart';
import '../../../domain/entities/transaction.dart';

abstract class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object?> get props => [];
}

class LoadTransactions extends TransactionEvent {}

class LoadTransactionsByDateRange extends TransactionEvent {
  final DateTime startDate;
  final DateTime endDate;

  const LoadTransactionsByDateRange({
    required this.startDate,
    required this.endDate,
  });

  @override
  List<Object> get props => [startDate, endDate];
}

class LoadTransactionsByCategory extends TransactionEvent {
  final String categoryId;

  const LoadTransactionsByCategory({required this.categoryId});

  @override
  List<Object> get props => [categoryId];
}

class AddTransactionEvent extends TransactionEvent {
  final String description;
  final double amount;
  final TransactionType type;
  final String categoryId;
  final String subcategoryId;
  final String paymentMethodId;
  final DateTime date;

  const AddTransactionEvent({
    required this.description,
    required this.amount,
    required this.type,
    required this.categoryId,
    required this.subcategoryId,
    required this.paymentMethodId,
    required this.date,
  });

  @override
  List<Object> get props => [
        description,
        amount,
        type,
        categoryId,
        subcategoryId,
        paymentMethodId,
        date,
      ];
}

class UpdateTransactionEvent extends TransactionEvent {
  final Transaction transaction;

  const UpdateTransactionEvent({required this.transaction});

  @override
  List<Object> get props => [transaction];
}

class DeleteTransactionEvent extends TransactionEvent {
  final String id;

  const DeleteTransactionEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class SearchTransactions extends TransactionEvent {
  final String query;

  const SearchTransactions({required this.query});

  @override
  List<Object> get props => [query];
}
