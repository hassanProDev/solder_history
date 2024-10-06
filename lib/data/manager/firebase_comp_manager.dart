import 'package:solder_history/data/model/solder_model.dart';
import 'package:solder_history/data/repository/firebase_comp_repo.dart';

class FirebaseCompManager{
  FirebaseCompRepo repo;
  FirebaseCompManager(this.repo);

  void uploadData(){
    repo.uploadData();
  }

  void deleteSolder(SolderModel solder,bool isConnected){
    repo.deleteData(solder,isConnected);
  }
  void refreshData(){
    repo.refreshData();
  }

}