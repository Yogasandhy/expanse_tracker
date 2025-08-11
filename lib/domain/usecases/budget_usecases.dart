import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../entities/budget.dart';
import '../repositories/budget_repository.dart';
import '../../core/error/failures.dart';
import 'usecase.dart';

class GetAllBudgets implements UseCase<List<Budget>, NoParams> {
  final BudgetRepository repository;

  GetAllBudgets(this.repository);

  @override
  Future<Either<Failure, List<Budget>>> call(NoParams params) async {
    return await repository.getAllBudgets();
  }
}

class AddBudget implements UseCase<Budget, AddBudgetParams> {
  final BudgetRepository repository;

  AddBudget(this.repository);

  @override
  Future<Either<Failure, Budget>> call(AddBudgetParams params) async {
    return await repository.addBudget(params.budget);
  }
}

class UpdateBudget implements UseCase<Budget, UpdateBudgetParams> {
  final BudgetRepository repository;

  UpdateBudget(this.repository);

  @override
  Future<Either<Failure, Budget>> call(UpdateBudgetParams params) async {
    return await repository.updateBudget(params.budget);
  }
}

class DeleteBudget implements UseCase<void, DeleteBudgetParams> {
  final BudgetRepository repository;

  DeleteBudget(this.repository);

  @override
  Future<Either<Failure, void>> call(DeleteBudgetParams params) async {
    return await repository.deleteBudget(params.id);
  }
}

// Params classes
class AddBudgetParams extends Equatable {
  final Budget budget;

  const AddBudgetParams({required this.budget});

  @override
  List<Object> get props => [budget];
}

class UpdateBudgetParams extends Equatable {
  final Budget budget;

  const UpdateBudgetParams({required this.budget});

  @override
  List<Object> get props => [budget];
}

class DeleteBudgetParams extends Equatable {
  final String id;

  const DeleteBudgetParams({required this.id});

  @override
  List<Object> get props => [id];
}
