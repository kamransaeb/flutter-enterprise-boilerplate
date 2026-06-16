// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProductModel {

 String get id; String get name; String get description; double get price;@JsonKey(name: 'image_url') String get imageUrl;@JsonKey(name: 'in_stock') bool get inStock; double get rating;@JsonKey(name: 'review_count') int get reviewCount; List<String> get categories; Map<String, dynamic> get attributes;@JsonKey(name: 'original_price') double? get originalPrice; String? get brand; String? get sku;@JsonKey(name: 'stock_quantity') int? get stockQuantity;@JsonKey(name: 'created_at') DateTime? get createdAt;@JsonKey(name: 'updated_at') DateTime? get updatedAt;@JsonKey(name: 'is_favorite') bool get isFavorite;@JsonKey(name: 'is_featured') bool get isFeatured;
/// Create a copy of ProductModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductModelCopyWith<ProductModel> get copyWith => _$ProductModelCopyWithImpl<ProductModel>(this as ProductModel, _$identity);

  /// Serializes this ProductModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.price, price) || other.price == price)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.inStock, inStock) || other.inStock == inStock)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&const DeepCollectionEquality().equals(other.categories, categories)&&const DeepCollectionEquality().equals(other.attributes, attributes)&&(identical(other.originalPrice, originalPrice) || other.originalPrice == originalPrice)&&(identical(other.brand, brand) || other.brand == brand)&&(identical(other.sku, sku) || other.sku == sku)&&(identical(other.stockQuantity, stockQuantity) || other.stockQuantity == stockQuantity)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite)&&(identical(other.isFeatured, isFeatured) || other.isFeatured == isFeatured));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,price,imageUrl,inStock,rating,reviewCount,const DeepCollectionEquality().hash(categories),const DeepCollectionEquality().hash(attributes),originalPrice,brand,sku,stockQuantity,createdAt,updatedAt,isFavorite,isFeatured);

@override
String toString() {
  return 'ProductModel(id: $id, name: $name, description: $description, price: $price, imageUrl: $imageUrl, inStock: $inStock, rating: $rating, reviewCount: $reviewCount, categories: $categories, attributes: $attributes, originalPrice: $originalPrice, brand: $brand, sku: $sku, stockQuantity: $stockQuantity, createdAt: $createdAt, updatedAt: $updatedAt, isFavorite: $isFavorite, isFeatured: $isFeatured)';
}


}

