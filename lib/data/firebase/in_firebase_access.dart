import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:hive/hive.dart';
import 'package:restart_app/restart_app.dart';
import 'package:solder_history/core/key_manager/key_manager.dart';
import 'package:solder_history/data/model/device_access_model.dart';
import 'package:solder_history/data/model/device_auth_model.dart';

class InFirebaseAccess {
  final accessRef = FirebaseFirestore.instance.collection("auth").withConverter(
        fromFirestore: (snap, _) => DeviceAuthModel.fromJson(snap.data()!),
        toFirestore: (device, _) => device.toJson(),
      );

  Future<bool> deviceAccess() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    // String? deviceIdentifier;
    Map? auth = Hive.box("device").get("auth");
    final fireAuth = await accessRef.get();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      // deviceIdentifier = androidInfo.id; // Unique ID for Android
      if (auth == null) {
        if (fireAuth.docs.isEmpty) {
          final doc=accessRef.doc();
          final device = DeviceAuthModel(id: doc.id,change: false, listDeviceAccess: [
            DeviceAccessModel(access: false, control: false, id: androidInfo.id)
          ]);
          Hive.box("device").put("auth", device.toJson());
          doc.set(device);
        } else {
          final fireData = await accessRef.get();
          DeviceAuthModel deviceAuthModel = fireData.docs.first.data();
          if (deviceAuthModel.listDeviceAccess
              .contains((element) => element.id == androidInfo.id)) {
            Hive.box("device").put("auth", deviceAuthModel.toJson());
          } else {
            deviceAuthModel.listDeviceAccess.add(DeviceAccessModel(
                access: false, control: false, id: androidInfo.id));
            accessRef.doc(deviceAuthModel.id).update(deviceAuthModel.toJson());
            Hive.box("device").put("auth", deviceAuthModel.toJson());
          }
        }
      }
      final deviceAccess = Hive.box("device").get("auth", defaultValue: {
        KeyManager.change: false,
        KeyManager.listDeviceAccess: "[]"
      });
      DeviceAuthModel deviceAuthModel = DeviceAuthModel.fromJson(deviceAccess);
      // if( fireAuth.docs.first.data().listDeviceAccess.firstWhere((e)=>e.id==androidInfo.id).access==
      print("objectobjectobject");
      return deviceAuthModel.listDeviceAccess
          .firstWhere((e) => e.id == androidInfo.id)
          .access;
    }
    return false;
  }

  void updateAccess() async {
    Map? auth = Hive.box("device").get("auth");
    if (auth == null) return;
    try {
      accessRef
          .where(KeyManager.change, isEqualTo: true)
          .snapshots()
          .listen((e) {
          if(e.docs.isNotEmpty){
            DeviceAuthModel deviceAuthModel = e.docs.first.data();
            deviceAuthModel.change=false;
            accessRef.doc(deviceAuthModel.id).update(deviceAuthModel.toJson());
            Hive.box("device").put("auth", deviceAuthModel.toJson());
            Restart.restartApp();
          }

      });
    } on Exception catch (e) {
      // TODO
    }
  }
}

// Future<bool> checkIfAuthorized() async {
//   //  if (Platform.isIOS) {
//   // IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
//   // deviceIdentifier = iosInfo.identifierForVendor; // Unique ID for iOS
//   // }
//   // // Replace this with the unique identifier of your device
//   // // const String authorizedDeviceId = 'UE1A.230829.036.A1';
//   //
//   // return auth[deviceIdentifier] && auth[deviceIdentifier] !=
//   // null;
// }
// }
