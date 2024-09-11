import 'package:freezed_annotation/freezed_annotation.dart';
import '../../utils/annotations/freezed.dart';
import '../../utils/annotations/json_serializable.dart';
part 'qr_data_model.freezed.dart';
part 'qr_data_model.g.dart';

@freezedResponse
class QrDataModel with _$QrDataModel {
  const QrDataModel._();
  @jsonSerializableResponse
  const factory QrDataModel({
    required String id,
    required String data,
    required DateTime date,
    required String type,
  }) = _QrDataModel;

  factory QrDataModel.fromJson(Map<String, dynamic> json) => _$QrDataModelFromJson(json);
}
