import 'package:solder_history/data/entity/solder.dart';
import 'package:solder_history/data/model/solder_model.dart';

abstract class SolderRepo{
  void addSolder(SolderModel solder);
  void deleteSolder(String militaryId);
  void updateSolder(SolderModel solder);
  Solder getSolder(String info);
  List<SolderModel> getAllSolder();
}