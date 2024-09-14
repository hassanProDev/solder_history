import 'package:solder_history/data/entity/device_access.dart';
import 'package:solder_history/data/model/device_access_model.dart';

class DeviceAuth{
  String id;
  bool change;
  List<DeviceAccess> listDeviceAccess;
  DeviceAccessModel? thisDevice;
  DeviceAuth({required this.id,required this.change, required this.listDeviceAccess, this.thisDevice});
}