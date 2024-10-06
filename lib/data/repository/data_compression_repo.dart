import 'package:solder_history/data/entity/data_compression.dart';
import 'package:solder_history/data/model/data_compression_model.dart';
import 'package:solder_history/data/model/solder_model.dart';

abstract class DataCompressionRepo {
  void addData(SolderModel data);

  void deleteData();

  void updateData(SolderModel solder);
  DataCompressionModel getData();
  void addSerial(SolderModel solder);

}
