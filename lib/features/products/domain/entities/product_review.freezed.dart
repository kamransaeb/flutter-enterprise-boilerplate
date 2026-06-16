// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_review.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProductReview {

 String get id; String get productId; String get userId; String get userName; String? get userAvatar; double get rating; String get comment; DateTime get createdAt; List<String> get likes; List<String> get dislikes; bool get verifiedPurchase;
/// Create a copy of ProductReview
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductReviewCopyWith<ProductReview> get copyWith => _$ProductReviewCopyWithImpl<ProductReview>(this as ProductReview, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductReview&&(identical(other.id, id) || other.id == id)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.userAvatar, userAvatar) || other.userAvatar == userAvatar)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.likes, likes)&&const DeepCollectionEquality().equals(other.dislikes, dislikes)&&(identical(other.verifiedPurchase, verifiedPurchase) || other.verifiedPurchase == verifiedPurchase));
}


@override
int get hashCode => Object.hash(runtimeType,id,productId,userId,userName,userAvatar,rating,comment,createdAt,const DeepCollectionEquality().hash(likes),const DeepCollectionEquality().hash(dislikes),verifiedPurchase);

@override
String toString() {
  return 'ProductReview(id: $id, productId: $productId, userId: $userId, userName: $userName, userAvatar: $userAvatar, rating: $rating, comment: $comment, createdAt: $createdAt, likes: $likes, dislikes: $dislikes, verifiedPurchase: $verifiedPurchase)';
}


}

/// @nodoc
abstract mixin class $ProductReviewCopyWith<$Res>  {
  factory $ProductReviewCopyWith(ProductReview value, $Res Function(ProductReview) _then) = _$ProductReviewCopyWithImpl;
@useResult
$Res call({
 String id, String productId, String userId, String userName, String? userAvatar, double rating, String comment, DateTime createdAt, List<String> likes, List<String> dislikes, bool verifiedPurchase
});




}
/// @nodoc
class _$ProductReviewCopyWithImpl<$Res>
    implements $ProductReviewCopyWith<$Res> {
  _$ProductReviewCopyWithImpl(this._self, this._then);

  final ProductReview _self;
  final $Res Function(ProductReview) _then;

/// Create a copy of ProductReview
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? productId = null,Object? userId = null,Object? userName = null,Object? userAvatar = freezed,Object? rating = null,Object? comment = null,Object? createdAt = null,Object? likes = null,Object? dislikes = null,Object? verifiedPurchase = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,userAvatar: freezed == userAvatar ? _self.userAvatar : userAvatar // ignore: cast_nullable_to_non_nullable
as String?,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,comment: null == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,likes: null == likes ? _self.likes : likes // ignore: cast_nullable_to_non_nullable
as List<String>,dislikes: null == dislikes ? _self.dislikes : dislikes // ignore: cast_nullable_to_non_nullable
as List<String>,verifiedPurchase: null == verifiedPurchase ? _self.verifiedPurchase : verifiedPurchase // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductReview].
extension ProductReviewPatterns on ProductReview {
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String productId,  String userId,  String userName,  String? userAvatar,  double rating,  String comment,  DateTime createdAt,  List<String> likes,  List<String> dislikes,  bool verifiedPurchase)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductReview() when $default != null:
return $default(_that.id,_that.productId,_that.userId,_that.userName,_that.userAvatar,_that.rating,_that.comment,_that.createdAt,_that.likes,_that.dislikes,_that.verifiedPurchase);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String productId,  String userId,  String userName,  String? userAvatar,  double rating,  String comment,  DateTime createdAt,  List<String> likes,  List<String> dislikes,  bool verifiedPurchase)  $default,) {final _that = this;
switch (_that) {
case _ProductReview():
return $default(_that.id,_that.productId,_that.userId,_that.userName,_that.userAvatar,_that.rating,_that.comment,_that.createdAt,_that.likes,_that.dislikes,_that.verifiedPurchase);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String productId,  String userId,  String userName,  String? userAvatar,  double rating,  String comment,  DateTime createdAt,  List<String> likes,  List<String> dislikes,  bool verifiedPurchase)?  $default,) {final _that = this;
switch (_that) {
case _ProductReview() when $default != null:
return $default(_that.id,_that.productId,_that.userId,_that.userName,_that.userAvatar,_that.rating,_that.comment,_that.createdAt,_that.likes,_that.dislikes,_that.verifiedPurchase);case _:
  return null;

}
}

}

