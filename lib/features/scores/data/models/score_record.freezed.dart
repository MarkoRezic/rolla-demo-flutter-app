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

 int get id; DateTime get date; double get sleepMinutes; double get restingHeartRateBpm; double get overnightHeartRateVarianceMs; double get activePoints; double get steps; double get moveHours; double get activeCalories; List<ScoreActivityRecord> get activities;
/// Create a copy of ScoreRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScoreRecordCopyWith<ScoreRecord> get copyWith => _$ScoreRecordCopyWithImpl<ScoreRecord>(this as ScoreRecord, _$identity);

  /// Serializes this ScoreRecord to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScoreRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.date, date) || other.date == date)&&(identical(other.sleepMinutes, sleepMinutes) || other.sleepMinutes == sleepMinutes)&&(identical(other.restingHeartRateBpm, restingHeartRateBpm) || other.restingHeartRateBpm == restingHeartRateBpm)&&(identical(other.overnightHeartRateVarianceMs, overnightHeartRateVarianceMs) || other.overnightHeartRateVarianceMs == overnightHeartRateVarianceMs)&&(identical(other.activePoints, activePoints) || other.activePoints == activePoints)&&(identical(other.steps, steps) || other.steps == steps)&&(identical(other.moveHours, moveHours) || other.moveHours == moveHours)&&(identical(other.activeCalories, activeCalories) || other.activeCalories == activeCalories)&&const DeepCollectionEquality().equals(other.activities, activities));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,date,sleepMinutes,restingHeartRateBpm,overnightHeartRateVarianceMs,activePoints,steps,moveHours,activeCalories,const DeepCollectionEquality().hash(activities));

@override
String toString() {
  return 'ScoreRecord(id: $id, date: $date, sleepMinutes: $sleepMinutes, restingHeartRateBpm: $restingHeartRateBpm, overnightHeartRateVarianceMs: $overnightHeartRateVarianceMs, activePoints: $activePoints, steps: $steps, moveHours: $moveHours, activeCalories: $activeCalories, activities: $activities)';
}


}

/// @nodoc
abstract mixin class $ScoreRecordCopyWith<$Res>  {
  factory $ScoreRecordCopyWith(ScoreRecord value, $Res Function(ScoreRecord) _then) = _$ScoreRecordCopyWithImpl;
@useResult
$Res call({
 int id, DateTime date, double sleepMinutes, double restingHeartRateBpm, double overnightHeartRateVarianceMs, double activePoints, double steps, double moveHours, double activeCalories, List<ScoreActivityRecord> activities
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? date = null,Object? sleepMinutes = null,Object? restingHeartRateBpm = null,Object? overnightHeartRateVarianceMs = null,Object? activePoints = null,Object? steps = null,Object? moveHours = null,Object? activeCalories = null,Object? activities = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,sleepMinutes: null == sleepMinutes ? _self.sleepMinutes : sleepMinutes // ignore: cast_nullable_to_non_nullable
as double,restingHeartRateBpm: null == restingHeartRateBpm ? _self.restingHeartRateBpm : restingHeartRateBpm // ignore: cast_nullable_to_non_nullable
as double,overnightHeartRateVarianceMs: null == overnightHeartRateVarianceMs ? _self.overnightHeartRateVarianceMs : overnightHeartRateVarianceMs // ignore: cast_nullable_to_non_nullable
as double,activePoints: null == activePoints ? _self.activePoints : activePoints // ignore: cast_nullable_to_non_nullable
as double,steps: null == steps ? _self.steps : steps // ignore: cast_nullable_to_non_nullable
as double,moveHours: null == moveHours ? _self.moveHours : moveHours // ignore: cast_nullable_to_non_nullable
as double,activeCalories: null == activeCalories ? _self.activeCalories : activeCalories // ignore: cast_nullable_to_non_nullable
as double,activities: null == activities ? _self.activities : activities // ignore: cast_nullable_to_non_nullable
as List<ScoreActivityRecord>,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  DateTime date,  double sleepMinutes,  double restingHeartRateBpm,  double overnightHeartRateVarianceMs,  double activePoints,  double steps,  double moveHours,  double activeCalories,  List<ScoreActivityRecord> activities)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScoreRecord() when $default != null:
return $default(_that.id,_that.date,_that.sleepMinutes,_that.restingHeartRateBpm,_that.overnightHeartRateVarianceMs,_that.activePoints,_that.steps,_that.moveHours,_that.activeCalories,_that.activities);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  DateTime date,  double sleepMinutes,  double restingHeartRateBpm,  double overnightHeartRateVarianceMs,  double activePoints,  double steps,  double moveHours,  double activeCalories,  List<ScoreActivityRecord> activities)  $default,) {final _that = this;
switch (_that) {
case _ScoreRecord():
return $default(_that.id,_that.date,_that.sleepMinutes,_that.restingHeartRateBpm,_that.overnightHeartRateVarianceMs,_that.activePoints,_that.steps,_that.moveHours,_that.activeCalories,_that.activities);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  DateTime date,  double sleepMinutes,  double restingHeartRateBpm,  double overnightHeartRateVarianceMs,  double activePoints,  double steps,  double moveHours,  double activeCalories,  List<ScoreActivityRecord> activities)?  $default,) {final _that = this;
switch (_that) {
case _ScoreRecord() when $default != null:
return $default(_that.id,_that.date,_that.sleepMinutes,_that.restingHeartRateBpm,_that.overnightHeartRateVarianceMs,_that.activePoints,_that.steps,_that.moveHours,_that.activeCalories,_that.activities);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ScoreRecord implements ScoreRecord {
  const _ScoreRecord({required this.id, required this.date, required this.sleepMinutes, required this.restingHeartRateBpm, required this.overnightHeartRateVarianceMs, required this.activePoints, required this.steps, required this.moveHours, required this.activeCalories, required final  List<ScoreActivityRecord> activities}): _activities = activities;
  factory _ScoreRecord.fromJson(Map<String, dynamic> json) => _$ScoreRecordFromJson(json);

@override final  int id;
@override final  DateTime date;
@override final  double sleepMinutes;
@override final  double restingHeartRateBpm;
@override final  double overnightHeartRateVarianceMs;
@override final  double activePoints;
@override final  double steps;
@override final  double moveHours;
@override final  double activeCalories;
 final  List<ScoreActivityRecord> _activities;
@override List<ScoreActivityRecord> get activities {
  if (_activities is EqualUnmodifiableListView) return _activities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_activities);
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScoreRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.date, date) || other.date == date)&&(identical(other.sleepMinutes, sleepMinutes) || other.sleepMinutes == sleepMinutes)&&(identical(other.restingHeartRateBpm, restingHeartRateBpm) || other.restingHeartRateBpm == restingHeartRateBpm)&&(identical(other.overnightHeartRateVarianceMs, overnightHeartRateVarianceMs) || other.overnightHeartRateVarianceMs == overnightHeartRateVarianceMs)&&(identical(other.activePoints, activePoints) || other.activePoints == activePoints)&&(identical(other.steps, steps) || other.steps == steps)&&(identical(other.moveHours, moveHours) || other.moveHours == moveHours)&&(identical(other.activeCalories, activeCalories) || other.activeCalories == activeCalories)&&const DeepCollectionEquality().equals(other._activities, _activities));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,date,sleepMinutes,restingHeartRateBpm,overnightHeartRateVarianceMs,activePoints,steps,moveHours,activeCalories,const DeepCollectionEquality().hash(_activities));

