import 'package:solder_history/data/entity/solder.dart';
import 'package:solder_history/data/model/solder_model.dart';
import 'package:solder_history/data/repository/solder_repo.dart';

class SolderManager{
  SolderRepo repo;
  SolderManager(this.repo);

  void addSolder(SolderModel solder){
    repo.addSolder(solder);
  }
  void deleteSolder(String militaryId){
    repo.deleteSolder(militaryId);
  }
  void updateSolder(SolderModel solder){
    repo.updateSolder(solder);
  }
  Solder getSolder(String info){
    return repo.getSolder(info);
  }
  List<SolderModel> getAllSolder(){
    return repo.getAllSolder();
  }

}