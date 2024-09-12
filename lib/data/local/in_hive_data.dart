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
  }

// print(
  //     "main **** : ${DataCompressionModel.fromJson(Hive.box("DataCompression").get("mainData", defaultValue: {
  //       KeyManager.id: "",
  //       KeyManager.listOfSolders: "[]",
  //     }))}");
  // print(
  //     "data **** : ${DataCompressionModel.fromJson(Hive.box("DataCompression").get("data", defaultValue:{
  //       KeyManager.id: "",
  //       KeyManager.listOfSolders: "[]",
  //     }))}");
  @override
  DataCompressionModel getData() {
    if (getDataNull == null) {
      return DataCompressionModel.fromJson(getMainHive());
    }
    DataCompressionModel data = DataCompressionModel.fromJson(getDataHive());
    for (var e
        in (DataCompressionModel.fromJson(getMainHive()).listOfSolders ?? [])) {
      (data.listOfSolders ?? []).add(e);
    }
    return data;
  }

  @override
  void updateData(DataCompressionModel data) async {
    await Hive.box("DataCompression").put("mainData", data);
    final box = await Hive.box("DataCompression");
    if (box.get("data") == null) {
      // box.put("data", DataCompressionModel(listOfSolders: [data]).toJson());
    } else {
      final dataComp = DataCompressionModel.fromJson(box.get("data"));
      // dataComp.listOfSolders?.add(data);
      box.put("data", dataComp.toJson());
    }
  }
}
