import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:solder_history/data/firebase/in_firebase_data.dart';
import 'package:solder_history/data/local/in_hive_data.dart';
import 'package:solder_history/data/manager/data_compression_manager.dart';
import 'package:solder_history/data/manager/firebase_comp_manager.dart';
import 'package:solder_history/data/model/data_compression_model.dart';
import 'package:solder_history/data/model/solder_model.dart';

part 'data_compression_state.dart';

class DataCompressionCubit extends Cubit<DataCompressionState> {
  DataCompressionCubit() : super(DataCompressionInitial());
  final dataRepo = InHiveData();
  final firebaseRepo = InFirebaseData();

  DataCompressionManager dataManager() => DataCompressionManager(dataRepo);

  FirebaseCompManager firebaseManager() => FirebaseCompManager(firebaseRepo);
  TextEditingController searchController = TextEditingController();
  DataCompressionModel dataList=DataCompressionModel();
  void getDataComp() {
    emit(GetDataCompressionLoading());
    try {
      // dataManager().deleteData();
       dataList= dataManager().getData();

      emit(GetDataCompressionSuccess(dataList));
    } catch (e) {
      emit(GetDataCompressionFailed(e.toString()));
      throw e.toString();
    }
  }

  DataCompressionModel solderData=DataCompressionModel();
  void fetchSolder(DataCompressionModel data) {
    emit(FetchDataCompressionLoading());
    try {
      solderData=data;
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
      print(e.toString());
    }
  }

  updateData() {
    emit(UpdateDataCompressionLoading());
    try {
      firebaseManager().updateData();
      emit(UpdateDataCompressionSuccess());
    } on Exception catch (e) {
      emit(UpdateDataCompressionFailed());
    }
  }

  refreshData(){
    emit(RefreshDataCompressionLoading());
    try{
      firebaseManager().refreshData();
      emit(RefreshDataCompressionSuccess());
    }catch(e){
      emit(RefreshDataCompressionFailed());
    }
  }

  deleteSolder(SolderModel solder) {
    emit(DeleteSolderLoading());
    try {
      firebaseManager().deleteSolder(solder);
      emit(DeleteSolderSuccess());
    } on Exception catch (e) {
      emit(DeleteSolderFailed());
    }
  }

  getSearch() {
    emit(SearchDataCompression());
  }

  void deviceAccess(){

  }
}
