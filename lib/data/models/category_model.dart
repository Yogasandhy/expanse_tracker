import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/category.dart';

part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel {
  final String id;
  final String name;
  final String? iconName;
  final String? colorHex;
  final bool? isIncomeCategory;
  final List<SubcategoryModel>? subcategories;

  const CategoryModel({
    required this.id,
    required this.name,
    this.iconName,
    this.colorHex,
    this.isIncomeCategory,
    this.subcategories,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);

  factory CategoryModel.fromEntity(Category category) {
    return CategoryModel(
      id: category.id,
      name: category.name,
      iconName: category.iconName,
      colorHex: category.colorHex,
      isIncomeCategory: category.isIncomeCategory,
      subcategories: category.subcategories
          .map((sub) => SubcategoryModel.fromEntity(sub))
          .toList(),
    );
  }

  Category toEntity() {
    return Category(
      id: id,
      name: name,
      iconName: iconName ?? 'category',
      colorHex: colorHex ?? '#64748B',
      isIncomeCategory: isIncomeCategory ?? false,
      subcategories: subcategories?.map((sub) => sub.toEntity()).toList() ?? [],
    );
  }
}

@JsonSerializable()
class SubcategoryModel {
  final String id;
  final String name;
  final String iconName;
  final String categoryId;

  const SubcategoryModel({
    required this.id,
    required this.name,
    required this.iconName,
    required this.categoryId,
  });

  factory SubcategoryModel.fromJson(Map<String, dynamic> json) =>
      _$SubcategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubcategoryModelToJson(this);

  factory SubcategoryModel.fromEntity(Subcategory subcategory) {
    return SubcategoryModel(
      id: subcategory.id,
      name: subcategory.name,
      iconName: subcategory.iconName,
      categoryId: subcategory.categoryId,
    );
  }

  Subcategory toEntity() {
    return Subcategory(
      id: id,
      name: name,
      iconName: iconName,
      categoryId: categoryId,
    );
  }
}
