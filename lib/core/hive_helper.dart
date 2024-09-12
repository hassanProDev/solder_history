import 'package:hive_flutter/adapters.dart';
import 'package:solder_history/core/key_manager/key_manager.dart';

final box = Hive.box("DataCompression");

Map defaultMap = {
  KeyManager.id: "",
  KeyManager.listOfSolders: "[]",
};

Map getMainHive() => box.get("mainData", defaultValue: defaultMap);

Map getDataHive() => box.get("data", defaultValue: defaultMap);

Map? getDataNull() => box.get("data");
Map? getMainNull() => box.get("mainData");
