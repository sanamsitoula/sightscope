// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'test_scoring.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TestScoring {

/// 0..1 fraction of correct responses.
 double get accuracy;/// Test-defined primary score (meaning set by the test definition).
 double get score;/// Mean response latency in milliseconds (0 if not applicable).
 double get meanReactionTimeMs;/// Test-specific derived values (always JSON primitives).
 Map<String, dynamic> get metrics;/// Number of responses that were scored.
 int get n;
/// Create a copy of TestScoring
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TestScoringCopyWith<TestScoring> get copyWith => _$TestScoringCopyWithImpl<TestScoring>(this as TestScoring, _$identity);

  /// Serializes this TestScoring to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TestScoring&&(identical(other.accuracy, accuracy) || other.accuracy == accuracy)&&(identical(other.score, score) || other.score == score)&&(identical(other.meanReactionTimeMs, meanReactionTimeMs) || other.meanReactionTimeMs == meanReactionTimeMs)&&const DeepCollectionEquality().equals(other.metrics, metrics)&&(identical(other.n, n) || other.n == n));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accuracy,score,meanReactionTimeMs,const DeepCollectionEquality().hash(metrics),n);

@override
String toString() {
  return 'TestScoring(accuracy: $accuracy, score: $score, meanReactionTimeMs: $meanReactionTimeMs, metrics: $metrics, n: $n)';
}


}

/// @nodoc
abstract mixin class $TestScoringCopyWith<$Res>  {
  factory $TestScoringCopyWith(TestScoring value, $Res Function(TestScoring) _then) = _$TestScoringCopyWithImpl;
@useResult
$Res call({
 double accuracy, double score, double meanReactionTimeMs, Map<String, dynamic> metrics, int n
});




}
/// @nodoc
class _$TestScoringCopyWithImpl<$Res>
    implements $TestScoringCopyWith<$Res> {
  _$TestScoringCopyWithImpl(this._self, this._then);

  final TestScoring _self;
  final $Res Function(TestScoring) _then;

/// Create a copy of TestScoring
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? accuracy = null,Object? score = null,Object? meanReactionTimeMs = null,Object? metrics = null,Object? n = null,}) {
  return _then(_self.copyWith(
accuracy: null == accuracy ? _self.accuracy : accuracy // ignore: cast_nullable_to_non_nullable
as double,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double,meanReactionTimeMs: null == meanReactionTimeMs ? _self.meanReactionTimeMs : meanReactionTimeMs // ignore: cast_nullable_to_non_nullable
as double,metrics: null == metrics ? _self.metrics : metrics // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,n: null == n ? _self.n : n // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TestScoring].
extension TestScoringPatterns on TestScoring {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TestScoring value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TestScoring() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TestScoring value)  $default,){
final _that = this;
switch (_that) {
case _TestScoring():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TestScoring value)?  $default,){
final _that = this;
switch (_that) {
case _TestScoring() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double accuracy,  double score,  double meanReactionTimeMs,  Map<String, dynamic> metrics,  int n)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TestScoring() when $default != null:
return $default(_that.accuracy,_that.score,_that.meanReactionTimeMs,_that.metrics,_that.n);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double accuracy,  double score,  double meanReactionTimeMs,  Map<String, dynamic> metrics,  int n)  $default,) {final _that = this;
switch (_that) {
case _TestScoring():
return $default(_that.accuracy,_that.score,_that.meanReactionTimeMs,_that.metrics,_that.n);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double accuracy,  double score,  double meanReactionTimeMs,  Map<String, dynamic> metrics,  int n)?  $default,) {final _that = this;
switch (_that) {
case _TestScoring() when $default != null:
return $default(_that.accuracy,_that.score,_that.meanReactionTimeMs,_that.metrics,_that.n);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TestScoring extends TestScoring {
  const _TestScoring({this.accuracy = 0, this.score = 0, this.meanReactionTimeMs = 0, final  Map<String, dynamic> metrics = const <String, dynamic>{}, this.n = 0}): _metrics = metrics,super._();
  factory _TestScoring.fromJson(Map<String, dynamic> json) => _$TestScoringFromJson(json);

/// 0..1 fraction of correct responses.
@override@JsonKey() final  double accuracy;
/// Test-defined primary score (meaning set by the test definition).
@override@JsonKey() final  double score;
/// Mean response latency in milliseconds (0 if not applicable).
@override@JsonKey() final  double meanReactionTimeMs;
/// Test-specific derived values (always JSON primitives).
 final  Map<String, dynamic> _metrics;
/// Test-specific derived values (always JSON primitives).
@override@JsonKey() Map<String, dynamic> get metrics {
  if (_metrics is EqualUnmodifiableMapView) return _metrics;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_metrics);
}

/// Number of responses that were scored.
@override@JsonKey() final  int n;

/// Create a copy of TestScoring
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TestScoringCopyWith<_TestScoring> get copyWith => __$TestScoringCopyWithImpl<_TestScoring>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TestScoringToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TestScoring&&(identical(other.accuracy, accuracy) || other.accuracy == accuracy)&&(identical(other.score, score) || other.score == score)&&(identical(other.meanReactionTimeMs, meanReactionTimeMs) || other.meanReactionTimeMs == meanReactionTimeMs)&&const DeepCollectionEquality().equals(other._metrics, _metrics)&&(identical(other.n, n) || other.n == n));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accuracy,score,meanReactionTimeMs,const DeepCollectionEquality().hash(_metrics),n);

@override
String toString() {
  return 'TestScoring(accuracy: $accuracy, score: $score, meanReactionTimeMs: $meanReactionTimeMs, metrics: $metrics, n: $n)';
}


}

/// @nodoc
abstract mixin class _$TestScoringCopyWith<$Res> implements $TestScoringCopyWith<$Res> {
  factory _$TestScoringCopyWith(_TestScoring value, $Res Function(_TestScoring) _then) = __$TestScoringCopyWithImpl;
@override @useResult
$Res call({
 double accuracy, double score, double meanReactionTimeMs, Map<String, dynamic> metrics, int n
});




}
/// @nodoc
class __$TestScoringCopyWithImpl<$Res>
    implements _$TestScoringCopyWith<$Res> {
  __$TestScoringCopyWithImpl(this._self, this._then);

  final _TestScoring _self;
  final $Res Function(_TestScoring) _then;

/// Create a copy of TestScoring
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? accuracy = null,Object? score = null,Object? meanReactionTimeMs = null,Object? metrics = null,Object? n = null,}) {
  return _then(_TestScoring(
accuracy: null == accuracy ? _self.accuracy : accuracy // ignore: cast_nullable_to_non_nullable
as double,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double,meanReactionTimeMs: null == meanReactionTimeMs ? _self.meanReactionTimeMs : meanReactionTimeMs // ignore: cast_nullable_to_non_nullable
as double,metrics: null == metrics ? _self._metrics : metrics // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,n: null == n ? _self.n : n // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
