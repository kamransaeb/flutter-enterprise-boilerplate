// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_category_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProductCategoryModel {

 String get id; String get name; String? get description;@JsonKey(name: 'image_url') String? get imageUrl;@JsonKey(name: 'parent_id') String? get parentId;@JsonKey(name: 'product_count') int get productCount; List<ProductCategoryModel> get children;
/// Create a copy of ProductCategoryModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductCategoryModelCopyWith<ProductCategoryModel> get copyWith => _$ProductCategoryModelCopyWithImpl<ProductCategoryModel>(this as ProductCategoryModel, _$identity);

  /// Serializes this ProductCategoryModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductCategoryModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.parentId, parentId) || other.parentId == parentId)&&(identical(other.productCount, productCount) || other.productCount == productCount)&&const DeepCollectionEquality().equals(other.children, children));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,imageUrl,parentId,productCount,const DeepCollectionEquality().hash(children));

@override
String toString() {
  return 'ProductCategoryModel(id: $id, name: $name, description: $description, imageUrl: $imageUrl, parentId: $parentId, productCount: $productCount, children: $children)';
}


}

/// @nodoc
abstract mixin class $ProductCategoryModelCopyWith<$Res>  {
  factory $ProductCategoryModelCopyWith(ProductCategoryModel value, $Res Function(ProductCategoryModel) _then) = _$ProductCategoryModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? description,@JsonKey(name: 'image_url') String? imageUrl,@JsonKey(name: 'parent_id') String? parentId,@JsonKey(name: 'product_count') int productCount, List<ProductCategoryModel> children
});




}
/// @nodoc
class _$ProductCategoryModelCopyWithImpl<$Res>
    implements $ProductCategoryModelCopyWith<$Res> {
  _$ProductCategoryModelCopyWithImpl(this._self, this._then);

  final ProductCategoryModel _self;
  final $Res Function(ProductCategoryModel) _then;

/// Create a copy of ProductCategoryModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? imageUrl = freezed,Object? parentId = freezed,Object? productCount = null,Object? children = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,parentId: freezed == parentId ? _self.parentId : parentId // ignore: cast_nullable_to_non_nullable
as String?,productCount: null == productCount ? _self.productCount : productCount // ignore: cast_nullable_to_non_nullable
as int,children: null == children ? _self.children : children // ignore: cast_nullable_to_non_nullable
as List<ProductCategoryModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductCategoryModel].
extension ProductCategoryModelPatterns on ProductCategoryModel {
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? description, @JsonKey(name: 'image_url')  String? imageUrl, @JsonKey(name: 'parent_id')  String? parentId, @JsonKey(name: 'product_count')  int productCount,  List<ProductCategoryModel> children)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductCategoryModel() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.imageUrl,_that.parentId,_that.productCount,_that.children);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? description, @JsonKey(name: 'image_url')  String? imageUrl, @JsonKey(name: 'parent_id')  String? parentId, @JsonKey(name: 'product_count')  int productCount,  List<ProductCategoryModel> children)  $default,) {final _that = this;
switch (_that) {
case _ProductCategoryModel():
return $default(_that.id,_that.name,_that.description,_that.imageUrl,_that.parentId,_that.productCount,_that.children);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? description, @JsonKey(name: 'image_url')  String? imageUrl, @JsonKey(name: 'parent_id')  String? parentId, @JsonKey(name: 'product_count')  int productCount,  List<ProductCategoryModel> children)?  $default,) {final _that = this;
switch (_that) {
case _ProductCategoryModel() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.imageUrl,_that.parentId,_that.productCount,_that.children);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProductCategoryModel extends ProductCategoryModel {
  const _ProductCategoryModel({required this.id, required this.name, this.description, @JsonKey(name: 'image_url') this.imageUrl, @JsonKey(name: 'parent_id') this.parentId, @JsonKey(name: 'product_count') this.productCount = 0, final  List<ProductCategoryModel> children = const []}): _children = children,super._();
  factory _ProductCategoryModel.fromJson(Map<String, dynamic> json) => _$ProductCategoryModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  String? description;
@override@JsonKey(name: 'image_url') final  String? imageUrl;
@override@JsonKey(name: 'parent_id') final  String? parentId;
@override@JsonKey(name: 'product_count') final  int productCount;
 final  List<ProductCategoryModel> _children;
@override@JsonKey() List<ProductCategoryModel> get children {
  if (_children is EqualUnmodifiableListView) return _children;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_children);
}


/// Create a copy of ProductCategoryModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductCategoryModelCopyWith<_ProductCategoryModel> get copyWith => __$ProductCategoryModelCopyWithImpl<_ProductCategoryModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductCategoryModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductCategoryModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.parentId, parentId) || other.parentId == parentId)&&(identical(other.productCount, productCount) || other.productCount == productCount)&&const DeepCollectionEquality().equals(other._children, _children));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,imageUrl,parentId,productCount,const DeepCollectionEquality().hash(_children));

@override
String toString() {
  return 'ProductCategoryModel(id: $id, name: $name, description: $description, imageUrl: $imageUrl, parentId: $parentId, productCount: $productCount, children: $children)';
}


}

/// @nodoc
abstract mixin class _$ProductCategoryModelCopyWith<$Res> implements $ProductCategoryModelCopyWith<$Res> {
  factory _$ProductCategoryModelCopyWith(_ProductCategoryModel value, $Res Function(_ProductCategoryModel) _then) = __$ProductCategoryModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? description,@JsonKey(name: 'image_url') String? imageUrl,@JsonKey(name: 'parent_id') String? parentId,@JsonKey(name: 'product_count') int productCount, List<ProductCategoryModel> children
});




}
/// @nodoc
class __$ProductCategoryModelCopyWithImpl<$Res>
    implements _$ProductCategoryModelCopyWith<$Res> {
  __$ProductCategoryModelCopyWithImpl(this._self, this._then);

  final _ProductCategoryModel _self;
  final $Res Function(_ProductCategoryModel) _then;

/// Create a copy of ProductCategoryModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? imageUrl = freezed,Object? parentId = freezed,Object? productCount = null,Object? children = null,}) {
  return _then(_ProductCategoryModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,parentId: freezed == parentId ? _self.parentId : parentId // ignore: cast_nullable_to_non_nullable
as String?,productCount: null == productCount ? _self.productCount : productCount // ignore: cast_nullable_to_non_nullable
as int,children: null == children ? _self._children : children // ignore: cast_nullable_to_non_nullable
as List<ProductCategoryModel>,
  ));
}


}

// dart format on
