import 'package:hive_flutter/hive_flutter.dart';
import 'package:solder_history/core/key_manager/key_manager.dart';
import 'package:solder_history/data/entity/data_compression.dart';
import 'package:solder_history/data/model/data_compression_model.dart';
import 'package:solder_history/data/model/solder_model.dart';
import 'package:solder_history/data/repository/data_compression_repo.dart';

import 'package:solder_history/data/solder_details.dart';

class DataCompressionManager {
  DataCompressionRepo repo;

  // GetHiveData getHiveData;
  // GetFirebaseData getFirebaseData;
  DataCompressionManager(
    this.repo,
  );

  void addData(SolderModel data) {
    repo.addData(data);
  }

  void deleteData() {
    repo.deleteData();
  }

  void updateData(SolderModel data) {
    repo.updateData(data);
  }

  DataCompressionModel getData() {
    return repo.getData();
  }
  void addSerial(SolderModel solder){
    repo.addSerial(solder);
  }
}
