// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qr_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QrDataModelImpl _$$QrDataModelImplFromJson(Map<String, dynamic> json) =>
    _$QrDataModelImpl(
      id: json['id'] as String,
      data: json['data'] as String,
      date: DateTime.parse(json['date'] as String),
      type: json['type'] as String,
    );

Map<String, dynamic> _$$QrDataModelImplToJson(_$QrDataModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'data': instance.data,
      'date': instance.date.toIso8601String(),
      'type': instance.type,
    };
