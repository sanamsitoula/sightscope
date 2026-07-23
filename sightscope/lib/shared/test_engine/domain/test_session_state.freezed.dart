// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'test_session_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TestSessionState {

 TestSessionPhase get phase; List<String> get log; TestStimulus? get currentStimulus; bool get isPractice; TestResult? get result;
/// Create a copy of TestSessionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TestSessionStateCopyWith<TestSessionState> get copyWith => _$TestSessionStateCopyWithImpl<TestSessionState>(this as TestSessionState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TestSessionState&&(identical(other.phase, phase) || other.phase == phase)&&const DeepCollectionEquality().equals(other.log, log)&&(identical(other.currentStimulus, currentStimulus) || other.currentStimulus == currentStimulus)&&(identical(other.isPractice, isPractice) || other.isPractice == isPractice)&&(identical(other.result, result) || other.result == result));
}


@override
int get hashCode => Object.hash(runtimeType,phase,const DeepCollectionEquality().hash(log),currentStimulus,isPractice,result);

@override
String toString() {
  return 'TestSessionState(phase: $phase, log: $log, currentStimulus: $currentStimulus, isPractice: $isPractice, result: $result)';
}


}

/// @nodoc
abstract mixin class $TestSessionStateCopyWith<$Res>  {
  factory $TestSessionStateCopyWith(TestSessionState value, $Res Function(TestSessionState) _then) = _$TestSessionStateCopyWithImpl;
@useResult
$Res call({
 TestSessionPhase phase, List<String> log, TestStimulus? currentStimulus, bool isPractice, TestResult? result
});


$TestStimulusCopyWith<$Res>? get currentStimulus;$TestResultCopyWith<$Res>? get result;

}
/// @nodoc
class _$TestSessionStateCopyWithImpl<$Res>
    implements $TestSessionStateCopyWith<$Res> {
  _$TestSessionStateCopyWithImpl(this._self, this._then);

  final TestSessionState _self;
  final $Res Function(TestSessionState) _then;

/// Create a copy of TestSessionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? phase = null,Object? log = null,Object? currentStimulus = freezed,Object? isPractice = null,Object? result = freezed,}) {
  return _then(_self.copyWith(
phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as TestSessionPhase,log: null == log ? _self.log : log // ignore: cast_nullable_to_non_nullable
as List<String>,currentStimulus: freezed == currentStimulus ? _self.currentStimulus : currentStimulus // ignore: cast_nullable_to_non_nullable
as TestStimulus?,isPractice: null == isPractice ? _self.isPractice : isPractice // ignore: cast_nullable_to_non_nullable
as bool,result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as TestResult?,
  ));
}
/// Create a copy of TestSessionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TestStimulusCopyWith<$Res>? get currentStimulus {
    if (_self.currentStimulus == null) {
    return null;
  }

  return $TestStimulusCopyWith<$Res>(_self.currentStimulus!, (value) {
    return _then(_self.copyWith(currentStimulus: value));
  });
}/// Create a copy of TestSessionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TestResultCopyWith<$Res>? get result {
    if (_self.result == null) {
    return null;
  }

  return $TestResultCopyWith<$Res>(_self.result!, (value) {
    return _then(_self.copyWith(result: value));
  });
}
}


/// Adds pattern-matching-related methods to [TestSessionState].
extension TestSessionStatePatterns on TestSessionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TestSessionState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TestSessionState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TestSessionState value)  $default,){
final _that = this;
switch (_that) {
case _TestSessionState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TestSessionState value)?  $default,){
final _that = this;
switch (_that) {
case _TestSessionState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TestSessionPhase phase,  List<String> log,  TestStimulus? currentStimulus,  bool isPractice,  TestResult? result)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TestSessionState() when $default != null:
return $default(_that.phase,_that.log,_that.currentStimulus,_that.isPractice,_that.result);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TestSessionPhase phase,  List<String> log,  TestStimulus? currentStimulus,  bool isPractice,  TestResult? result)  $default,) {final _that = this;
switch (_that) {
case _TestSessionState():
return $default(_that.phase,_that.log,_that.currentStimulus,_that.isPractice,_that.result);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TestSessionPhase phase,  List<String> log,  TestStimulus? currentStimulus,  bool isPractice,  TestResult? result)?  $default,) {final _that = this;
switch (_that) {
case _TestSessionState() when $default != null:
return $default(_that.phase,_that.log,_that.currentStimulus,_that.isPractice,_that.result);case _:
  return null;

}
}

}

