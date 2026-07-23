// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'test_confidence.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TestConfidence {

 ConfidenceLevel get level;/// Continuous 0..1 score (higher = more trustworthy).
 double get score; List<String> get reasons;
/// Create a copy of TestConfidence
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TestConfidenceCopyWith<TestConfidence> get copyWith => _$TestConfidenceCopyWithImpl<TestConfidence>(this as TestConfidence, _$identity);

  /// Serializes this TestConfidence to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TestConfidence&&(identical(other.level, level) || other.level == level)&&(identical(other.score, score) || other.score == score)&&const DeepCollectionEquality().equals(other.reasons, reasons));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,level,score,const DeepCollectionEquality().hash(reasons));

@override
String toString() {
  return 'TestConfidence(level: $level, score: $score, reasons: $reasons)';
}


}

/// @nodoc
abstract mixin class $TestConfidenceCopyWith<$Res>  {
  factory $TestConfidenceCopyWith(TestConfidence value, $Res Function(TestConfidence) _then) = _$TestConfidenceCopyWithImpl;
@useResult
$Res call({
 ConfidenceLevel level, double score, List<String> reasons
});




}
/// @nodoc
class _$TestConfidenceCopyWithImpl<$Res>
    implements $TestConfidenceCopyWith<$Res> {
  _$TestConfidenceCopyWithImpl(this._self, this._then);

  final TestConfidence _self;
  final $Res Function(TestConfidence) _then;

/// Create a copy of TestConfidence
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? level = null,Object? score = null,Object? reasons = null,}) {
  return _then(_self.copyWith(
level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as ConfidenceLevel,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double,reasons: null == reasons ? _self.reasons : reasons // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [TestConfidence].
extension TestConfidencePatterns on TestConfidence {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TestConfidence value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TestConfidence() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TestConfidence value)  $default,){
final _that = this;
switch (_that) {
case _TestConfidence():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TestConfidence value)?  $default,){
final _that = this;
switch (_that) {
case _TestConfidence() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ConfidenceLevel level,  double score,  List<String> reasons)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TestConfidence() when $default != null:
return $default(_that.level,_that.score,_that.reasons);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ConfidenceLevel level,  double score,  List<String> reasons)  $default,) {final _that = this;
switch (_that) {
case _TestConfidence():
return $default(_that.level,_that.score,_that.reasons);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ConfidenceLevel level,  double score,  List<String> reasons)?  $default,) {final _that = this;
switch (_that) {
case _TestConfidence() when $default != null:
return $default(_that.level,_that.score,_that.reasons);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TestConfidence implements TestConfidence {
  const _TestConfidence({this.level = ConfidenceLevel.medium, this.score = 0.5, final  List<String> reasons = const <String>[]}): _reasons = reasons;
  factory _TestConfidence.fromJson(Map<String, dynamic> json) => _$TestConfidenceFromJson(json);

@override@JsonKey() final  ConfidenceLevel level;
/// Continuous 0..1 score (higher = more trustworthy).
@override@JsonKey() final  double score;
 final  List<String> _reasons;
@override@JsonKey() List<String> get reasons {
  if (_reasons is EqualUnmodifiableListView) return _reasons;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_reasons);
}


/// Create a copy of TestConfidence
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TestConfidenceCopyWith<_TestConfidence> get copyWith => __$TestConfidenceCopyWithImpl<_TestConfidence>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TestConfidenceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TestConfidence&&(identical(other.level, level) || other.level == level)&&(identical(other.score, score) || other.score == score)&&const DeepCollectionEquality().equals(other._reasons, _reasons));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,level,score,const DeepCollectionEquality().hash(_reasons));

@override
String toString() {
  return 'TestConfidence(level: $level, score: $score, reasons: $reasons)';
}


}

/// @nodoc
abstract mixin class _$TestConfidenceCopyWith<$Res> implements $TestConfidenceCopyWith<$Res> {
  factory _$TestConfidenceCopyWith(_TestConfidence value, $Res Function(_TestConfidence) _then) = __$TestConfidenceCopyWithImpl;
@override @useResult
$Res call({
 ConfidenceLevel level, double score, List<String> reasons
});




}
/// @nodoc
class __$TestConfidenceCopyWithImpl<$Res>
    implements _$TestConfidenceCopyWith<$Res> {
  __$TestConfidenceCopyWithImpl(this._self, this._then);

  final _TestConfidence _self;
  final $Res Function(_TestConfidence) _then;

/// Create a copy of TestConfidence
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? level = null,Object? score = null,Object? reasons = null,}) {
  return _then(_TestConfidence(
level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as ConfidenceLevel,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double,reasons: null == reasons ? _self._reasons : reasons // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
