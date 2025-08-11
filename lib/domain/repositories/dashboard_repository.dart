import 'package:dartz/dartz.dart';
import '../entities/dashboard_summary.dart';
import '../../core/error/failures.dart';

abstract class DashboardRepository {
  Future<Either<Failure, DashboardSummary>> getDashboardSummary();
  Future<Either<Failure, DashboardSummary>> getDashboardSummaryByDateRange(
    DateTime startDate,
    DateTime endDate,
  );
  Future<Either<Failure, List<CategoryExpense>>> getExpenseByCategory(
    DateTime startDate,
    DateTime endDate,
  );
  Future<Either<Failure, List<MonthlyTrend>>> getMonthlyTrends(int year);
}
