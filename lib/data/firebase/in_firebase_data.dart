import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:solder_history/core/hive_helper.dart';
import 'package:solder_history/core/key_manager/key_manager.dart';
import 'package:solder_history/data/model/data_compression_model.dart';
import 'package:solder_history/data/model/solder_model.dart';
import 'package:solder_history/data/repository/firebase_comp_repo.dart';

class InFirebaseData extends FirebaseCompRepo {
  final dataCompressionRef = FirebaseFirestore.instance
      .collection("DataCompression")
      .withConverter<DataCompressionModel>(
          fromFirestore: (snapshot, _) =>
              DataCompressionModel.fromJson(snapshot.data()!),
          toFirestore: (dataCompressionModel, _) =>
              dataCompressionModel.toJson());

  @override
  void addData(DataCompressionModel data) async {
    try {
      final doc = dataCompressionRef.doc();
      doc.set(
          DataCompressionModel(id: doc.id, listOfSolders: data.listOfSolders));
    } on Exception catch (e) {
      // print(e.toString());
    }
  }

  @override
  void deleteData(SolderModel solder, bool isConnected) async {
    try {
      DataCompressionModel mainData =
          DataCompressionModel.fromJson(getMainHive());
      DataCompressionModel data = DataCompressionModel.fromJson(getDataHive());
      if ((mainData.listOfSolders ?? []).contains(solder) && isConnected) {
        final snap = await dataCompressionRef.get();

        if (snap.docs.isEmpty) return;
        DataCompressionModel fireData = snap.docs.first.data();
        // print("before ${fireData.listOfSolders ?? []}");
        (fireData.listOfSolders ?? [])
            .removeWhere((e) => e.militaryId == solder.militaryId);
        // print("after ${fireData.listOfSolders ?? []}");

        dataCompressionRef.doc(fireData.id).update(fireData.toJson());
        box.put("data", fireData.toJson());
      }
      if ((mainData.listOfSolders ?? []).contains(solder)) {
        (mainData.listOfSolders ?? [])
            .removeWhere((e) => e.militaryId == solder.militaryId);
        box.put("mainData", mainData.toJson());
      }
    } on Exception catch (e) {
      // print("delete solder : ${e.toString()}");
    }
  }

  @override
  Stream<DocumentSnapshot<DataCompressionModel>> getData() {
    return dataCompressionRef.doc().snapshots();
  }

  getDoc(String id) {
    return dataCompressionRef.doc(id).get();
  }

  @override
  void updateData() async {
    DataCompressionModel data = DataCompressionModel.fromJson(getMainHive());
    if (data.listOfSolders == []) return;
    final snap = await dataCompressionRef.get();
    if (snap.docs.isEmpty) {
      addData(data);
    } else {
      DataCompressionModel dataComp = snap.docs.first.data();
      for (var e in (data.listOfSolders ?? [])) {
        (dataComp.listOfSolders ?? []).add(e);
      }
      dataCompressionRef.doc(dataComp.id).update(dataComp.toJson());
    }
    await box.delete("mainData");
    final fireData = await dataCompressionRef.get();
    box.put("data", fireData.docs.first.data().toJson());
  }

  @override
  void refreshData() async {
    final data = await dataCompressionRef.get();
    box.put("data", data.docs.first.data().toJson());
  }

  sendHistory(SolderModel solder) async {
    DataCompressionModel mainData =
        DataCompressionModel.fromJson(getMainHive());
    DataCompressionModel data = DataCompressionModel.fromJson(getDataHive());
    int index;
    if ((mainData.listOfSolders ?? []).contains(solder)) {
      index = (mainData.listOfSolders ?? []).indexWhere((e) => e == solder);
      (mainData.listOfSolders ?? [])[index] == solder;
      box.put("mainData", mainData.toJson());
    }
    if ((data.listOfSolders ?? []).contains(solder)) {
      index = (data.listOfSolders ?? []).indexWhere((e) => e == solder);
      (data.listOfSolders ?? [])[index] = solder;
      box.put("update", "value");
    }
  }
}
