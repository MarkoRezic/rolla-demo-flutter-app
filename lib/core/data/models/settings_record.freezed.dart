// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SettingsRecord {

 String? get name; String? get languageCode; String? get themeMode;
/// Create a copy of SettingsRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettingsRecordCopyWith<SettingsRecord> get copyWith => _$SettingsRecordCopyWithImpl<SettingsRecord>(this as SettingsRecord, _$identity);

  /// Serializes this SettingsRecord to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsRecord&&(identical(other.name, name) || other.name == name)&&(identical(other.languageCode, languageCode) || other.languageCode == languageCode)&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,languageCode,themeMode);

@override
String toString() {
  return 'SettingsRecord(name: $name, languageCode: $languageCode, themeMode: $themeMode)';
}


}

/// @nodoc
abstract mixin class $SettingsRecordCopyWith<$Res>  {
  factory $SettingsRecordCopyWith(SettingsRecord value, $Res Function(SettingsRecord) _then) = _$SettingsRecordCopyWithImpl;
@useResult
$Res call({
 String? name, String? languageCode, String? themeMode
});




}
/// @nodoc
class _$SettingsRecordCopyWithImpl<$Res>
    implements $SettingsRecordCopyWith<$Res> {
  _$SettingsRecordCopyWithImpl(this._self, this._then);

  final SettingsRecord _self;
  final $Res Function(SettingsRecord) _then;

/// Create a copy of SettingsRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = freezed,Object? languageCode = freezed,Object? themeMode = freezed,}) {
  return _then(_self.copyWith(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,languageCode: freezed == languageCode ? _self.languageCode : languageCode // ignore: cast_nullable_to_non_nullable
as String?,themeMode: freezed == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SettingsRecord].
extension SettingsRecordPatterns on SettingsRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SettingsRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SettingsRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SettingsRecord value)  $default,){
final _that = this;
switch (_that) {
case _SettingsRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SettingsRecord value)?  $default,){
final _that = this;
switch (_that) {
case _SettingsRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? name,  String? languageCode,  String? themeMode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SettingsRecord() when $default != null:
return $default(_that.name,_that.languageCode,_that.themeMode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? name,  String? languageCode,  String? themeMode)  $default,) {final _that = this;
switch (_that) {
case _SettingsRecord():
return $default(_that.name,_that.languageCode,_that.themeMode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? name,  String? languageCode,  String? themeMode)?  $default,) {final _that = this;
switch (_that) {
case _SettingsRecord() when $default != null:
return $default(_that.name,_that.languageCode,_that.themeMode);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SettingsRecord implements SettingsRecord {
  const _SettingsRecord({required this.name, required this.languageCode, required this.themeMode});
  factory _SettingsRecord.fromJson(Map<String, dynamic> json) => _$SettingsRecordFromJson(json);

@override final  String? name;
@override final  String? languageCode;
@override final  String? themeMode;

/// Create a copy of SettingsRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettingsRecordCopyWith<_SettingsRecord> get copyWith => __$SettingsRecordCopyWithImpl<_SettingsRecord>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SettingsRecordToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SettingsRecord&&(identical(other.name, name) || other.name == name)&&(identical(other.languageCode, languageCode) || other.languageCode == languageCode)&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,languageCode,themeMode);

@override
String toString() {
  return 'SettingsRecord(name: $name, languageCode: $languageCode, themeMode: $themeMode)';
}


}

/// @nodoc
abstract mixin class _$SettingsRecordCopyWith<$Res> implements $SettingsRecordCopyWith<$Res> {
  factory _$SettingsRecordCopyWith(_SettingsRecord value, $Res Function(_SettingsRecord) _then) = __$SettingsRecordCopyWithImpl;
@override @useResult
$Res call({
 String? name, String? languageCode, String? themeMode
});




}
/// @nodoc
class __$SettingsRecordCopyWithImpl<$Res>
    implements _$SettingsRecordCopyWith<$Res> {
  __$SettingsRecordCopyWithImpl(this._self, this._then);

  final _SettingsRecord _self;
  final $Res Function(_SettingsRecord) _then;

/// Create a copy of SettingsRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = freezed,Object? languageCode = freezed,Object? themeMode = freezed,}) {
  return _then(_SettingsRecord(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,languageCode: freezed == languageCode ? _self.languageCode : languageCode // ignore: cast_nullable_to_non_nullable
as String?,themeMode: freezed == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
