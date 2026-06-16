import 'package:flutter_enterprise_boilerplate/features/products/domain/entities/product_category.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_category_model.freezed.dart';
part 'product_category_model.g.dart';

@freezed
abstract class ProductCategoryModel with _$ProductCategoryModel {
  const ProductCategoryModel._();

  const factory ProductCategoryModel({
    required String id,
    required String name,
    String? description,
    @JsonKey(name: 'image_url') String? imageUrl,  
    @JsonKey(name: 'parent_id') String? parentId,
    @JsonKey(name: 'product_count') @Default(0) int productCount,
    @Default([]) List<ProductCategoryModel> children,
  }) = _ProductCategoryModel;

  factory ProductCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$ProductCategoryModelFromJson(json);
  
  ProductCategory toEntity() {
    return ProductCategory(
      id: id,
      name: name,
      description: description,
      imageUrl: imageUrl,
      parentId: parentId,
      productCount: productCount,
      children: children.map((child) => child.toEntity()).toList(),
    );
  }
}

extension ProductCategoryExtension on ProductCategory {
  ProductCategoryModel toModel() {
    return ProductCategoryModel(
      id: id,
      name: name,
      description: description,
      imageUrl: imageUrl,
      parentId: parentId,
      productCount: productCount,
      children: children.map((child) => child.toModel()).toList(),
    );
  }
}