import 'package:dartz/dartz.dart';
import '../../domain/entities/category.dart';
import '../../domain/repositories/category_repository.dart';
import '../../core/error/failures.dart';
import '../datasources/supabase_data_source.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final SupabaseDataSource _supabaseDataSource;

  CategoryRepositoryImpl(this._supabaseDataSource);

  @override
  Future<Either<Failure, List<Category>>> getAllCategories() async {
    try {
      final categoryModels = await _supabaseDataSource.getAllCategories();
      final categories = categoryModels
          .map((model) => model.toEntity())
          .toList();
      
      return Right(categories);
    } catch (e) {
      if (e is DatabaseFailure) {
        return Left(e);
      }
      return Left(DatabaseFailure('Failed to get categories: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<Category>>> getIncomeCategories() async {
    try {
      final categoryModels = await _supabaseDataSource.getAllCategories();
      final categories = categoryModels
          .where((model) => model.isIncomeCategory == true)
          .map((model) => model.toEntity())
          .toList();
      
      return Right(categories);
    } catch (e) {
      if (e is DatabaseFailure) {
        return Left(e);
      }
      return Left(DatabaseFailure('Failed to get income categories: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<Category>>> getExpenseCategories() async {
    try {
      final categoryModels = await _supabaseDataSource.getAllCategories();
      final categories = categoryModels
          .where((model) => model.isIncomeCategory != true)
          .map((model) => model.toEntity())
          .toList();
      
      return Right(categories);
    } catch (e) {
      if (e is DatabaseFailure) {
        return Left(e);
      }
      return Left(DatabaseFailure('Failed to get expense categories: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Category>> getCategoryById(String id) async {
    try {
      final categoryModel = await _supabaseDataSource.getCategoryById(id);
      return Right(categoryModel.toEntity());
    } catch (e) {
      if (e is DatabaseFailure) {
        return Left(e);
      }
      return Left(DatabaseFailure('Failed to get category: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<Subcategory>>> getSubcategoriesByCategoryId(
    String categoryId,
  ) async {
    try {
      // For now, return empty list since subcategories are optional
      // In the future, this can be implemented when subcategories table is needed
      return const Right([]);
    } catch (e) {
      return Left(DatabaseFailure('Failed to get subcategories: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Subcategory>> getSubcategoryById(String id) async {
    try {
      // For now, return a simple subcategory since it's optional
      // This prevents app from crashing when subcategory ID is referenced
      final defaultSubcategory = Subcategory(
        id: id,
        name: 'General',
        iconName: 'category',
        categoryId: id.substring(0, 36), // Extract category ID from subcategory ID
      );
      
      return Right(defaultSubcategory);
    } catch (e) {
      return Left(DatabaseFailure('Failed to get subcategory: ${e.toString()}'));
    }
  }
}
