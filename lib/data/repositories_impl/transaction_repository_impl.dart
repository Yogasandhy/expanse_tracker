import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../../core/error/failures.dart';
import '../datasources/local_dummy_data_source.dart';
import '../models/transaction_model.dart';
import 'package:uuid/uuid.dart';

@LazySingleton(as: TransactionRepository)
class TransactionRepositoryImpl implements TransactionRepository {
  static const _uuid = Uuid();

  @override
  Future<Either<Failure, List<Transaction>>> getAllTransactions() async {
    try {
      final transactions = LocalDummyDataSource.transactions
          .map((model) => model.toEntity())
          .toList();
      
      // Sort by date descending
      transactions.sort((a, b) => b.date.compareTo(a.date));
      
      return Right(transactions);
    } catch (e) {
      return const Left(CacheFailure('Failed to get transactions'));
    }
  }

  @override
  Future<Either<Failure, List<Transaction>>> getTransactionsByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      final transactions = LocalDummyDataSource.transactions
          .where((model) {
            final date = DateTime.parse(model.date);
            return date.isAfter(startDate.subtract(const Duration(days: 1))) &&
                   date.isBefore(endDate.add(const Duration(days: 1)));
          })
          .map((model) => model.toEntity())
          .toList();
      
      transactions.sort((a, b) => b.date.compareTo(a.date));
      
      return Right(transactions);
    } catch (e) {
      return const Left(CacheFailure('Failed to get transactions by date range'));
    }
  }

  @override
  Future<Either<Failure, List<Transaction>>> getTransactionsByCategory(
    String categoryId,
  ) async {
    try {
      final transactions = LocalDummyDataSource.transactions
          .where((model) => model.categoryId == categoryId)
          .map((model) => model.toEntity())
          .toList();
      
      transactions.sort((a, b) => b.date.compareTo(a.date));
      
      return Right(transactions);
    } catch (e) {
      return const Left(CacheFailure('Failed to get transactions by category'));
    }
  }

  @override
  Future<Either<Failure, Transaction>> getTransactionById(String id) async {
    try {
      final model = LocalDummyDataSource.transactions
          .firstWhere((model) => model.id == id);
      
      return Right(model.toEntity());
    } catch (e) {
      return const Left(NotFoundFailure('Transaction not found'));
    }
  }

  @override
  Future<Either<Failure, Transaction>> addTransaction(Transaction transaction) async {
    try {
      final now = DateTime.now();
      final newTransaction = transaction.copyWith(
        id: _uuid.v4(),
        createdAt: now,
        updatedAt: now,
      );
      
      final model = TransactionModel.fromEntity(newTransaction);
      LocalDummyDataSource.addTransaction(model);
      
      return Right(newTransaction);
    } catch (e) {
      return const Left(CacheFailure('Failed to add transaction'));
    }
  }

  @override
  Future<Either<Failure, Transaction>> updateTransaction(Transaction transaction) async {
    try {
      final updatedTransaction = transaction.copyWith(
        updatedAt: DateTime.now(),
      );
      
      final model = TransactionModel.fromEntity(updatedTransaction);
      LocalDummyDataSource.updateTransaction(model);
      
      return Right(updatedTransaction);
    } catch (e) {
      return const Left(CacheFailure('Failed to update transaction'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTransaction(String id) async {
    try {
      LocalDummyDataSource.deleteTransaction(id);
      return const Right(null);
    } catch (e) {
      return const Left(CacheFailure('Failed to delete transaction'));
    }
  }

  @override
  Future<Either<Failure, List<Transaction>>> searchTransactions(String query) async {
    try {
      final transactions = LocalDummyDataSource.transactions
          .where((model) => 
              model.description.toLowerCase().contains(query.toLowerCase()))
          .map((model) => model.toEntity())
          .toList();
      
      transactions.sort((a, b) => b.date.compareTo(a.date));
      
      return Right(transactions);
    } catch (e) {
      return const Left(CacheFailure('Failed to search transactions'));
    }
  }
}
