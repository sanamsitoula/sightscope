// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calibration_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CalibrationResult {

/// True pixels-per-inch for this screen.
 double get ppi;/// How the PPI was established.
 CalibrationMethod get method;/// When the calibration was performed.
 DateTime get calibratedAt;/// Native screen width in pixels (0 if unknown).
 int get screenWpx;/// Native screen height in pixels (0 if unknown).
 int get screenHpx;/// Physical diagonal in inches (0 if unknown).
 double get diagonalInches;/// Recommended viewing distance (mm) used when sizing stimuli.
 double get viewingDistanceMm;
/// Create a copy of CalibrationResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalibrationResultCopyWith<CalibrationResult> get copyWith => _$CalibrationResultCopyWithImpl<CalibrationResult>(this as CalibrationResult, _$identity);

  /// Serializes this CalibrationResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalibrationResult&&(identical(other.ppi, ppi) || other.ppi == ppi)&&(identical(other.method, method) || other.method == method)&&(identical(other.calibratedAt, calibratedAt) || other.calibratedAt == calibratedAt)&&(identical(other.screenWpx, screenWpx) || other.screenWpx == screenWpx)&&(identical(other.screenHpx, screenHpx) || other.screenHpx == screenHpx)&&(identical(other.diagonalInches, diagonalInches) || other.diagonalInches == diagonalInches)&&(identical(other.viewingDistanceMm, viewingDistanceMm) || other.viewingDistanceMm == viewingDistanceMm));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ppi,method,calibratedAt,screenWpx,screenHpx,diagonalInches,viewingDistanceMm);

@override
String toString() {
  return 'CalibrationResult(ppi: $ppi, method: $method, calibratedAt: $calibratedAt, screenWpx: $screenWpx, screenHpx: $screenHpx, diagonalInches: $diagonalInches, viewingDistanceMm: $viewingDistanceMm)';
}


}

