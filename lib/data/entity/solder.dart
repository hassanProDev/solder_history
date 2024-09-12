import 'package:solder_history/data/model/military_violation_model.dart';

class Solder {
  static int id=0;
  late String? sId;
  String name;
  String forces;
  String militaryId;
  String center;
  String governorate;
  String address;
  String idNumber;
  String weapon;
  String tripleNumber;
  String educationalLevel;
  String recruitmentArea;
  DateTime enlistmentDate;
  DateTime dateOfBirth;
  DateTime serviceEndDate;
  String? bloodType;
  String? medicalLevel;
  String? religion;
  String? phoneNumber;
  String? service;
  String? serviceDuration;
  DateTime? lostDuration;
  DateTime? netServiceDuration;
  List<MilitaryViolationModel>? listMilitaryViolation;

  Solder({
    this.sId,
    required this.name,
    required this.forces,
    required this.militaryId,
    required this.enlistmentDate,
    required this.center,
    required this.governorate,
    required this.address,
    required this.idNumber,
    required this.weapon,
    required this.tripleNumber,
    required this.dateOfBirth,
    required this.educationalLevel,
    required this.recruitmentArea,
    required this.serviceEndDate,
    this.medicalLevel,
    this.religion,
    this.phoneNumber,
    this.bloodType,
    this.service,
    this.serviceDuration,
    this.lostDuration,
    this.netServiceDuration,
    this.listMilitaryViolation,
  }){
   id++;
   sId=id.toString();
  }

  @override
  String toString() {
    return "Solder(solder id: $sId , name: $name, militaryId: $militaryId, enlistmentDate: $enlistmentDate, center: $center, governorate: $governorate, address: $address, idNumber: $idNumber, weapon: $weapon, tripleNumber: $tripleNumber, dateOfBirth: $dateOfBirth, educationalLevel: $educationalLevel, recruitmentArea: $recruitmentArea, serviceEndDate: $serviceEndDate,listMilitaryViolation:$listMilitaryViolation, forces: $forces)";
  }
}