@override
String toString() {
  return 'ScoreRecord(id: $id, date: $date, sleepMinutes: $sleepMinutes, restingHeartRateBpm: $restingHeartRateBpm, overnightHeartRateVarianceMs: $overnightHeartRateVarianceMs, activePoints: $activePoints, steps: $steps, moveHours: $moveHours, activeCalories: $activeCalories, activities: $activities)';
}


}

/// @nodoc
abstract mixin class _$ScoreRecordCopyWith<$Res> implements $ScoreRecordCopyWith<$Res> {
  factory _$ScoreRecordCopyWith(_ScoreRecord value, $Res Function(_ScoreRecord) _then) = __$ScoreRecordCopyWithImpl;
@override @useResult
$Res call({
 int id, DateTime date, double sleepMinutes, double restingHeartRateBpm, double overnightHeartRateVarianceMs, double activePoints, double steps, double moveHours, double activeCalories, List<ScoreActivityRecord> activities
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? date = null,Object? sleepMinutes = null,Object? restingHeartRateBpm = null,Object? overnightHeartRateVarianceMs = null,Object? activePoints = null,Object? steps = null,Object? moveHours = null,Object? activeCalories = null,Object? activities = null,}) {
  return _then(_ScoreRecord(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,sleepMinutes: null == sleepMinutes ? _self.sleepMinutes : sleepMinutes // ignore: cast_nullable_to_non_nullable
as double,restingHeartRateBpm: null == restingHeartRateBpm ? _self.restingHeartRateBpm : restingHeartRateBpm // ignore: cast_nullable_to_non_nullable
as double,overnightHeartRateVarianceMs: null == overnightHeartRateVarianceMs ? _self.overnightHeartRateVarianceMs : overnightHeartRateVarianceMs // ignore: cast_nullable_to_non_nullable
as double,activePoints: null == activePoints ? _self.activePoints : activePoints // ignore: cast_nullable_to_non_nullable
as double,steps: null == steps ? _self.steps : steps // ignore: cast_nullable_to_non_nullable
as double,moveHours: null == moveHours ? _self.moveHours : moveHours // ignore: cast_nullable_to_non_nullable
as double,activeCalories: null == activeCalories ? _self.activeCalories : activeCalories // ignore: cast_nullable_to_non_nullable
as double,activities: null == activities ? _self._activities : activities // ignore: cast_nullable_to_non_nullable
as List<ScoreActivityRecord>,
  ));
}


}

// dart format on