/// @nodoc
abstract mixin class $ProductModelCopyWith<$Res>  {
  factory $ProductModelCopyWith(ProductModel value, $Res Function(ProductModel) _then) = _$ProductModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String description, double price,@JsonKey(name: 'image_url') String imageUrl,@JsonKey(name: 'in_stock') bool inStock, double rating,@JsonKey(name: 'review_count') int reviewCount, List<String> categories, Map<String, dynamic> attributes,@JsonKey(name: 'original_price') double? originalPrice, String? brand, String? sku,@JsonKey(name: 'stock_quantity') int? stockQuantity,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt,@JsonKey(name: 'is_favorite') bool isFavorite,@JsonKey(name: 'is_featured') bool isFeatured
});




}
/// @nodoc
class _$ProductModelCopyWithImpl<$Res>
    implements $ProductModelCopyWith<$Res> {
  _$ProductModelCopyWithImpl(this._self, this._then);

  final ProductModel _self;
  final $Res Function(ProductModel) _then;

/// Create a copy of ProductModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = null,Object? price = null,Object? imageUrl = null,Object? inStock = null,Object? rating = null,Object? reviewCount = null,Object? categories = null,Object? attributes = null,Object? originalPrice = freezed,Object? brand = freezed,Object? sku = freezed,Object? stockQuantity = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? isFavorite = null,Object? isFeatured = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,inStock: null == inStock ? _self.inStock : inStock // ignore: cast_nullable_to_non_nullable
as bool,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,reviewCount: null == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<String>,attributes: null == attributes ? _self.attributes : attributes // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,originalPrice: freezed == originalPrice ? _self.originalPrice : originalPrice // ignore: cast_nullable_to_non_nullable
as double?,brand: freezed == brand ? _self.brand : brand // ignore: cast_nullable_to_non_nullable
as String?,sku: freezed == sku ? _self.sku : sku // ignore: cast_nullable_to_non_nullable
as String?,stockQuantity: freezed == stockQuantity ? _self.stockQuantity : stockQuantity // ignore: cast_nullable_to_non_nullable
as int?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,isFeatured: null == isFeatured ? _self.isFeatured : isFeatured // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductModel].
extension ProductModelPatterns on ProductModel {
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String description,  double price, @JsonKey(name: 'image_url')  String imageUrl, @JsonKey(name: 'in_stock')  bool inStock,  double rating, @JsonKey(name: 'review_count')  int reviewCount,  List<String> categories,  Map<String, dynamic> attributes, @JsonKey(name: 'original_price')  double? originalPrice,  String? brand,  String? sku, @JsonKey(name: 'stock_quantity')  int? stockQuantity, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt, @JsonKey(name: 'is_favorite')  bool isFavorite, @JsonKey(name: 'is_featured')  bool isFeatured)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductModel() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.price,_that.imageUrl,_that.inStock,_that.rating,_that.reviewCount,_that.categories,_that.attributes,_that.originalPrice,_that.brand,_that.sku,_that.stockQuantity,_that.createdAt,_that.updatedAt,_that.isFavorite,_that.isFeatured);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String description,  double price, @JsonKey(name: 'image_url')  String imageUrl, @JsonKey(name: 'in_stock')  bool inStock,  double rating, @JsonKey(name: 'review_count')  int reviewCount,  List<String> categories,  Map<String, dynamic> attributes, @JsonKey(name: 'original_price')  double? originalPrice,  String? brand,  String? sku, @JsonKey(name: 'stock_quantity')  int? stockQuantity, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt, @JsonKey(name: 'is_favorite')  bool isFavorite, @JsonKey(name: 'is_featured')  bool isFeatured)  $default,) {final _that = this;
switch (_that) {
case _ProductModel():
return $default(_that.id,_that.name,_that.description,_that.price,_that.imageUrl,_that.inStock,_that.rating,_that.reviewCount,_that.categories,_that.attributes,_that.originalPrice,_that.brand,_that.sku,_that.stockQuantity,_that.createdAt,_that.updatedAt,_that.isFavorite,_that.isFeatured);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String description,  double price, @JsonKey(name: 'image_url')  String imageUrl, @JsonKey(name: 'in_stock')  bool inStock,  double rating, @JsonKey(name: 'review_count')  int reviewCount,  List<String> categories,  Map<String, dynamic> attributes, @JsonKey(name: 'original_price')  double? originalPrice,  String? brand,  String? sku, @JsonKey(name: 'stock_quantity')  int? stockQuantity, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt, @JsonKey(name: 'is_favorite')  bool isFavorite, @JsonKey(name: 'is_featured')  bool isFeatured)?  $default,) {final _that = this;
switch (_that) {
case _ProductModel() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.price,_that.imageUrl,_that.inStock,_that.rating,_that.reviewCount,_that.categories,_that.attributes,_that.originalPrice,_that.brand,_that.sku,_that.stockQuantity,_that.createdAt,_that.updatedAt,_that.isFavorite,_that.isFeatured);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProductModel extends ProductModel {
  const _ProductModel({required this.id, required this.name, required this.description, required this.price, @JsonKey(name: 'image_url') required this.imageUrl, @JsonKey(name: 'in_stock') this.inStock = false, this.rating = 0.0, @JsonKey(name: 'review_count') this.reviewCount = 0, final  List<String> categories = const [], final  Map<String, dynamic> attributes = const {}, @JsonKey(name: 'original_price') this.originalPrice, this.brand, this.sku, @JsonKey(name: 'stock_quantity') this.stockQuantity, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'updated_at') this.updatedAt, @JsonKey(name: 'is_favorite') this.isFavorite = false, @JsonKey(name: 'is_featured') this.isFeatured = false}): _categories = categories,_attributes = attributes,super._();
  factory _ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  String description;
@override final  double price;
@override@JsonKey(name: 'image_url') final  String imageUrl;
@override@JsonKey(name: 'in_stock') final  bool inStock;
@override@JsonKey() final  double rating;
@override@JsonKey(name: 'review_count') final  int reviewCount;
 final  List<String> _categories;
@override@JsonKey() List<String> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

 final  Map<String, dynamic> _attributes;
@override@JsonKey() Map<String, dynamic> get attributes {
  if (_attributes is EqualUnmodifiableMapView) return _attributes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_attributes);
}

