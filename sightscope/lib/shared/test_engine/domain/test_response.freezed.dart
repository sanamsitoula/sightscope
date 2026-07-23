// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'test_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TestResponse {

 TestStimulus get stimulus;/// What the user answered (test-defined shape).
 Map<String, dynamic> get answer;/// Whether the response matched the stimulus' expected answer.
 bool get correct;/// Time from stimulus presentation to response, in milliseconds.
 int get durationMillis;/// Epoch timestamp (ms) at which the response was recorded.
 int? get recordedAtEpochMs;
/// Create a copy of TestResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TestResponseCopyWith<TestResponse> get copyWith => _$TestResponseCopyWithImpl<TestResponse>(this as TestResponse, _$identity);

  /// Serializes this TestResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TestResponse&&(identical(other.stimulus, stimulus) || other.stimulus == stimulus)&&const DeepCollectionEquality().equals(other.answer, answer)&&(identical(other.correct, correct) || other.correct == correct)&&(identical(other.durationMillis, durationMillis) || other.durationMillis == durationMillis)&&(identical(other.recordedAtEpochMs, recordedAtEpochMs) || other.recordedAtEpochMs == recordedAtEpochMs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,stimulus,const DeepCollectionEquality().hash(answer),correct,durationMillis,recordedAtEpochMs);

@override
String toString() {
  return 'TestResponse(stimulus: $stimulus, answer: $answer, correct: $correct, durationMillis: $durationMillis, recordedAtEpochMs: $recordedAtEpochMs)';
}


}

