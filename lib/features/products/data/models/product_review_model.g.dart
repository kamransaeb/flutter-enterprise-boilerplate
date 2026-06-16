// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_review_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProductReviewModel _$ProductReviewModelFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_ProductReviewModel',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      allowedKeys: const [
        'id',
        'product_id',
        'user_id',
        'user_name',
        'user_avatar',
        'rating',
        'comment',
        'created_at',
        'likes',
        'dislikes',
        'verified_purchase',
      ],
    );
    final val = _ProductReviewModel(
      id: $checkedConvert('id', (v) => v as String),
      productId: $checkedConvert('product_id', (v) => v as String),
      userId: $checkedConvert('user_id', (v) => v as String),
      userName: $checkedConvert('user_name', (v) => v as String),
      userAvatar: $checkedConvert('user_avatar', (v) => v as String?),
      rating: $checkedConvert('rating', (v) => (v as num).toDouble()),
      comment: $checkedConvert('comment', (v) => v as String),
      createdAt: $checkedConvert(
        'created_at',
        (v) => DateTime.parse(v as String),
      ),
      likes: $checkedConvert(
        'likes',
        (v) =>
            (v as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
      ),
      dislikes: $checkedConvert(
        'dislikes',
        (v) =>
            (v as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
      ),
      verifiedPurchase: $checkedConvert(
        'verified_purchase',
        (v) => v as bool? ?? false,
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'productId': 'product_id',
    'userId': 'user_id',
    'userName': 'user_name',
    'userAvatar': 'user_avatar',
    'createdAt': 'created_at',
    'verifiedPurchase': 'verified_purchase',
  },
);

Map<String, dynamic> _$ProductReviewModelToJson(_ProductReviewModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'product_id': instance.productId,
      'user_id': instance.userId,
      'user_name': instance.userName,
      'user_avatar': instance.userAvatar,
      'rating': instance.rating,
      'comment': instance.comment,
      'created_at': instance.createdAt.toIso8601String(),
      'likes': instance.likes,
      'dislikes': instance.dislikes,
      'verified_purchase': instance.verifiedPurchase,
    };
