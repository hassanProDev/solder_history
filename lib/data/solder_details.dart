import 'package:flutter/material.dart';
import 'package:solder_history/data/model/solder_model.dart';

class SolderDetails {
  final formKey = GlobalKey<FormState>();
  TextEditingController sId = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController forces = TextEditingController();
  TextEditingController militaryId = TextEditingController();
  TextEditingController center = TextEditingController();
  TextEditingController governorate = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController idNumber = TextEditingController();
  TextEditingController weapon = TextEditingController();
  TextEditingController tripleNumber = TextEditingController();
  TextEditingController educationalLevel = TextEditingController();
  TextEditingController recruitmentArea = TextEditingController();
  TextEditingController enlistmentDate = TextEditingController();
  TextEditingController dateOfBirth = TextEditingController();
  TextEditingController serviceEndDate = TextEditingController();
  TextEditingController bloodType = TextEditingController();
  TextEditingController medicalLevel = TextEditingController();
  TextEditingController religion = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController service = TextEditingController();
  TextEditingController serviceDuration = TextEditingController();
  TextEditingController lostDuration = TextEditingController();
  TextEditingController netServiceDuration = TextEditingController();
  TextEditingController isSent = TextEditingController();
  TextEditingController sentDate = TextEditingController();

  SolderModel solderModel() {
    return SolderModel(
      sId: sId.text,
      name: name.text,
      forces: forces.text,
      militaryId: militaryId.text,
      enlistmentDate: enlistmentDate.text != ''
          ? DateTime(
              DateTime.parse(enlistmentDate.text).year,
              DateTime.parse(enlistmentDate.text).month,
              DateTime.parse(enlistmentDate.text).day)
          : DateTime(1999),
      center: center.text,
      governorate: governorate.text == '' ? "الفيوم" : governorate.text,
      address: address.text,
      idNumber: idNumber.text,
      weapon: weapon.text,
      tripleNumber: tripleNumber.text,
      dateOfBirth: dateOfBirth.text != ''
          ? DateTime(
              DateTime.parse(dateOfBirth.text).year,
              DateTime.parse(dateOfBirth.text).month,
              DateTime.parse(dateOfBirth.text).day)
          : DateTime(1999),
      educationalLevel: educationalLevel.text,
      recruitmentArea: recruitmentArea.text,
      serviceEndDate: serviceEndDate.text != ''
          ? DateTime(
              DateTime.parse(serviceEndDate.text).year,
              DateTime.parse(serviceEndDate.text).month,
              DateTime.parse(serviceEndDate.text).day)
          : DateTime(
                  DateTime.parse(enlistmentDate.text).year,
                  DateTime.parse(enlistmentDate.text).month,
                  DateTime.parse(enlistmentDate.text).day)
              .add(const Duration(days: 3 * 365)),
      bloodType: bloodType.text,
      lostDuration: lostDuration.text != ''
          ? DateTime(
              DateTime.parse(lostDuration.text).year,
              DateTime.parse(lostDuration.text).month,
              DateTime.parse(lostDuration.text).day)
          : DateTime(1999),
      medicalLevel: medicalLevel.text,
      netServiceDuration: netServiceDuration.text != ''
          ? DateTime(
              DateTime.parse(netServiceDuration.text).year,
              DateTime.parse(netServiceDuration.text).month,
              DateTime.parse(netServiceDuration.text).day)
          : DateTime(1999),
      phoneNumber: phoneNumber.text,
      religion: religion.text,
      service: service.text,
      serviceDuration: serviceDuration.text,
      isSent: isSent.text == "" ? false : bool.parse(isSent.text),
      sentDate: sentDate.text == "null" || sentDate.text == ""
          ? null
          : DateTime.parse(sentDate.text),
    );
  }
}