/// @nodoc


class _TestSessionState extends TestSessionState {
  const _TestSessionState({this.phase = TestSessionPhase.notStarted, final  List<String> log = const <String>[], this.currentStimulus, this.isPractice = false, this.result}): _log = log,super._();
  

@override@JsonKey() final  TestSessionPhase phase;
 final  List<String> _log;
@override@JsonKey() List<String> get log {
  if (_log is EqualUnmodifiableListView) return _log;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_log);
}

@override final  TestStimulus? currentStimulus;
@override@JsonKey() final  bool isPractice;
@override final  TestResult? result;

/// Create a copy of TestSessionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TestSessionStateCopyWith<_TestSessionState> get copyWith => __$TestSessionStateCopyWithImpl<_TestSessionState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TestSessionState&&(identical(other.phase, phase) || other.phase == phase)&&const DeepCollectionEquality().equals(other._log, _log)&&(identical(other.currentStimulus, currentStimulus) || other.currentStimulus == currentStimulus)&&(identical(other.isPractice, isPractice) || other.isPractice == isPractice)&&(identical(other.result, result) || other.result == result));
}


@override
int get hashCode => Object.hash(runtimeType,phase,const DeepCollectionEquality().hash(_log),currentStimulus,isPractice,result);

@override
String toString() {
  return 'TestSessionState(phase: $phase, log: $log, currentStimulus: $currentStimulus, isPractice: $isPractice, result: $result)';
}


}

/// @nodoc
abstract mixin class _$TestSessionStateCopyWith<$Res> implements $TestSessionStateCopyWith<$Res> {
  factory _$TestSessionStateCopyWith(_TestSessionState value, $Res Function(_TestSessionState) _then) = __$TestSessionStateCopyWithImpl;
@override @useResult
$Res call({
 TestSessionPhase phase, List<String> log, TestStimulus? currentStimulus, bool isPractice, TestResult? result
});


@override $TestStimulusCopyWith<$Res>? get currentStimulus;@override $TestResultCopyWith<$Res>? get result;

}
/// @nodoc
class __$TestSessionStateCopyWithImpl<$Res>
    implements _$TestSessionStateCopyWith<$Res> {
  __$TestSessionStateCopyWithImpl(this._self, this._then);

  final _TestSessionState _self;
  final $Res Function(_TestSessionState) _then;

/// Create a copy of TestSessionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phase = null,Object? log = null,Object? currentStimulus = freezed,Object? isPractice = null,Object? result = freezed,}) {
  return _then(_TestSessionState(
phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as TestSessionPhase,log: null == log ? _self._log : log // ignore: cast_nullable_to_non_nullable
as List<String>,currentStimulus: freezed == currentStimulus ? _self.currentStimulus : currentStimulus // ignore: cast_nullable_to_non_nullable
as TestStimulus?,isPractice: null == isPractice ? _self.isPractice : isPractice // ignore: cast_nullable_to_non_nullable
as bool,result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as TestResult?,
  ));
}

/// Create a copy of TestSessionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TestStimulusCopyWith<$Res>? get currentStimulus {
    if (_self.currentStimulus == null) {
    return null;
  }

  return $TestStimulusCopyWith<$Res>(_self.currentStimulus!, (value) {
    return _then(_self.copyWith(currentStimulus: value));
  });
}/// Create a copy of TestSessionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TestResultCopyWith<$Res>? get result {
    if (_self.result == null) {
    return null;
  }

  return $TestResultCopyWith<$Res>(_self.result!, (value) {
    return _then(_self.copyWith(result: value));
  });
}
}

// dart format on
