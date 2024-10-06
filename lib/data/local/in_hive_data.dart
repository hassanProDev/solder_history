import 'package:hive_flutter/hive_flutter.dart';
import 'package:solder_history/core/hive_helper.dart';
import 'package:solder_history/data/model/data_compression_model.dart';
import 'package:solder_history/data/model/solder_model.dart';
import 'package:solder_history/data/repository/data_compression_repo.dart';

class InHiveData extends DataCompressionRepo {
  @override
  void addData(SolderModel data) async {
    if (getMainNull() == null) {
      box.put("mainData", DataCompressionModel(listOfSolders: [data]).toJson());
    } else {
      final dataComp = DataCompressionModel.fromJson(getMainHive());
      dataComp.listOfSolders?.add(data);
      box.put("mainData", dataComp.toJson());
    }
  }

  @override
  void deleteData() {
    box.delete("data");
    box.delete("mainData");
    box.delete("sentData");
  }

  @override
  DataCompressionModel getData() {
    DataCompressionModel data = DataCompressionModel.fromJson(getDataHive());
    for (var e
        in (DataCompressionModel.fromJson(getMainHive()).listOfSolders ?? [])) {
      (data.listOfSolders ?? []).add(e);
    }

    for (var e
        in (DataCompressionModel.fromJson(getSentHive()).listOfSolders ?? [])) {
      (data.listOfSolders ?? []).add(e);
    }
    for (var e
        in (DataCompressionModel.fromJson(getUpdateDataHive()).listOfSolders ??
            [])) {
      (data.listOfSolders ?? []).add(e);
    }
    return data;
  }

  @override
  void updateData(SolderModel solder) async {
    DataCompressionModel sentData =
        DataCompressionModel.fromJson(getSentHive());
    DataCompressionModel mainData =
        DataCompressionModel.fromJson(getMainHive());
    DataCompressionModel data = DataCompressionModel.fromJson(getDataHive());
    DataCompressionModel updateData =
        DataCompressionModel.fromJson(getUpdateDataHive());

    if ((sentData.listOfSolders ?? []).contains(solder)) {
      (sentData.listOfSolders ?? [])
          .removeWhere((e) => e.militaryId == solder.militaryId);
      box.put("sentData", sentData.toJson());
    }
    if ((mainData.listOfSolders ?? []).contains(solder)) {
      (mainData.listOfSolders ?? [])
          .removeWhere((e) => e.militaryId == solder.militaryId);
      box.put("mainData", mainData.toJson());
    }
    if ((data.listOfSolders ?? []).contains(solder)) {
      (data.listOfSolders ?? [])
          .removeWhere((e) => e.militaryId == solder.militaryId);
      box.put("data", data.toJson());
    }
    if ((updateData.listOfSolders ?? []).contains(solder)) {
      (updateData.listOfSolders ?? [])
          .removeWhere((e) => e.militaryId == solder.militaryId);
      box.put("updateData", updateData.toJson());
    }
    (updateData.listOfSolders ?? []).add(solder);
    box.put("updateData", updateData.toJson());
  }

  @override
  void addSerial(SolderModel solder) {
    final data = DataCompressionModel.fromJson(getDataHive());
    final mainData = DataCompressionModel.fromJson(getMainHive());
    final sentData = DataCompressionModel.fromJson(getSentHive());
    final updateData = DataCompressionModel.fromJson(getUpdateDataHive());

    if ((data.listOfSolders ?? [])
        .where((e) => e.militaryId == solder.militaryId)
        .isNotEmpty) {
      (sentData.listOfSolders ?? []).add(solder);
      (data.listOfSolders ?? [])
          .removeWhere((e) => e.militaryId == solder.militaryId);
      box.put("data", data.toJson());
    }

    if ((mainData.listOfSolders ?? [])
        .where((e) => e.militaryId == solder.militaryId)
        .isNotEmpty) {
      (sentData.listOfSolders ?? []).add(solder);
      (mainData.listOfSolders ?? [])
          .removeWhere((e) => e.militaryId == solder.militaryId);
      box.put("mainData", mainData.toJson());
    }
    if ((updateData.listOfSolders ?? [])
        .where((e) => e.militaryId == solder.militaryId)
        .isNotEmpty) {
      (sentData.listOfSolders ?? []).add(solder);
      (updateData.listOfSolders ?? [])
          .removeWhere((e) => e.militaryId == solder.militaryId);
      box.put("updateData", updateData.toJson());
    }
    box.put("sentData", sentData.toJson());
  }

  void addSentSolder(SolderModel solder) {
    final data = DataCompressionModel.fromJson(getDataHive());
    final sentData = DataCompressionModel.fromJson(getSentHive());

    if ((data.listOfSolders ?? [])
        .contains(solder)) {
      (sentData.listOfSolders ?? []).add(solder);
      (data.listOfSolders ?? [])
          .removeWhere((e) => e.militaryId == solder.militaryId);
      box.put("data", data.toJson());
    }

    if ((sentData.listOfSolders ?? [])
        .contains(solder)) {
      (sentData.listOfSolders ?? [])
          .removeWhere((e) => e.militaryId == solder.militaryId);
      (sentData.listOfSolders ?? []).add(solder);
    }
    box.put("sentData", sentData.toJson());
  }
}
