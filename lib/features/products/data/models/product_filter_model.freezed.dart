// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_filter_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProductFilterModel {

 List<String> get categories;@JsonKey(name: 'min_price') double? get minPrice;@JsonKey(name: 'max_price') double? get maxPrice;@JsonKey(name: 'in_stock_only') bool get inStockOnly;@JsonKey(name: 'min_rating') double? get minRating;@JsonKey(name: 'sort_by') String? get sortBy;@JsonKey(name: 'search_query') String? get searchQuery; int get page; int get limit;
/// Create a copy of ProductFilterModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductFilterModelCopyWith<ProductFilterModel> get copyWith => _$ProductFilterModelCopyWithImpl<ProductFilterModel>(this as ProductFilterModel, _$identity);

  /// Serializes this ProductFilterModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductFilterModel&&const DeepCollectionEquality().equals(other.categories, categories)&&(identical(other.minPrice, minPrice) || other.minPrice == minPrice)&&(identical(other.maxPrice, maxPrice) || other.maxPrice == maxPrice)&&(identical(other.inStockOnly, inStockOnly) || other.inStockOnly == inStockOnly)&&(identical(other.minRating, minRating) || other.minRating == minRating)&&(identical(other.sortBy, sortBy) || other.sortBy == sortBy)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.page, page) || other.page == page)&&(identical(other.limit, limit) || other.limit == limit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(categories),minPrice,maxPrice,inStockOnly,minRating,sortBy,searchQuery,page,limit);

@override
String toString() {
  return 'ProductFilterModel(categories: $categories, minPrice: $minPrice, maxPrice: $maxPrice, inStockOnly: $inStockOnly, minRating: $minRating, sortBy: $sortBy, searchQuery: $searchQuery, page: $page, limit: $limit)';
}


}

