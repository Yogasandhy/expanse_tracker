import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String id;
  final String name;
  final String iconName;
  final String colorHex;
  final bool isIncomeCategory;
  final List<Subcategory> subcategories;

  const Category({
    required this.id,
    required this.name,
    required this.iconName,
    required this.colorHex,
    required this.isIncomeCategory,
    required this.subcategories,
  });

  Category copyWith({
    String? id,
    String? name,
    String? iconName,
    String? colorHex,
    bool? isIncomeCategory,
    List<Subcategory>? subcategories,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      iconName: iconName ?? this.iconName,
      colorHex: colorHex ?? this.colorHex,
      isIncomeCategory: isIncomeCategory ?? this.isIncomeCategory,
      subcategories: subcategories ?? this.subcategories,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        iconName,
        colorHex,
        isIncomeCategory,
        subcategories,
      ];
}

class Subcategory extends Equatable {
  final String id;
  final String name;
  final String iconName;
  final String categoryId;

  const Subcategory({
    required this.id,
    required this.name,
    required this.iconName,
    required this.categoryId,
  });

  Subcategory copyWith({
    String? id,
    String? name,
    String? iconName,
    String? categoryId,
  }) {
    return Subcategory(
      id: id ?? this.id,
      name: name ?? this.name,
      iconName: iconName ?? this.iconName,
      categoryId: categoryId ?? this.categoryId,
    );
  }

  @override
  List<Object?> get props => [id, name, iconName, categoryId];
}
