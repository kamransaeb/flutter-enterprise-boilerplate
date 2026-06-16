import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_review.freezed.dart';

@freezed
abstract class ProductReview with _$ProductReview {
  const ProductReview._();
  
  const factory ProductReview({
    required String id,
    required String productId,
    required String userId,
    required String userName,
    String? userAvatar,
    required double rating,
    required String comment,
    required DateTime createdAt,
    @Default([]) List<String> likes,
    @Default([]) List<String> dislikes,
    @Default(false) bool verifiedPurchase,
  }) = _ProductReview;

}

