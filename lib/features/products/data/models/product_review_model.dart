import 'package:flutter_enterprise_boilerplate/features/products/domain/entities/product_review.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_review_model.freezed.dart';
part 'product_review_model.g.dart';

@freezed 
abstract class ProductReviewModel with _$ProductReviewModel {
  const ProductReviewModel._();
  
  const factory ProductReviewModel({
    required String id,
    @JsonKey(name: 'product_id') required String productId,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'user_name') required String userName,
    @JsonKey(name: 'user_avatar') String? userAvatar,
    required double rating,
    required String comment,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @Default([]) List<String> likes,
    @Default([]) List<String> dislikes,
    @JsonKey(name: 'verified_purchase') @Default(false) bool verifiedPurchase,
  }) = _ProductReviewModel;

  factory ProductReviewModel.fromJson(Map<String, dynamic> json) =>
    _$ProductReviewModelFromJson(json);

  ProductReview toEntity() {
    return ProductReview(
      id: id,
      productId: productId,
      userId: userId,
      userName: userName,
      userAvatar: userAvatar,
      rating: rating,
      comment: comment,
      createdAt: createdAt,
      likes: likes,
      dislikes: dislikes,
      verifiedPurchase: verifiedPurchase,
    );
  }
}

extension ProductReviewExtension on ProductReview {
  ProductReviewModel toModel() {
    return ProductReviewModel(
      id: id,
      productId: productId,
      userId: userId,
      userName: userName,
      userAvatar: userAvatar,
      rating: rating,
      comment: comment,
      createdAt: createdAt,
      likes: likes,
      dislikes: dislikes,
      verifiedPurchase: verifiedPurchase,
    );
  }
}