/// @nodoc
abstract mixin class $TestResponseCopyWith<$Res>  {
  factory $TestResponseCopyWith(TestResponse value, $Res Function(TestResponse) _then) = _$TestResponseCopyWithImpl;
@useResult
$Res call({
 TestStimulus stimulus, Map<String, dynamic> answer, bool correct, int durationMillis, int? recordedAtEpochMs
});


$TestStimulusCopyWith<$Res> get stimulus;

}
/// @nodoc
class _$TestResponseCopyWithImpl<$Res>
    implements $TestResponseCopyWith<$Res> {
  _$TestResponseCopyWithImpl(this._self, this._then);

  final TestResponse _self;
  final $Res Function(TestResponse) _then;

/// Create a copy of TestResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? stimulus = null,Object? answer = null,Object? correct = null,Object? durationMillis = null,Object? recordedAtEpochMs = freezed,}) {
  return _then(_self.copyWith(
stimulus: null == stimulus ? _self.stimulus : stimulus // ignore: cast_nullable_to_non_nullable
as TestStimulus,answer: null == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,correct: null == correct ? _self.correct : correct // ignore: cast_nullable_to_non_nullable
as bool,durationMillis: null == durationMillis ? _self.durationMillis : durationMillis // ignore: cast_nullable_to_non_nullable
as int,recordedAtEpochMs: freezed == recordedAtEpochMs ? _self.recordedAtEpochMs : recordedAtEpochMs // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}
/// Create a copy of TestResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TestStimulusCopyWith<$Res> get stimulus {
  
  return $TestStimulusCopyWith<$Res>(_self.stimulus, (value) {
    return _then(_self.copyWith(stimulus: value));
  });
}
}


/// Adds pattern-matching-related methods to [TestResponse].
extension TestResponsePatterns on TestResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TestResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TestResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TestResponse value)  $default,){
final _that = this;
switch (_that) {
case _TestResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TestResponse value)?  $default,){
final _that = this;
switch (_that) {
case _TestResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TestStimulus stimulus,  Map<String, dynamic> answer,  bool correct,  int durationMillis,  int? recordedAtEpochMs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TestResponse() when $default != null:
return $default(_that.stimulus,_that.answer,_that.correct,_that.durationMillis,_that.recordedAtEpochMs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TestStimulus stimulus,  Map<String, dynamic> answer,  bool correct,  int durationMillis,  int? recordedAtEpochMs)  $default,) {final _that = this;
switch (_that) {
case _TestResponse():
return $default(_that.stimulus,_that.answer,_that.correct,_that.durationMillis,_that.recordedAtEpochMs);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TestStimulus stimulus,  Map<String, dynamic> answer,  bool correct,  int durationMillis,  int? recordedAtEpochMs)?  $default,) {final _that = this;
switch (_that) {
case _TestResponse() when $default != null:
return $default(_that.stimulus,_that.answer,_that.correct,_that.durationMillis,_that.recordedAtEpochMs);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TestResponse implements TestResponse {
  const _TestResponse({required this.stimulus, required final  Map<String, dynamic> answer, this.correct = false, this.durationMillis = 0, this.recordedAtEpochMs}): _answer = answer;
  factory _TestResponse.fromJson(Map<String, dynamic> json) => _$TestResponseFromJson(json);

@override final  TestStimulus stimulus;
/// What the user answered (test-defined shape).
 final  Map<String, dynamic> _answer;
/// What the user answered (test-defined shape).
@override Map<String, dynamic> get answer {
  if (_answer is EqualUnmodifiableMapView) return _answer;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_answer);
}

/// Whether the response matched the stimulus' expected answer.
@override@JsonKey() final  bool correct;
/// Time from stimulus presentation to response, in milliseconds.
@override@JsonKey() final  int durationMillis;
/// Epoch timestamp (ms) at which the response was recorded.
@override final  int? recordedAtEpochMs;

/// Create a copy of TestResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TestResponseCopyWith<_TestResponse> get copyWith => __$TestResponseCopyWithImpl<_TestResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TestResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TestResponse&&(identical(other.stimulus, stimulus) || other.stimulus == stimulus)&&const DeepCollectionEquality().equals(other._answer, _answer)&&(identical(other.correct, correct) || other.correct == correct)&&(identical(other.durationMillis, durationMillis) || other.durationMillis == durationMillis)&&(identical(other.recordedAtEpochMs, recordedAtEpochMs) || other.recordedAtEpochMs == recordedAtEpochMs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,stimulus,const DeepCollectionEquality().hash(_answer),correct,durationMillis,recordedAtEpochMs);

@override
String toString() {
  return 'TestResponse(stimulus: $stimulus, answer: $answer, correct: $correct, durationMillis: $durationMillis, recordedAtEpochMs: $recordedAtEpochMs)';
}


}

/// @nodoc
abstract mixin class _$TestResponseCopyWith<$Res> implements $TestResponseCopyWith<$Res> {
  factory _$TestResponseCopyWith(_TestResponse value, $Res Function(_TestResponse) _then) = __$TestResponseCopyWithImpl;
@override @useResult
$Res call({
 TestStimulus stimulus, Map<String, dynamic> answer, bool correct, int durationMillis, int? recordedAtEpochMs
});


@override $TestStimulusCopyWith<$Res> get stimulus;

}
/// @nodoc
class __$TestResponseCopyWithImpl<$Res>
    implements _$TestResponseCopyWith<$Res> {
  __$TestResponseCopyWithImpl(this._self, this._then);

  final _TestResponse _self;
  final $Res Function(_TestResponse) _then;

/// Create a copy of TestResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? stimulus = null,Object? answer = null,Object? correct = null,Object? durationMillis = null,Object? recordedAtEpochMs = freezed,}) {
  return _then(_TestResponse(
stimulus: null == stimulus ? _self.stimulus : stimulus // ignore: cast_nullable_to_non_nullable
as TestStimulus,answer: null == answer ? _self._answer : answer // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,correct: null == correct ? _self.correct : correct // ignore: cast_nullable_to_non_nullable
as bool,durationMillis: null == durationMillis ? _self.durationMillis : durationMillis // ignore: cast_nullable_to_non_nullable
as int,recordedAtEpochMs: freezed == recordedAtEpochMs ? _self.recordedAtEpochMs : recordedAtEpochMs // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

/// Create a copy of TestResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TestStimulusCopyWith<$Res> get stimulus {
  
  return $TestStimulusCopyWith<$Res>(_self.stimulus, (value) {
    return _then(_self.copyWith(stimulus: value));
  });
}
}

// dart format on