/// @nodoc
abstract mixin class $CalibrationResultCopyWith<$Res>  {
  factory $CalibrationResultCopyWith(CalibrationResult value, $Res Function(CalibrationResult) _then) = _$CalibrationResultCopyWithImpl;
@useResult
$Res call({
 double ppi, CalibrationMethod method, DateTime calibratedAt, int screenWpx, int screenHpx, double diagonalInches, double viewingDistanceMm
});




}
/// @nodoc
class _$CalibrationResultCopyWithImpl<$Res>
    implements $CalibrationResultCopyWith<$Res> {
  _$CalibrationResultCopyWithImpl(this._self, this._then);

  final CalibrationResult _self;
  final $Res Function(CalibrationResult) _then;

/// Create a copy of CalibrationResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ppi = null,Object? method = null,Object? calibratedAt = null,Object? screenWpx = null,Object? screenHpx = null,Object? diagonalInches = null,Object? viewingDistanceMm = null,}) {
  return _then(_self.copyWith(
ppi: null == ppi ? _self.ppi : ppi // ignore: cast_nullable_to_non_nullable
as double,method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as CalibrationMethod,calibratedAt: null == calibratedAt ? _self.calibratedAt : calibratedAt // ignore: cast_nullable_to_non_nullable
as DateTime,screenWpx: null == screenWpx ? _self.screenWpx : screenWpx // ignore: cast_nullable_to_non_nullable
as int,screenHpx: null == screenHpx ? _self.screenHpx : screenHpx // ignore: cast_nullable_to_non_nullable
as int,diagonalInches: null == diagonalInches ? _self.diagonalInches : diagonalInches // ignore: cast_nullable_to_non_nullable
as double,viewingDistanceMm: null == viewingDistanceMm ? _self.viewingDistanceMm : viewingDistanceMm // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [CalibrationResult].
extension CalibrationResultPatterns on CalibrationResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CalibrationResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CalibrationResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CalibrationResult value)  $default,){
final _that = this;
switch (_that) {
case _CalibrationResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CalibrationResult value)?  $default,){
final _that = this;
switch (_that) {
case _CalibrationResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double ppi,  CalibrationMethod method,  DateTime calibratedAt,  int screenWpx,  int screenHpx,  double diagonalInches,  double viewingDistanceMm)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CalibrationResult() when $default != null:
return $default(_that.ppi,_that.method,_that.calibratedAt,_that.screenWpx,_that.screenHpx,_that.diagonalInches,_that.viewingDistanceMm);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double ppi,  CalibrationMethod method,  DateTime calibratedAt,  int screenWpx,  int screenHpx,  double diagonalInches,  double viewingDistanceMm)  $default,) {final _that = this;
switch (_that) {
case _CalibrationResult():
return $default(_that.ppi,_that.method,_that.calibratedAt,_that.screenWpx,_that.screenHpx,_that.diagonalInches,_that.viewingDistanceMm);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double ppi,  CalibrationMethod method,  DateTime calibratedAt,  int screenWpx,  int screenHpx,  double diagonalInches,  double viewingDistanceMm)?  $default,) {final _that = this;
switch (_that) {
case _CalibrationResult() when $default != null:
return $default(_that.ppi,_that.method,_that.calibratedAt,_that.screenWpx,_that.screenHpx,_that.diagonalInches,_that.viewingDistanceMm);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CalibrationResult extends CalibrationResult {
  const _CalibrationResult({required this.ppi, required this.method, required this.calibratedAt, this.screenWpx = 0, this.screenHpx = 0, this.diagonalInches = 0.0, this.viewingDistanceMm = 400.0}): super._();
  factory _CalibrationResult.fromJson(Map<String, dynamic> json) => _$CalibrationResultFromJson(json);

/// True pixels-per-inch for this screen.
@override final  double ppi;
/// How the PPI was established.
@override final  CalibrationMethod method;
/// When the calibration was performed.
@override final  DateTime calibratedAt;
/// Native screen width in pixels (0 if unknown).
@override@JsonKey() final  int screenWpx;
/// Native screen height in pixels (0 if unknown).
@override@JsonKey() final  int screenHpx;
/// Physical diagonal in inches (0 if unknown).
@override@JsonKey() final  double diagonalInches;
/// Recommended viewing distance (mm) used when sizing stimuli.
@override@JsonKey() final  double viewingDistanceMm;

/// Create a copy of CalibrationResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CalibrationResultCopyWith<_CalibrationResult> get copyWith => __$CalibrationResultCopyWithImpl<_CalibrationResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CalibrationResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CalibrationResult&&(identical(other.ppi, ppi) || other.ppi == ppi)&&(identical(other.method, method) || other.method == method)&&(identical(other.calibratedAt, calibratedAt) || other.calibratedAt == calibratedAt)&&(identical(other.screenWpx, screenWpx) || other.screenWpx == screenWpx)&&(identical(other.screenHpx, screenHpx) || other.screenHpx == screenHpx)&&(identical(other.diagonalInches, diagonalInches) || other.diagonalInches == diagonalInches)&&(identical(other.viewingDistanceMm, viewingDistanceMm) || other.viewingDistanceMm == viewingDistanceMm));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ppi,method,calibratedAt,screenWpx,screenHpx,diagonalInches,viewingDistanceMm);

@override
String toString() {
  return 'CalibrationResult(ppi: $ppi, method: $method, calibratedAt: $calibratedAt, screenWpx: $screenWpx, screenHpx: $screenHpx, diagonalInches: $diagonalInches, viewingDistanceMm: $viewingDistanceMm)';
}


}

/// @nodoc
abstract mixin class _$CalibrationResultCopyWith<$Res> implements $CalibrationResultCopyWith<$Res> {
  factory _$CalibrationResultCopyWith(_CalibrationResult value, $Res Function(_CalibrationResult) _then) = __$CalibrationResultCopyWithImpl;
@override @useResult
$Res call({
 double ppi, CalibrationMethod method, DateTime calibratedAt, int screenWpx, int screenHpx, double diagonalInches, double viewingDistanceMm
});




}
/// @nodoc
class __$CalibrationResultCopyWithImpl<$Res>
    implements _$CalibrationResultCopyWith<$Res> {
  __$CalibrationResultCopyWithImpl(this._self, this._then);

  final _CalibrationResult _self;
  final $Res Function(_CalibrationResult) _then;

/// Create a copy of CalibrationResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ppi = null,Object? method = null,Object? calibratedAt = null,Object? screenWpx = null,Object? screenHpx = null,Object? diagonalInches = null,Object? viewingDistanceMm = null,}) {
  return _then(_CalibrationResult(
ppi: null == ppi ? _self.ppi : ppi // ignore: cast_nullable_to_non_nullable
as double,method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as CalibrationMethod,calibratedAt: null == calibratedAt ? _self.calibratedAt : calibratedAt // ignore: cast_nullable_to_non_nullable
as DateTime,screenWpx: null == screenWpx ? _self.screenWpx : screenWpx // ignore: cast_nullable_to_non_nullable
as int,screenHpx: null == screenHpx ? _self.screenHpx : screenHpx // ignore: cast_nullable_to_non_nullable
as int,diagonalInches: null == diagonalInches ? _self.diagonalInches : diagonalInches // ignore: cast_nullable_to_non_nullable
as double,viewingDistanceMm: null == viewingDistanceMm ? _self.viewingDistanceMm : viewingDistanceMm // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
