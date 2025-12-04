// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'paginated_project_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PaginatedProjectsState {

 List<Project> get items; int get currentPage; int get itemsPerPage; bool get hasMore; bool get isLoadingMore; int? get totalCount; Object? get error;
/// Create a copy of PaginatedProjectsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaginatedProjectsStateCopyWith<PaginatedProjectsState> get copyWith => _$PaginatedProjectsStateCopyWithImpl<PaginatedProjectsState>(this as PaginatedProjectsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaginatedProjectsState&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.itemsPerPage, itemsPerPage) || other.itemsPerPage == itemsPerPage)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&const DeepCollectionEquality().equals(other.error, error));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),currentPage,itemsPerPage,hasMore,isLoadingMore,totalCount,const DeepCollectionEquality().hash(error));

@override
String toString() {
  return 'PaginatedProjectsState(items: $items, currentPage: $currentPage, itemsPerPage: $itemsPerPage, hasMore: $hasMore, isLoadingMore: $isLoadingMore, totalCount: $totalCount, error: $error)';
}


}

/// @nodoc
abstract mixin class $PaginatedProjectsStateCopyWith<$Res>  {
  factory $PaginatedProjectsStateCopyWith(PaginatedProjectsState value, $Res Function(PaginatedProjectsState) _then) = _$PaginatedProjectsStateCopyWithImpl;
@useResult
$Res call({
 List<Project> items, int currentPage, int itemsPerPage, bool hasMore, bool isLoadingMore, int? totalCount, Object? error
});




}
/// @nodoc
class _$PaginatedProjectsStateCopyWithImpl<$Res>
    implements $PaginatedProjectsStateCopyWith<$Res> {
  _$PaginatedProjectsStateCopyWithImpl(this._self, this._then);

  final PaginatedProjectsState _self;
  final $Res Function(PaginatedProjectsState) _then;

/// Create a copy of PaginatedProjectsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? currentPage = null,Object? itemsPerPage = null,Object? hasMore = null,Object? isLoadingMore = null,Object? totalCount = freezed,Object? error = freezed,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<Project>,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,itemsPerPage: null == itemsPerPage ? _self.itemsPerPage : itemsPerPage // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,totalCount: freezed == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int?,error: freezed == error ? _self.error : error ,
  ));
}

}


/// Adds pattern-matching-related methods to [PaginatedProjectsState].
extension PaginatedProjectsStatePatterns on PaginatedProjectsState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaginatedProjectsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaginatedProjectsState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaginatedProjectsState value)  $default,){
final _that = this;
switch (_that) {
case _PaginatedProjectsState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaginatedProjectsState value)?  $default,){
final _that = this;
switch (_that) {
case _PaginatedProjectsState() when $default != null:
return $default(_that);case _:
  return null;

}
}
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Project> items,  int currentPage,  int itemsPerPage,  bool hasMore,  bool isLoadingMore,  int? totalCount,  Object? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaginatedProjectsState() when $default != null:
return $default(_that.items,_that.currentPage,_that.itemsPerPage,_that.hasMore,_that.isLoadingMore,_that.totalCount,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Project> items,  int currentPage,  int itemsPerPage,  bool hasMore,  bool isLoadingMore,  int? totalCount,  Object? error)  $default,) {final _that = this;
switch (_that) {
case _PaginatedProjectsState():
return $default(_that.items,_that.currentPage,_that.itemsPerPage,_that.hasMore,_that.isLoadingMore,_that.totalCount,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Project> items,  int currentPage,  int itemsPerPage,  bool hasMore,  bool isLoadingMore,  int? totalCount,  Object? error)?  $default,) {final _that = this;
switch (_that) {
case _PaginatedProjectsState() when $default != null:
return $default(_that.items,_that.currentPage,_that.itemsPerPage,_that.hasMore,_that.isLoadingMore,_that.totalCount,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _PaginatedProjectsState extends PaginatedProjectsState implements PaginatedState<Project> {
  const _PaginatedProjectsState({required final  List<Project> items, this.currentPage = 0, this.itemsPerPage = 10, this.hasMore = false, this.isLoadingMore = false, this.totalCount = null, this.error = null}): _items = items,super._();
  

 final  List<Project> _items;
@override List<Project> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override@JsonKey() final  int currentPage;
@override@JsonKey() final  int itemsPerPage;
@override@JsonKey() final  bool hasMore;
@override@JsonKey() final  bool isLoadingMore;
@override@JsonKey() final  int? totalCount;
@override@JsonKey() final  Object? error;

/// Create a copy of PaginatedProjectsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaginatedProjectsStateCopyWith<_PaginatedProjectsState> get copyWith => __$PaginatedProjectsStateCopyWithImpl<_PaginatedProjectsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaginatedProjectsState&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.itemsPerPage, itemsPerPage) || other.itemsPerPage == itemsPerPage)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&const DeepCollectionEquality().equals(other.error, error));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),currentPage,itemsPerPage,hasMore,isLoadingMore,totalCount,const DeepCollectionEquality().hash(error));

@override
String toString() {
  return 'PaginatedProjectsState(items: $items, currentPage: $currentPage, itemsPerPage: $itemsPerPage, hasMore: $hasMore, isLoadingMore: $isLoadingMore, totalCount: $totalCount, error: $error)';
}


}

/// @nodoc
abstract mixin class _$PaginatedProjectsStateCopyWith<$Res> implements $PaginatedProjectsStateCopyWith<$Res> {
  factory _$PaginatedProjectsStateCopyWith(_PaginatedProjectsState value, $Res Function(_PaginatedProjectsState) _then) = __$PaginatedProjectsStateCopyWithImpl;
@override @useResult
$Res call({
 List<Project> items, int currentPage, int itemsPerPage, bool hasMore, bool isLoadingMore, int? totalCount, Object? error
});




}
/// @nodoc
class __$PaginatedProjectsStateCopyWithImpl<$Res>
    implements _$PaginatedProjectsStateCopyWith<$Res> {
  __$PaginatedProjectsStateCopyWithImpl(this._self, this._then);

  final _PaginatedProjectsState _self;
  final $Res Function(_PaginatedProjectsState) _then;

/// Create a copy of PaginatedProjectsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? currentPage = null,Object? itemsPerPage = null,Object? hasMore = null,Object? isLoadingMore = null,Object? totalCount = freezed,Object? error = freezed,}) {
  return _then(_PaginatedProjectsState(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<Project>,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,itemsPerPage: null == itemsPerPage ? _self.itemsPerPage : itemsPerPage // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,totalCount: freezed == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int?,error: freezed == error ? _self.error : error ,
  ));
}


}

// dart format on
