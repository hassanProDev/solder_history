import 'dart:convert';

import 'package:solder_history/core/key_manager/key_manager.dart';
import 'package:solder_history/data/entity/device_auth.dart';
import 'package:solder_history/data/model/device_access_model.dart';

class DeviceAuthModel extends DeviceAuth {

  DeviceAuthModel({required super.change, required super.listDeviceAccess, required super.id});

  factory DeviceAuthModel.fromJson(Map json) {
    return DeviceAuthModel(
      id: json[KeyManager.id],
      change: json[KeyManager.change],
      listDeviceAccess: List<DeviceAccessModel>.from(
          jsonDecode(json[KeyManager.listDeviceAccess])
              .map((e) => DeviceAccessModel.fromJson(e))).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      KeyManager.id:id,
      KeyManager.change: change,
      KeyManager.listDeviceAccess: jsonEncode(
          List<DeviceAccessModel>.from(listDeviceAccess ?? [])
              .map((e) => e.toJson())
              .toList()),
    };
  }
}
