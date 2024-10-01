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
        fromFirestore: (snap, _) => DeviceAccessModel.fromJson(snap.data()!),
        toFirestore: (device, _) => device.toJson(),
      );

  getDevices() async {
    // if (fireBaseDevices.docs.isEmpty) return;
  }

  Future<void> addDevice() async {
    final doc = accessRef.doc();
    if (await checkIfDocExistsByField()) return;
    DeviceAccessModel deviceAccessModel = DeviceAccessModel(
      access: false,
      control: false,
      name: null,
      devId: androidId,
      id: doc.id,
    );
    doc.set(deviceAccessModel);
    deviceBox.put("auth", deviceAccessModel.toJson());
  }

  Future<bool> checkIfDocExistsByField() async {
    try {
      QuerySnapshot querySnapshot = await accessRef
          .where(KeyManager.devId, isEqualTo: androidId)
          .limit(1)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      // print('Error checking document by field: $e');
      return false;
    }
  }

  Future<void> updateDevice() async {
    try {
      await addDevice();
      if (!(await checkIfDocExistsByField())) return;
      accessRef
          .where(KeyManager.devId, isEqualTo: androidId)
          .limit(1)
          .snapshots()
          .listen((e) {
        if (e.docs.first.data().access !=
                DeviceAccessModel.fromJson(getAuthDevice()).access ||
            e.docs.first.data().control !=
                DeviceAccessModel.fromJson(getAuthDevice()).control) {
          deviceBox.put("auth", e.docs.first.data().toJson());
        }
      });
    } on Exception catch (e) {
      // TODO
    }
  }
}
