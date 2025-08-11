import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../entities/transaction.dart';
import '../repositories/transaction_repository.dart';
import '../../core/error/failures.dart';
import 'usecase.dart';

@injectable
class GetAllTransactions implements UseCase<List<Transaction>, NoParams> {
  final TransactionRepository repository;

  GetAllTransactions(this.repository);

  @override
  Future<Either<Failure, List<Transaction>>> call(NoParams params) async {
    return await repository.getAllTransactions();
  }
}

@injectable
class GetTransactionsByDateRange implements UseCase<List<Transaction>, GetTransactionsByDateRangeParams> {
  final TransactionRepository repository;

  GetTransactionsByDateRange(this.repository);

  @override
  Future<Either<Failure, List<Transaction>>> call(GetTransactionsByDateRangeParams params) async {
    return await repository.getTransactionsByDateRange(params.startDate, params.endDate);
  }
}

@injectable
class GetTransactionsByCategory implements UseCase<List<Transaction>, GetTransactionsByCategoryParams> {
  final TransactionRepository repository;

  GetTransactionsByCategory(this.repository);

  @override
  Future<Either<Failure, List<Transaction>>> call(GetTransactionsByCategoryParams params) async {
    return await repository.getTransactionsByCategory(params.categoryId);
  }
}

@injectable
class AddTransaction implements UseCase<Transaction, AddTransactionParams> {
  final TransactionRepository repository;

  AddTransaction(this.repository);

  @override
  Future<Either<Failure, Transaction>> call(AddTransactionParams params) async {
    return await repository.addTransaction(params.transaction);
  }
}

@injectable
class UpdateTransaction implements UseCase<Transaction, UpdateTransactionParams> {
  final TransactionRepository repository;

  UpdateTransaction(this.repository);

  @override
  Future<Either<Failure, Transaction>> call(UpdateTransactionParams params) async {
    return await repository.updateTransaction(params.transaction);
  }
}

@injectable
class DeleteTransaction implements UseCase<void, DeleteTransactionParams> {
  final TransactionRepository repository;

  DeleteTransaction(this.repository);

  @override
  Future<Either<Failure, void>> call(DeleteTransactionParams params) async {
    return await repository.deleteTransaction(params.id);
  }
}

@injectable
class SearchTransactions implements UseCase<List<Transaction>, SearchTransactionsParams> {
  final TransactionRepository repository;

  SearchTransactions(this.repository);

  @override
  Future<Either<Failure, List<Transaction>>> call(SearchTransactionsParams params) async {
    return await repository.searchTransactions(params.query);
  }
}

// Params classes
class GetTransactionsByDateRangeParams extends Equatable {
  final DateTime startDate;
  final DateTime endDate;

  const GetTransactionsByDateRangeParams({
    required this.startDate,
    required this.endDate,
  });

  @override
  List<Object> get props => [startDate, endDate];
}

class GetTransactionsByCategoryParams extends Equatable {
  final String categoryId;

  const GetTransactionsByCategoryParams({required this.categoryId});

  @override
  List<Object> get props => [categoryId];
}

class AddTransactionParams extends Equatable {
  final Transaction transaction;

  const AddTransactionParams({required this.transaction});

  @override
  List<Object> get props => [transaction];
}

class UpdateTransactionParams extends Equatable {
  final Transaction transaction;

  const UpdateTransactionParams({required this.transaction});

  @override
  List<Object> get props => [transaction];
}

class DeleteTransactionParams extends Equatable {
  final String id;

  const DeleteTransactionParams({required this.id});

  @override
  List<Object> get props => [id];
}

class SearchTransactionsParams extends Equatable {
  final String query;

  const SearchTransactionsParams({required this.query});

  @override
  List<Object> get props => [query];
}
