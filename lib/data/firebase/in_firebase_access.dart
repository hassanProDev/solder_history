import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:hive/hive.dart';
import 'package:restart_app/restart_app.dart';
import 'package:solder_history/core/hive_helper.dart';
import 'package:solder_history/core/key_manager/key_manager.dart';
import 'package:solder_history/data/model/device_access_model.dart';
import 'package:solder_history/data/model/device_auth_model.dart';
import 'package:solder_history/helper/helper_method.dart';

class InFirebaseAccess {
  final accessRef = FirebaseFirestore.instance.collection("auth").withConverter(
    fromFirestore: (snap, _) => DeviceAuthModel.fromJson(snap.data()!),
    toFirestore: (device, _) => device.toJson(),
  );

  getDevices() async {
    // if (fireBaseDevices.docs.isEmpty) return;
  }

   addDevice() async {
    final doc = accessRef.doc();
    final fireBaseDevices = await accessRef.get();
    if (fireBaseDevices.docs.isEmpty) {
     return doc.set(DeviceAuthModel(
        change: false,
        listDeviceAccess: [
          DeviceAccessModel(access: false, control: false, id: androidId)
        ],
        id: doc.id,
      ),);
    }
    DeviceAuthModel deviceAuthModel = fireBaseDevices.docs.first.data();
    if (deviceAuthModel.listDeviceAccess.any((e)=>e.id==androidId)) return;
    deviceAuthModel.listDeviceAccess.add(DeviceAccessModel(access: false, control: false, id: androidId));
   return accessRef.doc(deviceAuthModel.id).update(deviceAuthModel.toJson());
  }

  updateDevice()async{
    try {
      await addDevice();
      final fireBaseDevices = await accessRef.get();
      if(fireBaseDevices.docs.isEmpty)return;
      accessRef.doc(fireBaseDevices.docs.first.data().id).snapshots().listen((e){
        if(e.data()?.change==true) {
          DeviceAuthModel deviceAuthModel = e.data()!;
          deviceAuthModel.change = false;
          accessRef.doc(fireBaseDevices.docs.first
              .data()
              .id).update(deviceAuthModel.toJson());
          deviceBox.put("auth", deviceAuthModel.toJson());
        }
        print(getAuthDevice());
      });
    } on Exception catch (e) {
      // TODO
    }
  }
}
