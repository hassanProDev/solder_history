class DeviceAccess {
  bool access;
  bool control;
  String id;
  String devId;
  String? name;

  DeviceAccess({
    required this.access,
    required this.control,
    required this.id,
    this.name,
    required this.devId,
  });
}
