import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_category.freezed.dart';

@freezed
abstract class ProductCategory with _$ProductCategory {
  const ProductCategory._();

  const factory ProductCategory({
    required String id,
    required String name,
    String? description,
    String? imageUrl,
    String? parentId,
    @Default(0) int productCount,
    @Default([]) List<ProductCategory> children,
  }) = _ProductCategory;

}