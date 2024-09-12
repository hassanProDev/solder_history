import 'dart:convert';

import 'package:solder_history/core/key_manager/key_manager.dart';
import 'package:solder_history/data/entity/data_compression.dart';
import 'package:solder_history/data/model/solder_model.dart';

class DataCompressionModel extends DataCompression {
  DataCompressionModel({super.id, super.listOfSolders});

 factory DataCompressionModel.fromJson(Map<dynamic, dynamic> json){
   // List<int> utf8Bytes = utf8.encode(json[KeyManager.listOfSolders]);
   // int sizeInBytes = utf8Bytes.length;
   // print("string size in bytes :   $sizeInBytes");
   return DataCompressionModel( id: json[KeyManager.id],
     listOfSolders: List<SolderModel>.from(jsonDecode(json[KeyManager.listOfSolders])
         .map((e) => SolderModel.fromJson(e))).toList(),);
 }

  Map<String,dynamic> toJson(){

    return {
      KeyManager.id:id,
      KeyManager.listOfSolders:jsonEncode(List<SolderModel>.from(listOfSolders??[]).map((e)=>e.toJson()).toList()),
    };
  }
}