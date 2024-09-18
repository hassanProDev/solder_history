import 'package:solder_history/core/key_manager/key_manager.dart';
import 'package:solder_history/data/entity/device_access.dart';

class DeviceAccessModel extends DeviceAccess {
  DeviceAccessModel(
      {required super.access,
      required super.control,
      required super.id,
      required super.devId,
      super.name});

  factory DeviceAccessModel.fromJson(Map json) {
    return DeviceAccessModel(
      access: json[KeyManager.access],
      control: json[KeyManager.control],
      devId: json[KeyManager.devId],
      name: json[KeyManager.name],
      id: json[KeyManager.id],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      KeyManager.id: id,
      KeyManager.access: access,
      KeyManager.control: control,
      KeyManager.name: name,
      KeyManager.devId: devId,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeviceAccessModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
