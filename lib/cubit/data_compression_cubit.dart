import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:solder_history/core/hive_helper.dart';
import 'package:solder_history/core/key_manager/key_manager.dart';
import 'package:solder_history/data/firebase/in_firebase_access.dart';
import 'package:solder_history/data/firebase/in_firebase_data.dart';
import 'package:solder_history/data/local/in_hive_data.dart';
import 'package:solder_history/data/manager/data_compression_manager.dart';
import 'package:solder_history/data/manager/firebase_comp_manager.dart';
import 'package:solder_history/data/model/data_compression_model.dart';
import 'package:solder_history/data/model/device_access_model.dart';
import 'package:solder_history/data/model/device_auth_model.dart';
import 'package:solder_history/data/model/solder_model.dart';
import 'package:solder_history/data/solder_details.dart';
import 'package:solder_history/views/calc_military_service/calc_details.dart';
import 'package:solder_history/views/calc_military_service/date_calc_model.dart';

import '../helper/helper_method.dart';
import 'package:http/http.dart' as http;

part 'data_compression_state.dart';

class DataCompressionCubit extends Cubit<DataCompressionState> {
  DataCompressionCubit() : super(DataCompressionInitial());
  final dataRepo = InHiveData();
  final firebaseRepo = InFirebaseData();

  DataCompressionManager dataManager() => DataCompressionManager(dataRepo);

  FirebaseCompManager firebaseManager() => FirebaseCompManager(firebaseRepo);
  TextEditingController searchController = TextEditingController();
  DataCompressionModel dataList = DataCompressionModel();

  void getDataComp() {
    emit(GetDataCompressionLoading());
    // try {
    // dataManager().deleteData();
    dataList = dataManager().getData();

    emit(GetDataCompressionSuccess(dataList));
    // } catch (e) {
    //   emit(GetDataCompressionFailed(e.toString()));
    //   throw e.toString();
    // }
  }

  DataCompressionModel soldersData = DataCompressionModel();

  void fetchSolders(DataCompressionModel data) {
    emit(FetchDataCompressionLoading());
    try {
      soldersData = data;
      emit(FetchDataCompressionSuccess());
    } catch (e) {
      emit(FetchDataCompressionFailed());
    }
  }

  DataCompressionModel specialSoldersData = DataCompressionModel();

  void fetchSpecialSolders(DataCompressionModel data) {
    emit(FetchDataCompressionLoading());
    try {
      specialSoldersData = data;
      emit(FetchDataCompressionSuccess());
    } catch (e) {
      emit(FetchDataCompressionFailed());
    }
  }

  Extra solderData = Extra();

  void fetchSolder(SolderModel data) {
    emit(FetchDataCompressionLoading());
    try {
      solderData = data;
      emit(FetchDataCompressionSuccess());
    } catch (e) {
      emit(FetchDataCompressionFailed());
    }
  }

  addData(SolderModel data) {
    emit(AddDataCompressionLoading());
    try {
      dataManager().addData(data);
      emit(AddDataCompressionSuccess());
    } catch (e) {
      emit(AddDataCompressionFailed());
      // print(e.toString());
    }
  }

  uploadData() {
    emit(UpdateDataCompressionLoading());
    try {
      firebaseManager().uploadData();
      emit(UpdateDataCompressionSuccess());
    } on Exception catch (e) {
      emit(UpdateDataCompressionFailed());
    }
  }

  refreshData() {
    emit(RefreshDataCompressionLoading());
    try {
      firebaseManager().refreshData();
      emit(RefreshDataCompressionSuccess());
    } catch (e) {
      emit(RefreshDataCompressionFailed());
    }
  }

  deleteSolder(SolderModel solder) {
    emit(DeleteSolderLoading());
    try {
      firebaseManager().deleteSolder(solder, isConnected);
      emit(DeleteSolderSuccess());
    } on Exception catch (e) {
      emit(DeleteSolderFailed());
    }
  }

  getSearch() {
    emit(SearchDataCompression());
  }

  bool access = false;
  bool control = false;

  void deviceAccess() {
    DeviceAccessModel deviceAuthModel =
        DeviceAccessModel.fromJson(getAuthDevice());
    access = deviceAuthModel.access;
    control = deviceAuthModel.control;
    emit(GetAccess());
  }

  sendHistory() {}

  updateDevice() {
    if (isConnected) {
      InFirebaseAccess().updateDevice();
      emit(InternetConnection());
    }
  }

  bool isConnected = false;

