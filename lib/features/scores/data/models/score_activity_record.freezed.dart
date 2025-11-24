// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'score_activity_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ScoreActivityRecord {

 int get id; String get category; double get durationSeconds; double get calories;
/// Create a copy of ScoreActivityRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScoreActivityRecordCopyWith<ScoreActivityRecord> get copyWith => _$ScoreActivityRecordCopyWithImpl<ScoreActivityRecord>(this as ScoreActivityRecord, _$identity);

  /// Serializes this ScoreActivityRecord to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScoreActivityRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.category, category) || other.category == category)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.calories, calories) || other.calories == calories));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,category,durationSeconds,calories);

@override
String toString() {
  return 'ScoreActivityRecord(id: $id, category: $category, durationSeconds: $durationSeconds, calories: $calories)';
}


}

/// @nodoc
abstract mixin class $ScoreActivityRecordCopyWith<$Res>  {
  factory $ScoreActivityRecordCopyWith(ScoreActivityRecord value, $Res Function(ScoreActivityRecord) _then) = _$ScoreActivityRecordCopyWithImpl;
@useResult
$Res call({
 int id, String category, double durationSeconds, double calories
});




}
/// @nodoc
class _$ScoreActivityRecordCopyWithImpl<$Res>
    implements $ScoreActivityRecordCopyWith<$Res> {
  _$ScoreActivityRecordCopyWithImpl(this._self, this._then);

  final ScoreActivityRecord _self;
  final $Res Function(ScoreActivityRecord) _then;

/// Create a copy of ScoreActivityRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? category = null,Object? durationSeconds = null,Object? calories = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,durationSeconds: null == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as double,calories: null == calories ? _self.calories : calories // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [ScoreActivityRecord].
extension ScoreActivityRecordPatterns on ScoreActivityRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScoreActivityRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScoreActivityRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScoreActivityRecord value)  $default,){
final _that = this;
switch (_that) {
case _ScoreActivityRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScoreActivityRecord value)?  $default,){
final _that = this;
switch (_that) {
case _ScoreActivityRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String category,  double durationSeconds,  double calories)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScoreActivityRecord() when $default != null:
return $default(_that.id,_that.category,_that.durationSeconds,_that.calories);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String category,  double durationSeconds,  double calories)  $default,) {final _that = this;
switch (_that) {
case _ScoreActivityRecord():
return $default(_that.id,_that.category,_that.durationSeconds,_that.calories);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String category,  double durationSeconds,  double calories)?  $default,) {final _that = this;
switch (_that) {
case _ScoreActivityRecord() when $default != null:
return $default(_that.id,_that.category,_that.durationSeconds,_that.calories);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ScoreActivityRecord implements ScoreActivityRecord {
  const _ScoreActivityRecord({required this.id, required this.category, required this.durationSeconds, required this.calories});
  factory _ScoreActivityRecord.fromJson(Map<String, dynamic> json) => _$ScoreActivityRecordFromJson(json);

@override final  int id;
@override final  String category;
@override final  double durationSeconds;
@override final  double calories;

/// Create a copy of ScoreActivityRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScoreActivityRecordCopyWith<_ScoreActivityRecord> get copyWith => __$ScoreActivityRecordCopyWithImpl<_ScoreActivityRecord>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScoreActivityRecordToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScoreActivityRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.category, category) || other.category == category)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.calories, calories) || other.calories == calories));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,category,durationSeconds,calories);

@override
String toString() {
  return 'ScoreActivityRecord(id: $id, category: $category, durationSeconds: $durationSeconds, calories: $calories)';
}


}

/// @nodoc
abstract mixin class _$ScoreActivityRecordCopyWith<$Res> implements $ScoreActivityRecordCopyWith<$Res> {
  factory _$ScoreActivityRecordCopyWith(_ScoreActivityRecord value, $Res Function(_ScoreActivityRecord) _then) = __$ScoreActivityRecordCopyWithImpl;
@override @useResult
$Res call({
 int id, String category, double durationSeconds, double calories
});




}
/// @nodoc
class __$ScoreActivityRecordCopyWithImpl<$Res>
    implements _$ScoreActivityRecordCopyWith<$Res> {
  __$ScoreActivityRecordCopyWithImpl(this._self, this._then);

  final _ScoreActivityRecord _self;
  final $Res Function(_ScoreActivityRecord) _then;

/// Create a copy of ScoreActivityRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? category = null,Object? durationSeconds = null,Object? calories = null,}) {
  return _then(_ScoreActivityRecord(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,durationSeconds: null == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as double,calories: null == calories ? _self.calories : calories // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