/// @nodoc


class _ProductReview extends ProductReview {
  const _ProductReview({required this.id, required this.productId, required this.userId, required this.userName, this.userAvatar, required this.rating, required this.comment, required this.createdAt, final  List<String> likes = const [], final  List<String> dislikes = const [], this.verifiedPurchase = false}): _likes = likes,_dislikes = dislikes,super._();
  

@override final  String id;
@override final  String productId;
@override final  String userId;
@override final  String userName;
@override final  String? userAvatar;
@override final  double rating;
@override final  String comment;
@override final  DateTime createdAt;
 final  List<String> _likes;
@override@JsonKey() List<String> get likes {
  if (_likes is EqualUnmodifiableListView) return _likes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_likes);
}

 final  List<String> _dislikes;
@override@JsonKey() List<String> get dislikes {
  if (_dislikes is EqualUnmodifiableListView) return _dislikes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_dislikes);
}

@override@JsonKey() final  bool verifiedPurchase;

/// Create a copy of ProductReview
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductReviewCopyWith<_ProductReview> get copyWith => __$ProductReviewCopyWithImpl<_ProductReview>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductReview&&(identical(other.id, id) || other.id == id)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.userAvatar, userAvatar) || other.userAvatar == userAvatar)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other._likes, _likes)&&const DeepCollectionEquality().equals(other._dislikes, _dislikes)&&(identical(other.verifiedPurchase, verifiedPurchase) || other.verifiedPurchase == verifiedPurchase));
}


@override
int get hashCode => Object.hash(runtimeType,id,productId,userId,userName,userAvatar,rating,comment,createdAt,const DeepCollectionEquality().hash(_likes),const DeepCollectionEquality().hash(_dislikes),verifiedPurchase);

@override
String toString() {
  return 'ProductReview(id: $id, productId: $productId, userId: $userId, userName: $userName, userAvatar: $userAvatar, rating: $rating, comment: $comment, createdAt: $createdAt, likes: $likes, dislikes: $dislikes, verifiedPurchase: $verifiedPurchase)';
}


}

/// @nodoc
abstract mixin class _$ProductReviewCopyWith<$Res> implements $ProductReviewCopyWith<$Res> {
  factory _$ProductReviewCopyWith(_ProductReview value, $Res Function(_ProductReview) _then) = __$ProductReviewCopyWithImpl;
@override @useResult
$Res call({
 String id, String productId, String userId, String userName, String? userAvatar, double rating, String comment, DateTime createdAt, List<String> likes, List<String> dislikes, bool verifiedPurchase
});




}
/// @nodoc
class __$ProductReviewCopyWithImpl<$Res>
    implements _$ProductReviewCopyWith<$Res> {
  __$ProductReviewCopyWithImpl(this._self, this._then);

  final _ProductReview _self;
  final $Res Function(_ProductReview) _then;

/// Create a copy of ProductReview
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? productId = null,Object? userId = null,Object? userName = null,Object? userAvatar = freezed,Object? rating = null,Object? comment = null,Object? createdAt = null,Object? likes = null,Object? dislikes = null,Object? verifiedPurchase = null,}) {
  return _then(_ProductReview(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,userAvatar: freezed == userAvatar ? _self.userAvatar : userAvatar // ignore: cast_nullable_to_non_nullable
as String?,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,comment: null == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,likes: null == likes ? _self._likes : likes // ignore: cast_nullable_to_non_nullable
as List<String>,dislikes: null == dislikes ? _self._dislikes : dislikes // ignore: cast_nullable_to_non_nullable
as List<String>,verifiedPurchase: null == verifiedPurchase ? _self.verifiedPurchase : verifiedPurchase // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
