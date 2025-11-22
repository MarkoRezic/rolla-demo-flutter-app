// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'score_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ScoreRecord {

 String get id; String get type; DateTime get timestamp; int get score; Map<String, dynamic> get metrics;
/// Create a copy of ScoreRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScoreRecordCopyWith<ScoreRecord> get copyWith => _$ScoreRecordCopyWithImpl<ScoreRecord>(this as ScoreRecord, _$identity);

  /// Serializes this ScoreRecord to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScoreRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.score, score) || other.score == score)&&const DeepCollectionEquality().equals(other.metrics, metrics));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,timestamp,score,const DeepCollectionEquality().hash(metrics));

@override
String toString() {
  return 'ScoreRecord(id: $id, type: $type, timestamp: $timestamp, score: $score, metrics: $metrics)';
}


}

/// @nodoc
abstract mixin class $ScoreRecordCopyWith<$Res>  {
  factory $ScoreRecordCopyWith(ScoreRecord value, $Res Function(ScoreRecord) _then) = _$ScoreRecordCopyWithImpl;
@useResult
$Res call({
 String id, String type, DateTime timestamp, int score, Map<String, dynamic> metrics
});




}
/// @nodoc
class _$ScoreRecordCopyWithImpl<$Res>
    implements $ScoreRecordCopyWith<$Res> {
  _$ScoreRecordCopyWithImpl(this._self, this._then);

  final ScoreRecord _self;
  final $Res Function(ScoreRecord) _then;

/// Create a copy of ScoreRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? timestamp = null,Object? score = null,Object? metrics = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,metrics: null == metrics ? _self.metrics : metrics // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [ScoreRecord].
extension ScoreRecordPatterns on ScoreRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScoreRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScoreRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScoreRecord value)  $default,){
final _that = this;
switch (_that) {
case _ScoreRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScoreRecord value)?  $default,){
final _that = this;
switch (_that) {
case _ScoreRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String type,  DateTime timestamp,  int score,  Map<String, dynamic> metrics)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScoreRecord() when $default != null:
return $default(_that.id,_that.type,_that.timestamp,_that.score,_that.metrics);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String type,  DateTime timestamp,  int score,  Map<String, dynamic> metrics)  $default,) {final _that = this;
switch (_that) {
case _ScoreRecord():
return $default(_that.id,_that.type,_that.timestamp,_that.score,_that.metrics);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String type,  DateTime timestamp,  int score,  Map<String, dynamic> metrics)?  $default,) {final _that = this;
switch (_that) {
case _ScoreRecord() when $default != null:
return $default(_that.id,_that.type,_that.timestamp,_that.score,_that.metrics);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ScoreRecord implements ScoreRecord {
  const _ScoreRecord({required this.id, required this.type, required this.timestamp, required this.score, required final  Map<String, dynamic> metrics}): _metrics = metrics;
  factory _ScoreRecord.fromJson(Map<String, dynamic> json) => _$ScoreRecordFromJson(json);

@override final  String id;
@override final  String type;
@override final  DateTime timestamp;
@override final  int score;
 final  Map<String, dynamic> _metrics;
@override Map<String, dynamic> get metrics {
  if (_metrics is EqualUnmodifiableMapView) return _metrics;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_metrics);
}


/// Create a copy of ScoreRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScoreRecordCopyWith<_ScoreRecord> get copyWith => __$ScoreRecordCopyWithImpl<_ScoreRecord>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScoreRecordToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScoreRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.score, score) || other.score == score)&&const DeepCollectionEquality().equals(other._metrics, _metrics));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,timestamp,score,const DeepCollectionEquality().hash(_metrics));

@override
String toString() {
  return 'ScoreRecord(id: $id, type: $type, timestamp: $timestamp, score: $score, metrics: $metrics)';
}


}

/// @nodoc
abstract mixin class _$ScoreRecordCopyWith<$Res> implements $ScoreRecordCopyWith<$Res> {
  factory _$ScoreRecordCopyWith(_ScoreRecord value, $Res Function(_ScoreRecord) _then) = __$ScoreRecordCopyWithImpl;
@override @useResult
$Res call({
 String id, String type, DateTime timestamp, int score, Map<String, dynamic> metrics
});




}
/// @nodoc
class __$ScoreRecordCopyWithImpl<$Res>
    implements _$ScoreRecordCopyWith<$Res> {
  __$ScoreRecordCopyWithImpl(this._self, this._then);

  final _ScoreRecord _self;
  final $Res Function(_ScoreRecord) _then;

/// Create a copy of ScoreRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? timestamp = null,Object? score = null,Object? metrics = null,}) {
  return _then(_ScoreRecord(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,metrics: null == metrics ? _self._metrics : metrics // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
