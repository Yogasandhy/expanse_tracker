import 'package:dartz/dartz.dart';
import '../entities/dashboard_summary.dart';
import '../repositories/dashboard_repository.dart';
import '../../core/error/failures.dart';
import 'usecase.dart';

class GetDashboardSummary implements UseCase<DashboardSummary, NoParams> {
  final DashboardRepository repository;

  GetDashboardSummary(this.repository);

  @override
  Future<Either<Failure, DashboardSummary>> call(NoParams params) async {
    return await repository.getDashboardSummary();
  }
}
