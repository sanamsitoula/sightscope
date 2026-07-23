// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'test_stimulus.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TestStimulus {

/// Stable id within the test (e.g. "trial-007").
 String get id;/// Test-specific stimulus data (always JSON-serializable primitives).
 Map<String, dynamic> get payload;
/// Create a copy of TestStimulus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TestStimulusCopyWith<TestStimulus> get copyWith => _$TestStimulusCopyWithImpl<TestStimulus>(this as TestStimulus, _$identity);

  /// Serializes this TestStimulus to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TestStimulus&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other.payload, payload));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(payload));

@override
String toString() {
  return 'TestStimulus(id: $id, payload: $payload)';
}


}

/// @nodoc
abstract mixin class $TestStimulusCopyWith<$Res>  {
  factory $TestStimulusCopyWith(TestStimulus value, $Res Function(TestStimulus) _then) = _$TestStimulusCopyWithImpl;
@useResult
$Res call({
 String id, Map<String, dynamic> payload
});




}
/// @nodoc
class _$TestStimulusCopyWithImpl<$Res>
    implements $TestStimulusCopyWith<$Res> {
  _$TestStimulusCopyWithImpl(this._self, this._then);

  final TestStimulus _self;
  final $Res Function(TestStimulus) _then;

/// Create a copy of TestStimulus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? payload = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,payload: null == payload ? _self.payload : payload // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [TestStimulus].
extension TestStimulusPatterns on TestStimulus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TestStimulus value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TestStimulus() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TestStimulus value)  $default,){
final _that = this;
switch (_that) {
case _TestStimulus():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TestStimulus value)?  $default,){
final _that = this;
switch (_that) {
case _TestStimulus() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  Map<String, dynamic> payload)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TestStimulus() when $default != null:
return $default(_that.id,_that.payload);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  Map<String, dynamic> payload)  $default,) {final _that = this;
switch (_that) {
case _TestStimulus():
return $default(_that.id,_that.payload);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  Map<String, dynamic> payload)?  $default,) {final _that = this;
switch (_that) {
case _TestStimulus() when $default != null:
return $default(_that.id,_that.payload);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TestStimulus implements TestStimulus {
  const _TestStimulus({required this.id, required final  Map<String, dynamic> payload}): _payload = payload;
  factory _TestStimulus.fromJson(Map<String, dynamic> json) => _$TestStimulusFromJson(json);

/// Stable id within the test (e.g. "trial-007").
@override final  String id;
/// Test-specific stimulus data (always JSON-serializable primitives).
 final  Map<String, dynamic> _payload;
/// Test-specific stimulus data (always JSON-serializable primitives).
@override Map<String, dynamic> get payload {
  if (_payload is EqualUnmodifiableMapView) return _payload;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_payload);
}


/// Create a copy of TestStimulus
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TestStimulusCopyWith<_TestStimulus> get copyWith => __$TestStimulusCopyWithImpl<_TestStimulus>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TestStimulusToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TestStimulus&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other._payload, _payload));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(_payload));

@override
String toString() {
  return 'TestStimulus(id: $id, payload: $payload)';
}


}

/// @nodoc
abstract mixin class _$TestStimulusCopyWith<$Res> implements $TestStimulusCopyWith<$Res> {
  factory _$TestStimulusCopyWith(_TestStimulus value, $Res Function(_TestStimulus) _then) = __$TestStimulusCopyWithImpl;
@override @useResult
$Res call({
 String id, Map<String, dynamic> payload
});




}
/// @nodoc
class __$TestStimulusCopyWithImpl<$Res>
    implements _$TestStimulusCopyWith<$Res> {
  __$TestStimulusCopyWithImpl(this._self, this._then);

  final _TestStimulus _self;
  final $Res Function(_TestStimulus) _then;

/// Create a copy of TestStimulus
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? payload = null,}) {
  return _then(_TestStimulus(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,payload: null == payload ? _self._payload : payload // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
