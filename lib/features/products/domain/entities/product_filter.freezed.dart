// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProductFilter {

 List<String> get categories; double? get minPrice; double? get maxPrice; bool get inStockOnly; double? get minRating; String? get sortBy; String? get sortOrder; String? get searchQuery; int get page; int get limit;
/// Create a copy of ProductFilter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductFilterCopyWith<ProductFilter> get copyWith => _$ProductFilterCopyWithImpl<ProductFilter>(this as ProductFilter, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductFilter&&const DeepCollectionEquality().equals(other.categories, categories)&&(identical(other.minPrice, minPrice) || other.minPrice == minPrice)&&(identical(other.maxPrice, maxPrice) || other.maxPrice == maxPrice)&&(identical(other.inStockOnly, inStockOnly) || other.inStockOnly == inStockOnly)&&(identical(other.minRating, minRating) || other.minRating == minRating)&&(identical(other.sortBy, sortBy) || other.sortBy == sortBy)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.page, page) || other.page == page)&&(identical(other.limit, limit) || other.limit == limit));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(categories),minPrice,maxPrice,inStockOnly,minRating,sortBy,sortOrder,searchQuery,page,limit);

@override
String toString() {
  return 'ProductFilter(categories: $categories, minPrice: $minPrice, maxPrice: $maxPrice, inStockOnly: $inStockOnly, minRating: $minRating, sortBy: $sortBy, sortOrder: $sortOrder, searchQuery: $searchQuery, page: $page, limit: $limit)';
}


}

/// @nodoc
abstract mixin class $ProductFilterCopyWith<$Res>  {
  factory $ProductFilterCopyWith(ProductFilter value, $Res Function(ProductFilter) _then) = _$ProductFilterCopyWithImpl;
@useResult
$Res call({
 List<String> categories, double? minPrice, double? maxPrice, bool inStockOnly, double? minRating, String? sortBy, String? sortOrder, String? searchQuery, int page, int limit
});




}
/// @nodoc
class _$ProductFilterCopyWithImpl<$Res>
    implements $ProductFilterCopyWith<$Res> {
  _$ProductFilterCopyWithImpl(this._self, this._then);

  final ProductFilter _self;
  final $Res Function(ProductFilter) _then;

/// Create a copy of ProductFilter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? categories = null,Object? minPrice = freezed,Object? maxPrice = freezed,Object? inStockOnly = null,Object? minRating = freezed,Object? sortBy = freezed,Object? sortOrder = freezed,Object? searchQuery = freezed,Object? page = null,Object? limit = null,}) {
  return _then(_self.copyWith(
categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<String>,minPrice: freezed == minPrice ? _self.minPrice : minPrice // ignore: cast_nullable_to_non_nullable
as double?,maxPrice: freezed == maxPrice ? _self.maxPrice : maxPrice // ignore: cast_nullable_to_non_nullable
as double?,inStockOnly: null == inStockOnly ? _self.inStockOnly : inStockOnly // ignore: cast_nullable_to_non_nullable
as bool,minRating: freezed == minRating ? _self.minRating : minRating // ignore: cast_nullable_to_non_nullable
as double?,sortBy: freezed == sortBy ? _self.sortBy : sortBy // ignore: cast_nullable_to_non_nullable
as String?,sortOrder: freezed == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as String?,searchQuery: freezed == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String?,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductFilter].
extension ProductFilterPatterns on ProductFilter {
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<String> categories,  double? minPrice,  double? maxPrice,  bool inStockOnly,  double? minRating,  String? sortBy,  String? sortOrder,  String? searchQuery,  int page,  int limit)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductFilter() when $default != null:
return $default(_that.categories,_that.minPrice,_that.maxPrice,_that.inStockOnly,_that.minRating,_that.sortBy,_that.sortOrder,_that.searchQuery,_that.page,_that.limit);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<String> categories,  double? minPrice,  double? maxPrice,  bool inStockOnly,  double? minRating,  String? sortBy,  String? sortOrder,  String? searchQuery,  int page,  int limit)  $default,) {final _that = this;
switch (_that) {
case _ProductFilter():
return $default(_that.categories,_that.minPrice,_that.maxPrice,_that.inStockOnly,_that.minRating,_that.sortBy,_that.sortOrder,_that.searchQuery,_that.page,_that.limit);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<String> categories,  double? minPrice,  double? maxPrice,  bool inStockOnly,  double? minRating,  String? sortBy,  String? sortOrder,  String? searchQuery,  int page,  int limit)?  $default,) {final _that = this;
switch (_that) {
case _ProductFilter() when $default != null:
return $default(_that.categories,_that.minPrice,_that.maxPrice,_that.inStockOnly,_that.minRating,_that.sortBy,_that.sortOrder,_that.searchQuery,_that.page,_that.limit);case _:
  return null;

}
}

}