  void checkInternetConnection() async {
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      if (response.statusCode == 200) {
        isConnected = true;
        emit(InternetConnection());
      } else {
        isConnected = false;
        emit(InternetConnection());
      }
    } catch (e) {
      isConnected = false;
      emit(InternetConnection());
    }
    // print(isConnected);
  }

  DateClcModel absenceDuration = DateClcModel();
  DateClcModel allServiceDuration = DateClcModel();
  DateClcModel goodServiceDuration = DateClcModel();

  calcDate(CalcDetails calcDetails) {
    absenceDuration = calcProcess(
        date1: calcDetails.attendance.fromControllerToInt(),
        date2: calcDetails.absence.fromControllerToInt());
    goodServiceDuration = calcProcess(
        date1: calcDetails.serviceDuration.fromControllerToInt(),
        date2: calcDetails.lossDuration.fromControllerToInt());
    allServiceDuration = calcProcess(
        date1: calcDetails.absence.fromControllerToInt(),
        date2: calcDetails.serviceStart.fromControllerToInt());
    emit(Calculate());
  }

  SolderDetails sentSolder = SolderDetails();

  addSerial(SolderModel solder) {
    try {
      emit(SentSolderLoading());
      solder.sId = sentSolder.sId.text;
      solder.phoneNumber = sentSolder.phoneNumber.text;
      solder.isSent = true;
      // print(solder);
      dataRepo.addSerial(solder);
      emit(SentSolderSuccess());
    } on Exception catch (e) {
      // print(e.toString() + " errorrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");
      emit(SentSolderFailed());
    }
    sentSolder.sId.clear();
    sentSolder.phoneNumber.clear();
  }

  addSentSolder(SolderModel solder) {
    try {
      emit(SentSolderLoading());
      if (sentSolder.sentDate.text == "") return;
      solder.sentDate = DateTime(
          DateTime.parse(sentSolder.sentDate.text).year,
          DateTime.parse(sentSolder.sentDate.text).month,
          DateTime.parse(sentSolder.sentDate.text).day);
      // print(solder);
      dataRepo.addSentSolder(solder);
      emit(SentSolderSuccess());
    } on Exception catch (e) {
      // print(e.toString() + " errorrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");
      emit(SentSolderFailed());
    }
    sentSolder.sentDate.clear();
  }

  SolderDetails updatedSolder = SolderDetails();

  updateData() {
    emit(UpdateDataCompressionLoading());
    try {
      dataRepo.updateData(updatedSolder.solderModel());
      emit(UpdateDataCompressionSuccess());
    } on Exception catch (e) {
      emit(UpdateDataCompressionFailed());
    }
  }
  getDataForUpdate(){
    SolderModel solder =solderData as SolderModel;
    updatedSolder.sId.text= solder.sId;
    updatedSolder.name.text= solder.name;
    updatedSolder.sentDate.text= solder.sentDate.toString();
    updatedSolder.isSent.text= solder.isSent.toString();
    updatedSolder.phoneNumber.text= solder.phoneNumber??"";
    updatedSolder.militaryId.text= solder.militaryId;
    updatedSolder.serviceDuration.text= solder.serviceDuration.toString();
    updatedSolder.address.text= solder.address;
    updatedSolder.enlistmentDate.text= solder.enlistmentDate.toString();
    updatedSolder.educationalLevel.text= solder.educationalLevel;
    updatedSolder.dateOfBirth.text= solder.dateOfBirth.toString();
    updatedSolder.governorate.text= solder.governorate;
    updatedSolder.idNumber.text= solder.idNumber;
    updatedSolder.center.text= solder.center;
    updatedSolder.serviceEndDate.text= solder.serviceEndDate.toString();
    updatedSolder.netServiceDuration.text= solder.netServiceDuration.toString();
    updatedSolder.lostDuration.text= solder.lostDuration.toString();
    updatedSolder.bloodType.text= solder.bloodType??'';
    updatedSolder.religion.text= solder.religion??'';
    updatedSolder.medicalLevel.text= solder.medicalLevel??'';
    updatedSolder.weapon.text= solder.weapon;
    updatedSolder.tripleNumber.text= solder.tripleNumber;
    updatedSolder.forces.text= solder.forces;
    updatedSolder.recruitmentArea.text= solder.recruitmentArea;
  }

  newCalc(CalcDetails calcDetails) {
    calcDetails.absence.dayController.clear();
    calcDetails.absence.monthController.clear();
    calcDetails.absence.yearController.clear();
    calcDetails.attendance.dayController.clear();
    calcDetails.attendance.monthController.clear();
    calcDetails.attendance.yearController.clear();
    calcDetails.serviceDuration.dayController.clear();
    calcDetails.serviceDuration.monthController.clear();
    calcDetails.serviceDuration.yearController.clear();
    calcDetails.serviceStart.dayController.clear();
    calcDetails.serviceStart.monthController.clear();
    calcDetails.serviceStart.yearController.clear();
    calcDetails.lossDuration.dayController.clear();
    calcDetails.lossDuration.monthController.clear();
    calcDetails.lossDuration.yearController.clear();
    calcDetails.serviceEnd.dayController.clear();
    calcDetails.serviceEnd.monthController.clear();
    calcDetails.serviceEnd.yearController.clear();
    calcDate(calcDetails);
  }
}
