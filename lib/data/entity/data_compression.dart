import 'package:solder_history/data/entity/solder.dart';
import 'package:solder_history/data/model/solder_model.dart';

class DataCompression{
  String? id;
  List<SolderModel>? listOfSolders;

  DataCompression({this.id, this.listOfSolders});
  @override
  String toString() {
    // TODO: implement toString
    return "DataCompression(id: $id,listOfSolders: $listOfSolders)";
  }
}