@override@JsonKey(name: 'original_price') final  double? originalPrice;
@override final  String? brand;
@override final  String? sku;
@override@JsonKey(name: 'stock_quantity') final  int? stockQuantity;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime? updatedAt;
@override@JsonKey(name: 'is_favorite') final  bool isFavorite;
@override@JsonKey(name: 'is_featured') final  bool isFeatured;

/// Create a copy of ProductModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductModelCopyWith<_ProductModel> get copyWith => __$ProductModelCopyWithImpl<_ProductModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.price, price) || other.price == price)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.inStock, inStock) || other.inStock == inStock)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&const DeepCollectionEquality().equals(other._categories, _categories)&&const DeepCollectionEquality().equals(other._attributes, _attributes)&&(identical(other.originalPrice, originalPrice) || other.originalPrice == originalPrice)&&(identical(other.brand, brand) || other.brand == brand)&&(identical(other.sku, sku) || other.sku == sku)&&(identical(other.stockQuantity, stockQuantity) || other.stockQuantity == stockQuantity)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite)&&(identical(other.isFeatured, isFeatured) || other.isFeatured == isFeatured));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,price,imageUrl,inStock,rating,reviewCount,const DeepCollectionEquality().hash(_categories),const DeepCollectionEquality().hash(_attributes),originalPrice,brand,sku,stockQuantity,createdAt,updatedAt,isFavorite,isFeatured);

@override
String toString() {
  return 'ProductModel(id: $id, name: $name, description: $description, price: $price, imageUrl: $imageUrl, inStock: $inStock, rating: $rating, reviewCount: $reviewCount, categories: $categories, attributes: $attributes, originalPrice: $originalPrice, brand: $brand, sku: $sku, stockQuantity: $stockQuantity, createdAt: $createdAt, updatedAt: $updatedAt, isFavorite: $isFavorite, isFeatured: $isFeatured)';
}


}

/// @nodoc
abstract mixin class _$ProductModelCopyWith<$Res> implements $ProductModelCopyWith<$Res> {
  factory _$ProductModelCopyWith(_ProductModel value, $Res Function(_ProductModel) _then) = __$ProductModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String description, double price,@JsonKey(name: 'image_url') String imageUrl,@JsonKey(name: 'in_stock') bool inStock, double rating,@JsonKey(name: 'review_count') int reviewCount, List<String> categories, Map<String, dynamic> attributes,@JsonKey(name: 'original_price') double? originalPrice, String? brand, String? sku,@JsonKey(name: 'stock_quantity') int? stockQuantity,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt,@JsonKey(name: 'is_favorite') bool isFavorite,@JsonKey(name: 'is_featured') bool isFeatured
});




}
/// @nodoc
class __$ProductModelCopyWithImpl<$Res>
    implements _$ProductModelCopyWith<$Res> {
  __$ProductModelCopyWithImpl(this._self, this._then);

  final _ProductModel _self;
  final $Res Function(_ProductModel) _then;

/// Create a copy of ProductModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = null,Object? price = null,Object? imageUrl = null,Object? inStock = null,Object? rating = null,Object? reviewCount = null,Object? categories = null,Object? attributes = null,Object? originalPrice = freezed,Object? brand = freezed,Object? sku = freezed,Object? stockQuantity = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? isFavorite = null,Object? isFeatured = null,}) {
  return _then(_ProductModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,inStock: null == inStock ? _self.inStock : inStock // ignore: cast_nullable_to_non_nullable
as bool,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,reviewCount: null == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<String>,attributes: null == attributes ? _self._attributes : attributes // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,originalPrice: freezed == originalPrice ? _self.originalPrice : originalPrice // ignore: cast_nullable_to_non_nullable
as double?,brand: freezed == brand ? _self.brand : brand // ignore: cast_nullable_to_non_nullable
as String?,sku: freezed == sku ? _self.sku : sku // ignore: cast_nullable_to_non_nullable
as String?,stockQuantity: freezed == stockQuantity ? _self.stockQuantity : stockQuantity // ignore: cast_nullable_to_non_nullable
as int?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,isFeatured: null == isFeatured ? _self.isFeatured : isFeatured // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