/// @nodoc
abstract mixin class $ProductFilterModelCopyWith<$Res>  {
  factory $ProductFilterModelCopyWith(ProductFilterModel value, $Res Function(ProductFilterModel) _then) = _$ProductFilterModelCopyWithImpl;
@useResult
$Res call({
 List<String> categories,@JsonKey(name: 'min_price') double? minPrice,@JsonKey(name: 'max_price') double? maxPrice,@JsonKey(name: 'in_stock_only') bool inStockOnly,@JsonKey(name: 'min_rating') double? minRating,@JsonKey(name: 'sort_by') String? sortBy,@JsonKey(name: 'search_query') String? searchQuery, int page, int limit
});




}
/// @nodoc
class _$ProductFilterModelCopyWithImpl<$Res>
    implements $ProductFilterModelCopyWith<$Res> {
  _$ProductFilterModelCopyWithImpl(this._self, this._then);

  final ProductFilterModel _self;
  final $Res Function(ProductFilterModel) _then;

/// Create a copy of ProductFilterModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? categories = null,Object? minPrice = freezed,Object? maxPrice = freezed,Object? inStockOnly = null,Object? minRating = freezed,Object? sortBy = freezed,Object? searchQuery = freezed,Object? page = null,Object? limit = null,}) {
  return _then(_self.copyWith(
categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<String>,minPrice: freezed == minPrice ? _self.minPrice : minPrice // ignore: cast_nullable_to_non_nullable
as double?,maxPrice: freezed == maxPrice ? _self.maxPrice : maxPrice // ignore: cast_nullable_to_non_nullable
as double?,inStockOnly: null == inStockOnly ? _self.inStockOnly : inStockOnly // ignore: cast_nullable_to_non_nullable
as bool,minRating: freezed == minRating ? _self.minRating : minRating // ignore: cast_nullable_to_non_nullable
as double?,sortBy: freezed == sortBy ? _self.sortBy : sortBy // ignore: cast_nullable_to_non_nullable
as String?,searchQuery: freezed == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String?,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductFilterModel].
extension ProductFilterModelPatterns on ProductFilterModel {
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<String> categories, @JsonKey(name: 'min_price')  double? minPrice, @JsonKey(name: 'max_price')  double? maxPrice, @JsonKey(name: 'in_stock_only')  bool inStockOnly, @JsonKey(name: 'min_rating')  double? minRating, @JsonKey(name: 'sort_by')  String? sortBy, @JsonKey(name: 'search_query')  String? searchQuery,  int page,  int limit)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductFilterModel() when $default != null:
return $default(_that.categories,_that.minPrice,_that.maxPrice,_that.inStockOnly,_that.minRating,_that.sortBy,_that.searchQuery,_that.page,_that.limit);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<String> categories, @JsonKey(name: 'min_price')  double? minPrice, @JsonKey(name: 'max_price')  double? maxPrice, @JsonKey(name: 'in_stock_only')  bool inStockOnly, @JsonKey(name: 'min_rating')  double? minRating, @JsonKey(name: 'sort_by')  String? sortBy, @JsonKey(name: 'search_query')  String? searchQuery,  int page,  int limit)  $default,) {final _that = this;
switch (_that) {
case _ProductFilterModel():
return $default(_that.categories,_that.minPrice,_that.maxPrice,_that.inStockOnly,_that.minRating,_that.sortBy,_that.searchQuery,_that.page,_that.limit);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<String> categories, @JsonKey(name: 'min_price')  double? minPrice, @JsonKey(name: 'max_price')  double? maxPrice, @JsonKey(name: 'in_stock_only')  bool inStockOnly, @JsonKey(name: 'min_rating')  double? minRating, @JsonKey(name: 'sort_by')  String? sortBy, @JsonKey(name: 'search_query')  String? searchQuery,  int page,  int limit)?  $default,) {final _that = this;
switch (_that) {
case _ProductFilterModel() when $default != null:
return $default(_that.categories,_that.minPrice,_that.maxPrice,_that.inStockOnly,_that.minRating,_that.sortBy,_that.searchQuery,_that.page,_that.limit);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProductFilterModel extends ProductFilterModel {
  const _ProductFilterModel({final  List<String> categories = const [], @JsonKey(name: 'min_price') this.minPrice, @JsonKey(name: 'max_price') this.maxPrice, @JsonKey(name: 'in_stock_only') this.inStockOnly = false, @JsonKey(name: 'min_rating') this.minRating, @JsonKey(name: 'sort_by') this.sortBy, @JsonKey(name: 'search_query') this.searchQuery, this.page = 1, this.limit = 20}): _categories = categories,super._();
  factory _ProductFilterModel.fromJson(Map<String, dynamic> json) => _$ProductFilterModelFromJson(json);

 final  List<String> _categories;
@override@JsonKey() List<String> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

@override@JsonKey(name: 'min_price') final  double? minPrice;
@override@JsonKey(name: 'max_price') final  double? maxPrice;
@override@JsonKey(name: 'in_stock_only') final  bool inStockOnly;
@override@JsonKey(name: 'min_rating') final  double? minRating;
@override@JsonKey(name: 'sort_by') final  String? sortBy;
@override@JsonKey(name: 'search_query') final  String? searchQuery;
@override@JsonKey() final  int page;
@override@JsonKey() final  int limit;

/// Create a copy of ProductFilterModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductFilterModelCopyWith<_ProductFilterModel> get copyWith => __$ProductFilterModelCopyWithImpl<_ProductFilterModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductFilterModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductFilterModel&&const DeepCollectionEquality().equals(other._categories, _categories)&&(identical(other.minPrice, minPrice) || other.minPrice == minPrice)&&(identical(other.maxPrice, maxPrice) || other.maxPrice == maxPrice)&&(identical(other.inStockOnly, inStockOnly) || other.inStockOnly == inStockOnly)&&(identical(other.minRating, minRating) || other.minRating == minRating)&&(identical(other.sortBy, sortBy) || other.sortBy == sortBy)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.page, page) || other.page == page)&&(identical(other.limit, limit) || other.limit == limit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_categories),minPrice,maxPrice,inStockOnly,minRating,sortBy,searchQuery,page,limit);

@override
String toString() {
  return 'ProductFilterModel(categories: $categories, minPrice: $minPrice, maxPrice: $maxPrice, inStockOnly: $inStockOnly, minRating: $minRating, sortBy: $sortBy, searchQuery: $searchQuery, page: $page, limit: $limit)';
}


}

/// @nodoc
abstract mixin class _$ProductFilterModelCopyWith<$Res> implements $ProductFilterModelCopyWith<$Res> {
  factory _$ProductFilterModelCopyWith(_ProductFilterModel value, $Res Function(_ProductFilterModel) _then) = __$ProductFilterModelCopyWithImpl;
@override @useResult
$Res call({
 List<String> categories,@JsonKey(name: 'min_price') double? minPrice,@JsonKey(name: 'max_price') double? maxPrice,@JsonKey(name: 'in_stock_only') bool inStockOnly,@JsonKey(name: 'min_rating') double? minRating,@JsonKey(name: 'sort_by') String? sortBy,@JsonKey(name: 'search_query') String? searchQuery, int page, int limit
});




}
/// @nodoc
class __$ProductFilterModelCopyWithImpl<$Res>
    implements _$ProductFilterModelCopyWith<$Res> {
  __$ProductFilterModelCopyWithImpl(this._self, this._then);

  final _ProductFilterModel _self;
  final $Res Function(_ProductFilterModel) _then;

/// Create a copy of ProductFilterModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? categories = null,Object? minPrice = freezed,Object? maxPrice = freezed,Object? inStockOnly = null,Object? minRating = freezed,Object? sortBy = freezed,Object? searchQuery = freezed,Object? page = null,Object? limit = null,}) {
  return _then(_ProductFilterModel(
categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<String>,minPrice: freezed == minPrice ? _self.minPrice : minPrice // ignore: cast_nullable_to_non_nullable
as double?,maxPrice: freezed == maxPrice ? _self.maxPrice : maxPrice // ignore: cast_nullable_to_non_nullable
as double?,inStockOnly: null == inStockOnly ? _self.inStockOnly : inStockOnly // ignore: cast_nullable_to_non_nullable
as bool,minRating: freezed == minRating ? _self.minRating : minRating // ignore: cast_nullable_to_non_nullable
as double?,sortBy: freezed == sortBy ? _self.sortBy : sortBy // ignore: cast_nullable_to_non_nullable
as String?,searchQuery: freezed == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String?,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
