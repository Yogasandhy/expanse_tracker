import 'package:dartz/dartz.dart';
import '../entities/budget.dart';
import '../../core/error/failures.dart';

abstract class BudgetRepository {
  Future<Either<Failure, List<Budget>>> getAllBudgets();
  Future<Either<Failure, List<Budget>>> getActiveBudgets();
  Future<Either<Failure, Budget>> getBudgetById(String id);
  Future<Either<Failure, Budget?>> getBudgetByCategory(String categoryId);
  Future<Either<Failure, Budget>> addBudget(Budget budget);
  Future<Either<Failure, Budget>> updateBudget(Budget budget);
  Future<Either<Failure, void>> deleteBudget(String id);
  Future<Either<Failure, Budget>> updateBudgetSpent(String budgetId, double spentAmount);
}
