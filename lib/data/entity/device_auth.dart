import 'package:solder_history/data/entity/device_access.dart';

class DeviceAuth{
  String id;
  bool change;
  List<DeviceAccess> listDeviceAccess;

  DeviceAuth({required this.id,required this.change, required this.listDeviceAccess});
}