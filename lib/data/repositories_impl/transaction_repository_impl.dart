import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/transaction_entity.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../../core/error/failures.dart';
import '../datasources/supabase_data_source.dart';
import '../models/transaction_model.dart';

@LazySingleton(as: TransactionRepository)
class TransactionRepositoryImpl implements TransactionRepository {
  final SupabaseDataSource _supabaseDataSource;

  TransactionRepositoryImpl(this._supabaseDataSource);

  @override
  Future<Either<Failure, List<Transaction>>> getAllTransactions() async {
    try {
      final transactionModels = await _supabaseDataSource.getAllTransactions();
      final transactions = transactionModels
          .map((model) => model.toEntity())
          .toList();
      
      return Right(transactions);
    } catch (e) {
      if (e is DatabaseFailure) {
        return Left(e);
      }
      return Left(DatabaseFailure('Failed to get transactions: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<Transaction>>> getTransactionsByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      // Get all transactions first (you can optimize this with SQL queries later)
      final transactionModels = await _supabaseDataSource.getAllTransactions();
      final transactions = transactionModels
          .where((model) {
            final date = DateTime.parse(model.date);
            return date.isAfter(startDate.subtract(const Duration(days: 1))) &&
                   date.isBefore(endDate.add(const Duration(days: 1)));
          })
          .map((model) => model.toEntity())
          .toList();
      
      return Right(transactions);
    } catch (e) {
      if (e is DatabaseFailure) {
        return Left(e);
      }
      return Left(DatabaseFailure('Failed to get transactions by date range: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<Transaction>>> getTransactionsByCategory(
    String categoryId,
  ) async {
    try {
      // Get all transactions first (you can optimize this with SQL queries later)
      final transactionModels = await _supabaseDataSource.getAllTransactions();
      final transactions = transactionModels
          .where((model) => model.categoryId == categoryId)
          .map((model) => model.toEntity())
          .toList();
      
      return Right(transactions);
    } catch (e) {
      if (e is DatabaseFailure) {
        return Left(e);
      }
      return Left(DatabaseFailure('Failed to get transactions by category: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Transaction>> getTransactionById(String id) async {
    try {
      final transactionModel = await _supabaseDataSource.getTransactionById(id);
      return Right(transactionModel.toEntity());
    } catch (e) {
      if (e is DatabaseFailure) {
        return Left(e);
      }
      return Left(DatabaseFailure('Failed to get transaction: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Transaction>> addTransaction(Transaction transaction) async {
    try {
      print('🗄️ [TransactionRepository] Converting entity to model...');
      final transactionModel = TransactionModel.fromEntity(transaction);
      
      print('📤 [TransactionRepository] Calling data source to save transaction...');
      print('💰 [TransactionRepository] Amount: ${transactionModel.amount}');
      print('📝 [TransactionRepository] Description: ${transactionModel.description}');
      print('🔖 [TransactionRepository] Type: ${transactionModel.type}');
      
      final addedModel = await _supabaseDataSource.addTransaction(transactionModel);
      
      print('✅ [TransactionRepository] Data source returned success!');
      print('🆔 [TransactionRepository] Saved transaction ID: ${addedModel.id}');
      
      return Right(addedModel.toEntity());
    } catch (e) {
      print('❌ [TransactionRepository] Error occurred: ${e.toString()}');
      if (e is DatabaseFailure) {
        return Left(e);
      }
      return Left(DatabaseFailure('Failed to add transaction: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Transaction>> updateTransaction(Transaction transaction) async {
    try {
      final transactionModel = TransactionModel.fromEntity(transaction);
      final updatedModel = await _supabaseDataSource.updateTransaction(transactionModel);
      
      return Right(updatedModel.toEntity());
    } catch (e) {
      if (e is DatabaseFailure) {
        return Left(e);
      }
      return Left(DatabaseFailure('Failed to update transaction: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTransaction(String id) async {
    try {
      await _supabaseDataSource.deleteTransaction(id);
      return const Right(null);
    } catch (e) {
      if (e is DatabaseFailure) {
        return Left(e);
      }
      return Left(DatabaseFailure('Failed to delete transaction: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<Transaction>>> searchTransactions(String query) async {
    try {
      // Get all transactions first (you can optimize this with SQL queries later)
      final transactionModels = await _supabaseDataSource.getAllTransactions();
      final transactions = transactionModels
          .where((model) => 
            model.description.toLowerCase().contains(query.toLowerCase()))
          .map((model) => model.toEntity())
          .toList();
      
      return Right(transactions);
    } catch (e) {
      if (e is DatabaseFailure) {
        return Left(e);
      }
      return Left(DatabaseFailure('Failed to search transactions: ${e.toString()}'));
    }
  }
}
