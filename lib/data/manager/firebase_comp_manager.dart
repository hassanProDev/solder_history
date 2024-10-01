import 'package:solder_history/data/model/solder_model.dart';
import 'package:solder_history/data/repository/firebase_comp_repo.dart';

class FirebaseCompManager{
  FirebaseCompRepo repo;
  FirebaseCompManager(this.repo);

  void updateData(){
    repo.updateData();
  }

  void deleteSolder(SolderModel solder,bool isConnected){
    repo.deleteData(solder,isConnected);
  }
  void refreshData(){
    repo.refreshData();
  }
}