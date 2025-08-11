import 'package:dartz/dartz.dart';
import '../entities/category.dart';
import '../../core/error/failures.dart';

abstract class CategoryRepository {
  Future<Either<Failure, List<Category>>> getAllCategories();
  Future<Either<Failure, List<Category>>> getIncomeCategories();
  Future<Either<Failure, List<Category>>> getExpenseCategories();
  Future<Either<Failure, Category>> getCategoryById(String id);
  Future<Either<Failure, List<Subcategory>>> getSubcategoriesByCategoryId(String categoryId);
  Future<Either<Failure, Subcategory>> getSubcategoryById(String id);
}
