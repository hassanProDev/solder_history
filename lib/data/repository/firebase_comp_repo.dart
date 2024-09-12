import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:solder_history/data/model/data_compression_model.dart';
import 'package:solder_history/data/model/solder_model.dart';

abstract class FirebaseCompRepo{
  void addData(DataCompressionModel data);

  void deleteData(SolderModel solder);

  void updateData();

  Stream<DocumentSnapshot<DataCompressionModel>> getData();
  void refreshData();

}