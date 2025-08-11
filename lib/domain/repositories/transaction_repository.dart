import 'package:dartz/dartz.dart';
import '../entities/transaction.dart';
import '../../core/error/failures.dart';

abstract class TransactionRepository {
  Future<Either<Failure, List<Transaction>>> getAllTransactions();
  Future<Either<Failure, List<Transaction>>> getTransactionsByDateRange(
    DateTime startDate,
    DateTime endDate,
  );
  Future<Either<Failure, List<Transaction>>> getTransactionsByCategory(
    String categoryId,
  );
  Future<Either<Failure, Transaction>> getTransactionById(String id);
  Future<Either<Failure, Transaction>> addTransaction(Transaction transaction);
  Future<Either<Failure, Transaction>> updateTransaction(Transaction transaction);
  Future<Either<Failure, void>> deleteTransaction(String id);
  Future<Either<Failure, List<Transaction>>> searchTransactions(String query);
}
