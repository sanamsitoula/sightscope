// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'test_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TestResult {

 String get testId;/// Semver of the test protocol that produced this result.
 String get testVersion; DateTime get date; String get deviceModel;/// Human-readable screen size, e.g. "1080x2400".
 String get screenSize;/// True PPI used to size stimuli.
 double get screenDensity; double? get brightnessIfAvailable;/// Viewing distance in millimetres.
 double? get viewingDistance; Eye get eyeTested; CorrectionUsed get correctionUsed; List<TestResponse> get rawResponses; TestScoring get scoring; TestConfidence get confidence; String? get environmentNotes;/// Engine session id (for resume / linkage).
 String? get sessionId;
/// Create a copy of TestResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TestResultCopyWith<TestResult> get copyWith => _$TestResultCopyWithImpl<TestResult>(this as TestResult, _$identity);

  /// Serializes this TestResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TestResult&&(identical(other.testId, testId) || other.testId == testId)&&(identical(other.testVersion, testVersion) || other.testVersion == testVersion)&&(identical(other.date, date) || other.date == date)&&(identical(other.deviceModel, deviceModel) || other.deviceModel == deviceModel)&&(identical(other.screenSize, screenSize) || other.screenSize == screenSize)&&(identical(other.screenDensity, screenDensity) || other.screenDensity == screenDensity)&&(identical(other.brightnessIfAvailable, brightnessIfAvailable) || other.brightnessIfAvailable == brightnessIfAvailable)&&(identical(other.viewingDistance, viewingDistance) || other.viewingDistance == viewingDistance)&&(identical(other.eyeTested, eyeTested) || other.eyeTested == eyeTested)&&(identical(other.correctionUsed, correctionUsed) || other.correctionUsed == correctionUsed)&&const DeepCollectionEquality().equals(other.rawResponses, rawResponses)&&(identical(other.scoring, scoring) || other.scoring == scoring)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&(identical(other.environmentNotes, environmentNotes) || other.environmentNotes == environmentNotes)&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,testId,testVersion,date,deviceModel,screenSize,screenDensity,brightnessIfAvailable,viewingDistance,eyeTested,correctionUsed,const DeepCollectionEquality().hash(rawResponses),scoring,confidence,environmentNotes,sessionId);

@override
String toString() {
  return 'TestResult(testId: $testId, testVersion: $testVersion, date: $date, deviceModel: $deviceModel, screenSize: $screenSize, screenDensity: $screenDensity, brightnessIfAvailable: $brightnessIfAvailable, viewingDistance: $viewingDistance, eyeTested: $eyeTested, correctionUsed: $correctionUsed, rawResponses: $rawResponses, scoring: $scoring, confidence: $confidence, environmentNotes: $environmentNotes, sessionId: $sessionId)';
}


}

