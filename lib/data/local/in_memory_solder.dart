
import 'package:hive/hive.dart';
import 'package:solder_history/data/entity/solder.dart';
import 'package:solder_history/data/local/in_hive_data.dart';
import 'package:solder_history/data/manager/data_compression_manager.dart';
import 'package:solder_history/data/model/data_compression_model.dart';
import 'package:solder_history/data/model/solder_model.dart';
import 'package:solder_history/data/repository/data_compression_repo.dart';
import 'package:solder_history/data/repository/solder_repo.dart';

class InMemorySolder extends SolderRepo {
  List<SolderModel> solders = [];

  @override
  void addSolder(SolderModel solder) async {
    // final data=Hive.box("DataCompression").get("data",defaultValue: DataCompressionModel(id: ,listOfSolders: []).toJson());
    solders.add(solder);
  }

  @override
  void deleteSolder(String militaryId) {
    solders.removeWhere((e) => e.militaryId == militaryId);
  }

  @override
  List<SolderModel> getAllSolder() {
    return solders;
  }

  @override
  Solder getSolder(String info) {
    return solders.firstWhere(
      (e) =>
          e.militaryId == info ||
          e.name == info ||
          e.tripleNumber == info ||
          e.phoneNumber == info ||
          e.idNumber == info,
    );
  }

  @override
  void updateSolder(SolderModel solder) {
    int index=solders.indexOf(solders.firstWhere((e)=>e.idNumber==solder.idNumber));
    solders[index]=solder;
   }
}
