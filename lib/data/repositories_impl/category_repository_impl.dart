import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/category.dart';
import '../../domain/repositories/category_repository.dart';
import '../../core/error/failures.dart';
import '../datasources/local_dummy_data_source.dart';

@LazySingleton(as: CategoryRepository)
class CategoryRepositoryImpl implements CategoryRepository {
  @override
  Future<Either<Failure, List<Category>>> getAllCategories() async {
    try {
      final categories = LocalDummyDataSource.categories
          .map((model) => model.toEntity())
          .toList();
      
      return Right(categories);
    } catch (e) {
      return const Left(CacheFailure('Failed to get categories'));
    }
  }

  @override
  Future<Either<Failure, List<Category>>> getIncomeCategories() async {
    try {
      final categories = LocalDummyDataSource.categories
          .where((model) => model.isIncomeCategory)
          .map((model) => model.toEntity())
          .toList();
      
      return Right(categories);
    } catch (e) {
      return const Left(CacheFailure('Failed to get income categories'));
    }
  }

  @override
  Future<Either<Failure, List<Category>>> getExpenseCategories() async {
    try {
      final categories = LocalDummyDataSource.categories
          .where((model) => !model.isIncomeCategory)
          .map((model) => model.toEntity())
          .toList();
      
      return Right(categories);
    } catch (e) {
      return const Left(CacheFailure('Failed to get expense categories'));
    }
  }

  @override
  Future<Either<Failure, Category>> getCategoryById(String id) async {
    try {
      final model = LocalDummyDataSource.categories
          .firstWhere((model) => model.id == id);
      
      return Right(model.toEntity());
    } catch (e) {
      return const Left(NotFoundFailure('Category not found'));
    }
  }

  @override
  Future<Either<Failure, List<Subcategory>>> getSubcategoriesByCategoryId(
    String categoryId,
  ) async {
    try {
      final category = LocalDummyDataSource.categories
          .firstWhere((model) => model.id == categoryId);
      
      final subcategories = category.subcategories
          .map((model) => model.toEntity())
          .toList();
      
      return Right(subcategories);
    } catch (e) {
      return const Left(NotFoundFailure('Subcategories not found'));
    }
  }

  @override
  Future<Either<Failure, Subcategory>> getSubcategoryById(String id) async {
    try {
      for (final category in LocalDummyDataSource.categories) {
        for (final subcategory in category.subcategories) {
          if (subcategory.id == id) {
            return Right(subcategory.toEntity());
          }
        }
      }
      
      return const Left(NotFoundFailure('Subcategory not found'));
    } catch (e) {
      return const Left(CacheFailure('Failed to get subcategory'));
    }
  }
}
