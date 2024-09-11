// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'qr_data_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

QrDataModel _$QrDataModelFromJson(Map<String, dynamic> json) {
  return _QrDataModel.fromJson(json);
}

/// @nodoc
mixin _$QrDataModel {
  String get id => throw _privateConstructorUsedError;
  String get data => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  /// Serializes this QrDataModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QrDataModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QrDataModelCopyWith<QrDataModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QrDataModelCopyWith<$Res> {
  factory $QrDataModelCopyWith(
          QrDataModel value, $Res Function(QrDataModel) then) =
      _$QrDataModelCopyWithImpl<$Res, QrDataModel>;
  @useResult
  $Res call({String id, String data, DateTime date, String type});
}

/// @nodoc
class _$QrDataModelCopyWithImpl<$Res, $Val extends QrDataModel>
    implements $QrDataModelCopyWith<$Res> {
  _$QrDataModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QrDataModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? data = null,
    Object? date = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QrDataModelImplCopyWith<$Res>
    implements $QrDataModelCopyWith<$Res> {
  factory _$$QrDataModelImplCopyWith(
          _$QrDataModelImpl value, $Res Function(_$QrDataModelImpl) then) =
      __$$QrDataModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String data, DateTime date, String type});
}

/// @nodoc
class __$$QrDataModelImplCopyWithImpl<$Res>
    extends _$QrDataModelCopyWithImpl<$Res, _$QrDataModelImpl>
    implements _$$QrDataModelImplCopyWith<$Res> {
  __$$QrDataModelImplCopyWithImpl(
      _$QrDataModelImpl _value, $Res Function(_$QrDataModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of QrDataModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? data = null,
    Object? date = null,
    Object? type = null,
  }) {
    return _then(_$QrDataModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@jsonSerializableResponse
class _$QrDataModelImpl extends _QrDataModel {
  const _$QrDataModelImpl(
      {required this.id,
      required this.data,
      required this.date,
      required this.type})
      : super._();

  factory _$QrDataModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$QrDataModelImplFromJson(json);

  @override
  final String id;
  @override
  final String data;
  @override
  final DateTime date;
  @override
  final String type;

  @override
  String toString() {
    return 'QrDataModel(id: $id, data: $data, date: $date, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QrDataModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, data, date, type);

  /// Create a copy of QrDataModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QrDataModelImplCopyWith<_$QrDataModelImpl> get copyWith =>
      __$$QrDataModelImplCopyWithImpl<_$QrDataModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QrDataModelImplToJson(
      this,
    );
  }
}

abstract class _QrDataModel extends QrDataModel {
  const factory _QrDataModel(
      {required final String id,
      required final String data,
      required final DateTime date,
      required final String type}) = _$QrDataModelImpl;
  const _QrDataModel._() : super._();

  factory _QrDataModel.fromJson(Map<String, dynamic> json) =
      _$QrDataModelImpl.fromJson;

  @override
  String get id;
  @override
  String get data;
  @override
  DateTime get date;
  @override
  String get type;

  /// Create a copy of QrDataModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QrDataModelImplCopyWith<_$QrDataModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
