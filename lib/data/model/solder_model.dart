import 'dart:convert';

import 'package:solder_history/core/key_manager/key_manager.dart';
import 'package:solder_history/data/entity/solder.dart';
import 'package:solder_history/data/model/military_violation_model.dart';
import 'package:solder_history/helper/helper_method.dart';

class SolderModel extends Solder implements Extra {
  bool isSent;
  DateTime? sentDate;

  SolderModel({
    required super.name,
    required super.forces,
    required super.militaryId,
    required super.enlistmentDate,
    required super.center,
    required super.governorate,
    required super.address,
    required super.idNumber,
    required super.weapon,
    required super.tripleNumber,
    required super.dateOfBirth,
    required super.educationalLevel,
    required super.recruitmentArea,
    required super.serviceEndDate,
    super.bloodType,
    super.listMilitaryViolation,
    super.lostDuration,
    super.medicalLevel,
    super.netServiceDuration,
    super.phoneNumber,
    super.religion,
    super.service,
    super.serviceDuration,
    required this.isSent,
    this.sentDate,
  });

  SolderModel.fromJson(Map<String, dynamic> json)
      : this(
          name: json[KeyManager.name],
          forces: json[KeyManager.forces],
          militaryId: json[KeyManager.militaryId],
          enlistmentDate: DateTime.parse(json[KeyManager.enlistmentDate]),
          center: json[KeyManager.center],
          governorate: json[KeyManager.governorate],
          address: json[KeyManager.address],
          idNumber: json[KeyManager.idNumber],
          weapon: json[KeyManager.weapon],
          tripleNumber: json[KeyManager.tripleNumber],
          dateOfBirth: DateTime.parse(json[KeyManager.dateOfBirth]),
          educationalLevel: json[KeyManager.educationalLevel],
          recruitmentArea: json[KeyManager.recruitmentArea],
          serviceEndDate: DateTime.parse(json[KeyManager.serviceEndDate]),
          bloodType: json[KeyManager.bloodType],
          lostDuration: DateTime.parse(json[KeyManager.lostDuration]),
          medicalLevel: json[KeyManager.medicalLevel],
          netServiceDuration:
              DateTime.parse(json[KeyManager.netServiceDuration]),
          phoneNumber: json[KeyManager.phoneNumber],
          religion: json[KeyManager.religion],
          service: json[KeyManager.service],
          serviceDuration: json[KeyManager.serviceDuration],
          listMilitaryViolation: List<MilitaryViolationModel>.from(
              jsonDecode(json[KeyManager.listMilitaryViolation])
                  .map((e) => MilitaryViolationModel.fromJson(e))).toList(),
          isSent: json[KeyManager.isSent],
          sentDate: json[KeyManager.sentDate],
        );

  Map<String, dynamic> toJson() {
    return {
      KeyManager.name: name,
      KeyManager.forces: forces,
      KeyManager.militaryId: militaryId,
      KeyManager.enlistmentDate: enlistmentDate.toString(),
      KeyManager.center: center,
      KeyManager.governorate: governorate,
      KeyManager.address: address,
      KeyManager.idNumber: idNumber,
      KeyManager.weapon: weapon,
      KeyManager.tripleNumber: tripleNumber,
      KeyManager.dateOfBirth: dateOfBirth.toString(),
      KeyManager.educationalLevel: educationalLevel,
      KeyManager.recruitmentArea: recruitmentArea,
      KeyManager.serviceEndDate: serviceEndDate.toString(),
      KeyManager.bloodType: bloodType,
      KeyManager.lostDuration: lostDuration.toString(),
      KeyManager.medicalLevel: medicalLevel,
      KeyManager.netServiceDuration: netServiceDuration.toString(),
      KeyManager.phoneNumber: phoneNumber,
      KeyManager.religion: religion,
      KeyManager.service: service,
      KeyManager.serviceDuration: serviceDuration,
      KeyManager.listMilitaryViolation: jsonEncode(
          List<MilitaryViolationModel>.from(listMilitaryViolation ?? [])
              .map((e) => e.toJson())
              .toList()),
      KeyManager.sentDate: sentDate,
      KeyManager.isSent: isSent,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SolderModel &&
          runtimeType == other.runtimeType &&
          militaryId == other.militaryId &&
          name == other.name;

  @override
  int get hashCode => militaryId.hashCode;
}