// class DataCompressionModel{
//   String? id;
//   List<SolderModel>? listOfSolders;
//
//   DataCompressionModel({this.id, this.listOfSolders});
//   DataCompressionModel.fromJson(Map<String, dynamic> json)
//       : this(
//     id: json[KeyManager.id],
//     listOfSolders: List<SolderModel>.from(jsonDecode(KeyManager.listOfSolders)
//         .map((e) => SolderModel.fromJson(e))).toList(),
//   );
//   Map<String,dynamic> toJson(){
//     return {
//       KeyManager.id:id,
//       KeyManager.listOfSolders:jsonEncode(List<SolderModel>.from(listOfSolders??[]).map((e)=>e.toJson())),
//     };
//   }
//   @override
//   String toString() {
//     // TODO: implement toString
//     return "DataCompression(id: $id,listOfSolders: $listOfSolders)";
//   }
// }
// class SolderModel {
//   String? id;
//   String name;
//   String militaryId;
//   String center;
//   String governorate;
//   String address;
//   String idNumber;
//   String weapon;
//   String tripleNumber;
//   String educationalLevel;
//   String recruitmentArea;
//   DateTime enlistmentDate;
//   DateTime dateOfBirth;
//   DateTime serviceEndDate;
//   String? bloodType;
//   String? medicalLevel;
//   String? religion;
//   String? phoneNumber;
//   String? service;
//   String? serviceDuration;
//   String? lostDuration;
//   String? netServiceDuration;
//   List<MilitaryViolationModel>? listMilitaryViolation;
//
//   SolderModel({
//     this.id,
//     required this.name,
//     required this.militaryId,
//     required this.enlistmentDate,
//     required this.center,
//     required this.governorate,
//     required this.address,
//     required this.idNumber,
//     required this.weapon,
//     required this.tripleNumber,
//     required this.dateOfBirth,
//     required this.educationalLevel,
//     required this.recruitmentArea,
//     required this.serviceEndDate,
//     this.medicalLevel,
//     this.religion,
//     this.phoneNumber,
//     this.bloodType,
//     this.service,
//     this.serviceDuration,
//     this.lostDuration,
//     this.netServiceDuration,
//     this.listMilitaryViolation,
//   });
//   SolderModel.fromJson(Map<String, dynamic> json)
//       : this(
//     id: json[KeyManager.id],
//     name: json[KeyManager.name],
//     militaryId: json[KeyManager.militaryId],
//     enlistmentDate: json[KeyManager.enlistmentDate],
//     center: json[KeyManager.center],
//     governorate: json[KeyManager.governorate],
//     address: json[KeyManager.address],
//     idNumber: json[KeyManager.idNumber],
//     weapon: json[KeyManager.weapon],
//     tripleNumber: json[KeyManager.tripleNumber],
//     dateOfBirth: json[KeyManager.dateOfBirth],
//     educationalLevel: json[KeyManager.educationalLevel],
//     recruitmentArea: json[KeyManager.recruitmentArea],
//     serviceEndDate: json[KeyManager.serviceEndDate],
//     bloodType: json[KeyManager.bloodType],
//     lostDuration: json[KeyManager.lostDuration],
//     medicalLevel: json[KeyManager.medicalLevel],
//     netServiceDuration: json[KeyManager.netServiceDuration],
//     phoneNumber: json[KeyManager.phoneNumber],
//     religion: json[KeyManager.religion],
//     service: json[KeyManager.service],
//     serviceDuration: json[KeyManager.serviceDuration],
//     listMilitaryViolation: List<MilitaryViolationModel>.from(
//         jsonDecode(json[KeyManager.listMilitaryViolation])
//             .map((e) => MilitaryViolationModel.fromJson(e))).toList(),
//   );
//
//   Map<String, dynamic> toJson() {
//     return {
//       KeyManager.id: id,
//       KeyManager.name: name,
//       KeyManager.militaryId: militaryId,
//       KeyManager.enlistmentDate: enlistmentDate,
//       KeyManager.center: center,
//       KeyManager.governorate: governorate,
//       KeyManager.address: address,
//       KeyManager.idNumber: idNumber,
//       KeyManager.weapon: weapon,
//       KeyManager.tripleNumber: tripleNumber,
//       KeyManager.dateOfBirth: dateOfBirth,
//       KeyManager.educationalLevel: educationalLevel,
//       KeyManager.recruitmentArea: recruitmentArea,
//       KeyManager.serviceEndDate: serviceEndDate,
//       KeyManager.bloodType: bloodType,
//       KeyManager.lostDuration: lostDuration,
//       KeyManager.medicalLevel: medicalLevel,
//       KeyManager.netServiceDuration: netServiceDuration,
//       KeyManager.phoneNumber: phoneNumber,
//       KeyManager.religion: religion,
//       KeyManager.service: service,
//       KeyManager.serviceDuration: serviceDuration,
//       KeyManager.listMilitaryViolation: jsonEncode(
//           List<MilitaryViolationModel>.from(listMilitaryViolation ?? [])
//               .map((e) => e.toJson())
//               .toList()),
//     };
//   }
//   @override
//   String toString() {
//     return "Solder(name: $name, militaryId: $militaryId, enlistmentDate: $enlistmentDate, center: $center, governorate: $governorate, address: $address, idNumber: $idNumber, weapon: $weapon, tripleNumber: $tripleNumber, dateOfBirth: $dateOfBirth, educationalLevel: $educationalLevel, recruitmentArea: $recruitmentArea, serviceEndDate: $serviceEndDate,listMilitaryViolation:$listMilitaryViolation)";
//   }
// }
//
// class MilitaryViolationModel {
//   String? id;
//   DateTime dateOfTheCrime;
//   String description;
//   String imposedPunishment;
//   String orderForThePunishment;
//
//   MilitaryViolationModel({
//     this.id,
//     required this.dateOfTheCrime,
//     required this.description,
//     required this.imposedPunishment,
//     required this.orderForThePunishment,
//   });
//   MilitaryViolationModel.fromJson(Map<String, dynamic> json)
//       : this(
//     id: json[KeyManager.id],
//     dateOfTheCrime: json[KeyManager.dateOfTheCrime],
//     description: json[KeyManager.description],
//     imposedPunishment: json[KeyManager.imposedPunishment],
//     orderForThePunishment: json[KeyManager.orderForThePunishment],
//   );
//
//   Map<String, dynamic> toJson() {
//     return {KeyManager.id:id,
//       KeyManager.dateOfTheCrime: dateOfTheCrime,
//       KeyManager.description: description,
//       KeyManager.imposedPunishment: imposedPunishment,
//       KeyManager.orderForThePunishment: orderForThePunishment,
//     };
//   }
//   @override
//   String toString() {
//     return "MilitaryViolation(id:$id,dateOfTheCrime: $dateOfTheCrime, description: $description, imposedPunishment: $imposedPunishment, orderForThePunishment: $orderForThePunishment)";
//   }
// }
