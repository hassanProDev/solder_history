import 'dart:convert';

import 'package:solder_history/core/key_manager/key_manager.dart';
import 'package:solder_history/data/entity/device_auth.dart';
import 'package:solder_history/data/model/device_access_model.dart';
import 'package:solder_history/helper/helper_method.dart';

class DeviceAuthModel extends DeviceAuth {
  DeviceAuthModel({
    required super.change,
    required super.listDeviceAccess,
    required super.id,
  });

  factory DeviceAuthModel.fromJson(Map json) {
    List<DeviceAccessModel> listOfDev = List<DeviceAccessModel>.from(
        jsonDecode(json[KeyManager.listDeviceAccess])
            .map((e) => DeviceAccessModel.fromJson(e))).toList();

    return DeviceAuthModel(
      id: json[KeyManager.id],
      change: json[KeyManager.change],
      listDeviceAccess: listOfDev,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      KeyManager.id: id,
      KeyManager.change: change,
      KeyManager.listDeviceAccess: jsonEncode(
          List<DeviceAccessModel>.from(listDeviceAccess ?? [])
              .map((e) => e.toJson())
              .toList()),
    };
  }
}