/// @nodoc


class _ProductFilter extends ProductFilter {
  const _ProductFilter({final  List<String> categories = const [], this.minPrice, this.maxPrice, this.inStockOnly = false, this.minRating, this.sortBy, this.sortOrder, this.searchQuery, this.page = 1, this.limit = 20}): _categories = categories,super._();
  

 final  List<String> _categories;
@override@JsonKey() List<String> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

@override final  double? minPrice;
@override final  double? maxPrice;
@override@JsonKey() final  bool inStockOnly;
@override final  double? minRating;
@override final  String? sortBy;
@override final  String? sortOrder;
@override final  String? searchQuery;
@override@JsonKey() final  int page;
@override@JsonKey() final  int limit;

/// Create a copy of ProductFilter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductFilterCopyWith<_ProductFilter> get copyWith => __$ProductFilterCopyWithImpl<_ProductFilter>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductFilter&&const DeepCollectionEquality().equals(other._categories, _categories)&&(identical(other.minPrice, minPrice) || other.minPrice == minPrice)&&(identical(other.maxPrice, maxPrice) || other.maxPrice == maxPrice)&&(identical(other.inStockOnly, inStockOnly) || other.inStockOnly == inStockOnly)&&(identical(other.minRating, minRating) || other.minRating == minRating)&&(identical(other.sortBy, sortBy) || other.sortBy == sortBy)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.page, page) || other.page == page)&&(identical(other.limit, limit) || other.limit == limit));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_categories),minPrice,maxPrice,inStockOnly,minRating,sortBy,sortOrder,searchQuery,page,limit);

@override
String toString() {
  return 'ProductFilter(categories: $categories, minPrice: $minPrice, maxPrice: $maxPrice, inStockOnly: $inStockOnly, minRating: $minRating, sortBy: $sortBy, sortOrder: $sortOrder, searchQuery: $searchQuery, page: $page, limit: $limit)';
}


}

/// @nodoc
abstract mixin class _$ProductFilterCopyWith<$Res> implements $ProductFilterCopyWith<$Res> {
  factory _$ProductFilterCopyWith(_ProductFilter value, $Res Function(_ProductFilter) _then) = __$ProductFilterCopyWithImpl;
@override @useResult
$Res call({
 List<String> categories, double? minPrice, double? maxPrice, bool inStockOnly, double? minRating, String? sortBy, String? sortOrder, String? searchQuery, int page, int limit
});




}
/// @nodoc
class __$ProductFilterCopyWithImpl<$Res>
    implements _$ProductFilterCopyWith<$Res> {
  __$ProductFilterCopyWithImpl(this._self, this._then);

  final _ProductFilter _self;
  final $Res Function(_ProductFilter) _then;

/// Create a copy of ProductFilter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? categories = null,Object? minPrice = freezed,Object? maxPrice = freezed,Object? inStockOnly = null,Object? minRating = freezed,Object? sortBy = freezed,Object? sortOrder = freezed,Object? searchQuery = freezed,Object? page = null,Object? limit = null,}) {
  return _then(_ProductFilter(
categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<String>,minPrice: freezed == minPrice ? _self.minPrice : minPrice // ignore: cast_nullable_to_non_nullable
as double?,maxPrice: freezed == maxPrice ? _self.maxPrice : maxPrice // ignore: cast_nullable_to_non_nullable
as double?,inStockOnly: null == inStockOnly ? _self.inStockOnly : inStockOnly // ignore: cast_nullable_to_non_nullable
as bool,minRating: freezed == minRating ? _self.minRating : minRating // ignore: cast_nullable_to_non_nullable
as double?,sortBy: freezed == sortBy ? _self.sortBy : sortBy // ignore: cast_nullable_to_non_nullable
as String?,sortOrder: freezed == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as String?,searchQuery: freezed == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String?,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