/// @nodoc
abstract mixin class $TestResultCopyWith<$Res>  {
  factory $TestResultCopyWith(TestResult value, $Res Function(TestResult) _then) = _$TestResultCopyWithImpl;
@useResult
$Res call({
 String testId, String testVersion, DateTime date, String deviceModel, String screenSize, double screenDensity, double? brightnessIfAvailable, double? viewingDistance, Eye eyeTested, CorrectionUsed correctionUsed, List<TestResponse> rawResponses, TestScoring scoring, TestConfidence confidence, String? environmentNotes, String? sessionId
});


$TestScoringCopyWith<$Res> get scoring;$TestConfidenceCopyWith<$Res> get confidence;

}
/// @nodoc
class _$TestResultCopyWithImpl<$Res>
    implements $TestResultCopyWith<$Res> {
  _$TestResultCopyWithImpl(this._self, this._then);

  final TestResult _self;
  final $Res Function(TestResult) _then;

/// Create a copy of TestResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? testId = null,Object? testVersion = null,Object? date = null,Object? deviceModel = null,Object? screenSize = null,Object? screenDensity = null,Object? brightnessIfAvailable = freezed,Object? viewingDistance = freezed,Object? eyeTested = null,Object? correctionUsed = null,Object? rawResponses = null,Object? scoring = null,Object? confidence = null,Object? environmentNotes = freezed,Object? sessionId = freezed,}) {
  return _then(_self.copyWith(
testId: null == testId ? _self.testId : testId // ignore: cast_nullable_to_non_nullable
as String,testVersion: null == testVersion ? _self.testVersion : testVersion // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,deviceModel: null == deviceModel ? _self.deviceModel : deviceModel // ignore: cast_nullable_to_non_nullable
as String,screenSize: null == screenSize ? _self.screenSize : screenSize // ignore: cast_nullable_to_non_nullable
as String,screenDensity: null == screenDensity ? _self.screenDensity : screenDensity // ignore: cast_nullable_to_non_nullable
as double,brightnessIfAvailable: freezed == brightnessIfAvailable ? _self.brightnessIfAvailable : brightnessIfAvailable // ignore: cast_nullable_to_non_nullable
as double?,viewingDistance: freezed == viewingDistance ? _self.viewingDistance : viewingDistance // ignore: cast_nullable_to_non_nullable
as double?,eyeTested: null == eyeTested ? _self.eyeTested : eyeTested // ignore: cast_nullable_to_non_nullable
as Eye,correctionUsed: null == correctionUsed ? _self.correctionUsed : correctionUsed // ignore: cast_nullable_to_non_nullable
as CorrectionUsed,rawResponses: null == rawResponses ? _self.rawResponses : rawResponses // ignore: cast_nullable_to_non_nullable
as List<TestResponse>,scoring: null == scoring ? _self.scoring : scoring // ignore: cast_nullable_to_non_nullable
as TestScoring,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as TestConfidence,environmentNotes: freezed == environmentNotes ? _self.environmentNotes : environmentNotes // ignore: cast_nullable_to_non_nullable
as String?,sessionId: freezed == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of TestResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TestScoringCopyWith<$Res> get scoring {
  
  return $TestScoringCopyWith<$Res>(_self.scoring, (value) {
    return _then(_self.copyWith(scoring: value));
  });
}/// Create a copy of TestResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TestConfidenceCopyWith<$Res> get confidence {
  
  return $TestConfidenceCopyWith<$Res>(_self.confidence, (value) {
    return _then(_self.copyWith(confidence: value));
  });
}
}


/// Adds pattern-matching-related methods to [TestResult].
extension TestResultPatterns on TestResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TestResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TestResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TestResult value)  $default,){
final _that = this;
switch (_that) {
case _TestResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TestResult value)?  $default,){
final _that = this;
switch (_that) {
case _TestResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String testId,  String testVersion,  DateTime date,  String deviceModel,  String screenSize,  double screenDensity,  double? brightnessIfAvailable,  double? viewingDistance,  Eye eyeTested,  CorrectionUsed correctionUsed,  List<TestResponse> rawResponses,  TestScoring scoring,  TestConfidence confidence,  String? environmentNotes,  String? sessionId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TestResult() when $default != null:
return $default(_that.testId,_that.testVersion,_that.date,_that.deviceModel,_that.screenSize,_that.screenDensity,_that.brightnessIfAvailable,_that.viewingDistance,_that.eyeTested,_that.correctionUsed,_that.rawResponses,_that.scoring,_that.confidence,_that.environmentNotes,_that.sessionId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String testId,  String testVersion,  DateTime date,  String deviceModel,  String screenSize,  double screenDensity,  double? brightnessIfAvailable,  double? viewingDistance,  Eye eyeTested,  CorrectionUsed correctionUsed,  List<TestResponse> rawResponses,  TestScoring scoring,  TestConfidence confidence,  String? environmentNotes,  String? sessionId)  $default,) {final _that = this;
switch (_that) {
case _TestResult():
return $default(_that.testId,_that.testVersion,_that.date,_that.deviceModel,_that.screenSize,_that.screenDensity,_that.brightnessIfAvailable,_that.viewingDistance,_that.eyeTested,_that.correctionUsed,_that.rawResponses,_that.scoring,_that.confidence,_that.environmentNotes,_that.sessionId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String testId,  String testVersion,  DateTime date,  String deviceModel,  String screenSize,  double screenDensity,  double? brightnessIfAvailable,  double? viewingDistance,  Eye eyeTested,  CorrectionUsed correctionUsed,  List<TestResponse> rawResponses,  TestScoring scoring,  TestConfidence confidence,  String? environmentNotes,  String? sessionId)?  $default,) {final _that = this;
switch (_that) {
case _TestResult() when $default != null:
return $default(_that.testId,_that.testVersion,_that.date,_that.deviceModel,_that.screenSize,_that.screenDensity,_that.brightnessIfAvailable,_that.viewingDistance,_that.eyeTested,_that.correctionUsed,_that.rawResponses,_that.scoring,_that.confidence,_that.environmentNotes,_that.sessionId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TestResult extends TestResult {
  const _TestResult({required this.testId, required this.testVersion, required this.date, required this.deviceModel, required this.screenSize, required this.screenDensity, this.brightnessIfAvailable, this.viewingDistance, required this.eyeTested, required this.correctionUsed, final  List<TestResponse> rawResponses = const <TestResponse>[], required this.scoring, required this.confidence, this.environmentNotes, this.sessionId}): _rawResponses = rawResponses,super._();
  factory _TestResult.fromJson(Map<String, dynamic> json) => _$TestResultFromJson(json);

@override final  String testId;
/// Semver of the test protocol that produced this result.
@override final  String testVersion;
@override final  DateTime date;
@override final  String deviceModel;
/// Human-readable screen size, e.g. "1080x2400".
@override final  String screenSize;
/// True PPI used to size stimuli.
@override final  double screenDensity;
@override final  double? brightnessIfAvailable;
/// Viewing distance in millimetres.
@override final  double? viewingDistance;
@override final  Eye eyeTested;
@override final  CorrectionUsed correctionUsed;
 final  List<TestResponse> _rawResponses;
@override@JsonKey() List<TestResponse> get rawResponses {
  if (_rawResponses is EqualUnmodifiableListView) return _rawResponses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rawResponses);
}

@override final  TestScoring scoring;
@override final  TestConfidence confidence;
@override final  String? environmentNotes;
/// Engine session id (for resume / linkage).
@override final  String? sessionId;

/// Create a copy of TestResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TestResultCopyWith<_TestResult> get copyWith => __$TestResultCopyWithImpl<_TestResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TestResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TestResult&&(identical(other.testId, testId) || other.testId == testId)&&(identical(other.testVersion, testVersion) || other.testVersion == testVersion)&&(identical(other.date, date) || other.date == date)&&(identical(other.deviceModel, deviceModel) || other.deviceModel == deviceModel)&&(identical(other.screenSize, screenSize) || other.screenSize == screenSize)&&(identical(other.screenDensity, screenDensity) || other.screenDensity == screenDensity)&&(identical(other.brightnessIfAvailable, brightnessIfAvailable) || other.brightnessIfAvailable == brightnessIfAvailable)&&(identical(other.viewingDistance, viewingDistance) || other.viewingDistance == viewingDistance)&&(identical(other.eyeTested, eyeTested) || other.eyeTested == eyeTested)&&(identical(other.correctionUsed, correctionUsed) || other.correctionUsed == correctionUsed)&&const DeepCollectionEquality().equals(other._rawResponses, _rawResponses)&&(identical(other.scoring, scoring) || other.scoring == scoring)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&(identical(other.environmentNotes, environmentNotes) || other.environmentNotes == environmentNotes)&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,testId,testVersion,date,deviceModel,screenSize,screenDensity,brightnessIfAvailable,viewingDistance,eyeTested,correctionUsed,const DeepCollectionEquality().hash(_rawResponses),scoring,confidence,environmentNotes,sessionId);

@override
String toString() {
  return 'TestResult(testId: $testId, testVersion: $testVersion, date: $date, deviceModel: $deviceModel, screenSize: $screenSize, screenDensity: $screenDensity, brightnessIfAvailable: $brightnessIfAvailable, viewingDistance: $viewingDistance, eyeTested: $eyeTested, correctionUsed: $correctionUsed, rawResponses: $rawResponses, scoring: $scoring, confidence: $confidence, environmentNotes: $environmentNotes, sessionId: $sessionId)';
}


}

/// @nodoc
abstract mixin class _$TestResultCopyWith<$Res> implements $TestResultCopyWith<$Res> {
  factory _$TestResultCopyWith(_TestResult value, $Res Function(_TestResult) _then) = __$TestResultCopyWithImpl;
@override @useResult
$Res call({
 String testId, String testVersion, DateTime date, String deviceModel, String screenSize, double screenDensity, double? brightnessIfAvailable, double? viewingDistance, Eye eyeTested, CorrectionUsed correctionUsed, List<TestResponse> rawResponses, TestScoring scoring, TestConfidence confidence, String? environmentNotes, String? sessionId
});


@override $TestScoringCopyWith<$Res> get scoring;@override $TestConfidenceCopyWith<$Res> get confidence;

}
/// @nodoc
class __$TestResultCopyWithImpl<$Res>
    implements _$TestResultCopyWith<$Res> {
  __$TestResultCopyWithImpl(this._self, this._then);

  final _TestResult _self;
  final $Res Function(_TestResult) _then;

/// Create a copy of TestResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? testId = null,Object? testVersion = null,Object? date = null,Object? deviceModel = null,Object? screenSize = null,Object? screenDensity = null,Object? brightnessIfAvailable = freezed,Object? viewingDistance = freezed,Object? eyeTested = null,Object? correctionUsed = null,Object? rawResponses = null,Object? scoring = null,Object? confidence = null,Object? environmentNotes = freezed,Object? sessionId = freezed,}) {
  return _then(_TestResult(
testId: null == testId ? _self.testId : testId // ignore: cast_nullable_to_non_nullable
as String,testVersion: null == testVersion ? _self.testVersion : testVersion // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,deviceModel: null == deviceModel ? _self.deviceModel : deviceModel // ignore: cast_nullable_to_non_nullable
as String,screenSize: null == screenSize ? _self.screenSize : screenSize // ignore: cast_nullable_to_non_nullable
as String,screenDensity: null == screenDensity ? _self.screenDensity : screenDensity // ignore: cast_nullable_to_non_nullable
as double,brightnessIfAvailable: freezed == brightnessIfAvailable ? _self.brightnessIfAvailable : brightnessIfAvailable // ignore: cast_nullable_to_non_nullable
as double?,viewingDistance: freezed == viewingDistance ? _self.viewingDistance : viewingDistance // ignore: cast_nullable_to_non_nullable
as double?,eyeTested: null == eyeTested ? _self.eyeTested : eyeTested // ignore: cast_nullable_to_non_nullable
as Eye,correctionUsed: null == correctionUsed ? _self.correctionUsed : correctionUsed // ignore: cast_nullable_to_non_nullable
as CorrectionUsed,rawResponses: null == rawResponses ? _self._rawResponses : rawResponses // ignore: cast_nullable_to_non_nullable
as List<TestResponse>,scoring: null == scoring ? _self.scoring : scoring // ignore: cast_nullable_to_non_nullable
as TestScoring,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as TestConfidence,environmentNotes: freezed == environmentNotes ? _self.environmentNotes : environmentNotes // ignore: cast_nullable_to_non_nullable
as String?,sessionId: freezed == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of TestResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TestScoringCopyWith<$Res> get scoring {
  
  return $TestScoringCopyWith<$Res>(_self.scoring, (value) {
    return _then(_self.copyWith(scoring: value));
  });
}/// Create a copy of TestResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TestConfidenceCopyWith<$Res> get confidence {
  
  return $TestConfidenceCopyWith<$Res>(_self.confidence, (value) {
    return _then(_self.copyWith(confidence: value));
  });
}
}

// dart format on
