import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solder_history/cubit/data_compression_cubit.dart';
import 'package:solder_history/data/model/data_compression_model.dart';
import 'package:solder_history/data/model/solder_model.dart';
import 'package:solder_history/helper/helper_method.dart';
import 'package:solder_history/views/solder_history/history_details_list.dart';
import 'package:solder_history/views/solder_history/widgets/history_details_widget.dart';

class HistoryDetails extends StatelessWidget {
  static const String id = "historyDetails";

  @override
  Widget build(BuildContext context) {
    List<SolderModel> allHistory =
        BlocProvider.of<DataCompressionCubit>(context)
                .soldersData
                .listOfSolders ??
            [];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "جرد سجلات اجمالي ${allHistory.length}",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              HistoryDetailsWidget(
                text:
                    "سجلات تخطت ال 36 عام :${allHistory.where((e) => calculateAge(e.dateOfBirth) >= 36).length}",
                onTap: () {
                  BlocProvider.of<DataCompressionCubit>(context).fetchSpecialSolders(
                      DataCompressionModel(
                          listOfSolders: allHistory
                              .where((e) => calculateAge(e.dateOfBirth) >= 36)
                              .toList()));
                  Navigator.pushNamed(context, HistoryDetailsList.id,
                      arguments: "تخطت ال 36 عام");
                },
              ),
              HistoryDetailsWidget(
                text:
                    "عدد السجلات عليا فوق ال36 عام : ${allHistory.where((e) => e.educationalLevel == "عليا" && calculateAge(e.dateOfBirth) >= 36).length}",
                onTap: () {
                  BlocProvider.of<DataCompressionCubit>(context).fetchSpecialSolders(
                      DataCompressionModel(
                          listOfSolders: allHistory
                              .where((e) =>
                                  e.educationalLevel == "عليا" &&
                                  calculateAge(e.dateOfBirth) >= 36)
                              .toList()));
                  Navigator.pushNamed(context, HistoryDetailsList.id,
                      arguments: "تخطت ال 36 عام عليا");
                },
              ),
              HistoryDetailsWidget(
                text:
                    "عدد سجلات فوق متوسط تخطت ال36 عام: ${allHistory.where((e) => e.educationalLevel == "فوق متوسط" && calculateAge(e.dateOfBirth) >= 36).length}",
                onTap: () {
                  BlocProvider.of<DataCompressionCubit>(context).fetchSpecialSolders(
                      DataCompressionModel(
                          listOfSolders: allHistory
                              .where((e) =>
                                  e.educationalLevel == "فوق متوسط" &&
                                  calculateAge(e.dateOfBirth) >= 36)
                              .toList()));
                  Navigator.pushNamed(context, HistoryDetailsList.id,
                      arguments: "تخطت ال 36 عام فوق متوسط");
                },
              ),
              HistoryDetailsWidget(
                text:
                    "عدد سجلات متوسط تخطت ال36 عام: ${allHistory.where((e) => e.educationalLevel == "متوسط" && calculateAge(e.dateOfBirth) >= 36).length}",
                onTap: () {
                  BlocProvider.of<DataCompressionCubit>(context).fetchSpecialSolders(
                      DataCompressionModel(
                          listOfSolders: allHistory
                              .where((e) =>
                                  e.educationalLevel == "متوسط" &&
                                  calculateAge(e.dateOfBirth) >= 36)
                              .toList()));
                  Navigator.pushNamed(context, HistoryDetailsList.id,
                      arguments: "تخطت ال 36 عام متوسط");
                },
              ),
              HistoryDetailsWidget(
                text:
                    "عدد السجلات امي تخطت ال36 عام: ${allHistory.where((e) => e.educationalLevel == "امي" && calculateAge(e.dateOfBirth) >= 36).length}",
                onTap: () {
                  BlocProvider.of<DataCompressionCubit>(context).fetchSpecialSolders(
                      DataCompressionModel(
                          listOfSolders: allHistory
                              .where((e) =>
                                  e.educationalLevel == "امي" &&
                                  calculateAge(e.dateOfBirth) >= 36)
                              .toList()));
                  Navigator.pushNamed(context, HistoryDetailsList.id,
                      arguments: "تخطت ال 36 عام امي");
                },
              ),
              HistoryDetailsWidget(
                text:
                    "سجلات تحت ال 36 عام :${allHistory.where((e) => calculateAge(e.dateOfBirth) < 36).length}",
                onTap: () {
                  BlocProvider.of<DataCompressionCubit>(context).fetchSpecialSolders(
                      DataCompressionModel(
                          listOfSolders: allHistory
                              .where((e) => calculateAge(e.dateOfBirth) < 36)
                              .toList()));
                  Navigator.pushNamed(context, HistoryDetailsList.id,
                      arguments: "تحت ال 36 عام");
                },
              ),
              HistoryDetailsWidget(
                text:
                    "عدد سجلات عليا تحت ال36 عام : ${allHistory.where((e) => e.educationalLevel == "عليا" && calculateAge(e.dateOfBirth) < 36).length}",
                onTap: () {
                  BlocProvider.of<DataCompressionCubit>(context).fetchSpecialSolders(
                      DataCompressionModel(
                          listOfSolders: allHistory
                              .where((e) =>  e.educationalLevel == "عليا" && calculateAge(e.dateOfBirth) < 36)
                              .toList()));
                  Navigator.pushNamed(context, HistoryDetailsList.id,
                      arguments: "عليا تحت ال36 عام");
                },
              ),
              HistoryDetailsWidget(
                text:
                    "عدد السجلات فوق متوسط تحت ال36 عام: ${allHistory.where((e) => e.educationalLevel == "فوق متوسط" && calculateAge(e.dateOfBirth) < 36).length}",
                onTap: () {
                  BlocProvider.of<DataCompressionCubit>(context).fetchSpecialSolders(
                      DataCompressionModel(
                          listOfSolders: allHistory
                              .where((e) => e.educationalLevel == "فوق متوسط" && calculateAge(e.dateOfBirth) < 36)
                              .toList()));
                  Navigator.pushNamed(context, HistoryDetailsList.id,
                      arguments: "فوق متوسط تحت ال36 عام");
                },
              ),
              HistoryDetailsWidget(
                text:
                    "عدد السجلات متوسط تحت ال36 عام: ${allHistory.where((e) => e.educationalLevel == "متوسط" && calculateAge(e.dateOfBirth) < 36).length}",
                onTap: () { BlocProvider.of<DataCompressionCubit>(context).fetchSpecialSolders(
                    DataCompressionModel(
                        listOfSolders: allHistory
                            .where((e) => e.educationalLevel == "متوسط" && calculateAge(e.dateOfBirth) < 36)
                            .toList()));
                Navigator.pushNamed(context, HistoryDetailsList.id,
                    arguments: "متوسط تحت ال36 عام");},
              ),
              HistoryDetailsWidget(
                text:
                    "عدد السجلات امي تحت ال36 عام: ${allHistory.where((e) => e.educationalLevel == "امي" && calculateAge(e.dateOfBirth) < 36).length}",
                onTap: () { BlocProvider.of<DataCompressionCubit>(context).fetchSpecialSolders(
                    DataCompressionModel(
                        listOfSolders: allHistory
                            .where((e) => e.educationalLevel == "امي" && calculateAge(e.dateOfBirth) < 36)
                            .toList()));
                Navigator.pushNamed(context, HistoryDetailsList.id,
                    arguments: "امي تحت ال36 عام");},
              ),
              /////////////////////////////////////////////////////////////////////////
              HistoryDetailsWidget(
                text:
                    "عدد سجلات عليا لم تسرح دفعتة : ${allHistory.where((e) => e.educationalLevel == "عليا" && e.enlistmentDate.add(Duration(days: 30*13)).isBefore(DateTime.now())).length}",
                onTap: () {
                  BlocProvider.of<DataCompressionCubit>(context).fetchSpecialSolders(
                      DataCompressionModel(
                          listOfSolders: allHistory
                              .where((e) =>  e.educationalLevel == "عليا" && e.enlistmentDate.add(Duration(days: 30*13)).isBefore(DateTime.now()))
                              .toList()));
                  Navigator.pushNamed(context, HistoryDetailsList.id,
                      arguments: "عليا لم تسرح دفعتة ");
                },
              ),
              HistoryDetailsWidget(
                text:
                    "عدد السجلات فوق متوسط لم تسرح دفعتة : ${allHistory.where((e) => e.educationalLevel == "فوق متوسط" && e.enlistmentDate.add(Duration(days: 30*19)).isBefore(DateTime.now())).length}",
                onTap: () {
                  BlocProvider.of<DataCompressionCubit>(context).fetchSpecialSolders(
                      DataCompressionModel(
                          listOfSolders: allHistory
                              .where((e) => e.educationalLevel == "فوق متوسط" && e.enlistmentDate.add(Duration(days: 30*19)).isBefore(DateTime.now()))
                              .toList()));
                  Navigator.pushNamed(context, HistoryDetailsList.id,
                      arguments: "فوق متوسط لم تسرح دفعتة ");
                },
              ),
              HistoryDetailsWidget(
                text:
                    "عدد السجلات متوسط لم تسرح دفعتة : ${allHistory.where((e) => e.educationalLevel == "متوسط" && e.enlistmentDate.add(Duration(days: 30*25)).isBefore(DateTime.now())).length}",
                onTap: () { BlocProvider.of<DataCompressionCubit>(context).fetchSpecialSolders(
                    DataCompressionModel(
                        listOfSolders: allHistory
                            .where((e) => e.educationalLevel == "متوسط" && e.enlistmentDate.add(Duration(days: 30*25)).isBefore(DateTime.now()))
                            .toList()));
                Navigator.pushNamed(context, HistoryDetailsList.id,
                    arguments: "متوسط لم تسرح دفعتة ");},
              ),
              HistoryDetailsWidget(
                text:
                    "عدد السجلات امي لم تسرح دفعتة : ${allHistory.where((e) => e.educationalLevel == "امي" && e.enlistmentDate.add(Duration(days: 30*37)).isBefore(DateTime.now())).length}",
                onTap: () { BlocProvider.of<DataCompressionCubit>(context).fetchSpecialSolders(
                    DataCompressionModel(
                        listOfSolders: allHistory
                            .where((e) => e.educationalLevel == "امي" && e.enlistmentDate.add(Duration(days: 30*37)).isBefore(DateTime.now()))
                            .toList()));
                Navigator.pushNamed(context, HistoryDetailsList.id,
                    arguments: "امي لم تسرح دفعتة ");},
              ),
              //////////////////////////////////////////////////////////////////////
              HistoryDetailsWidget(
                text:
                    "سجلات اوشكت علي وصول ال 36 عام :${allHistory.where((e) => calculateAge(e.dateOfBirth.add(Duration(days: 30))) == 36).length}",
                onTap: () {
                  BlocProvider.of<DataCompressionCubit>(context).fetchSpecialSolders(
                      DataCompressionModel(
                          listOfSolders: allHistory
                              .where((e) => calculateAge(e.dateOfBirth.add(Duration(days: 30))) == 36)
                              .toList()));
                  Navigator.pushNamed(context, HistoryDetailsList.id,
                      arguments: "اوشكت علي وصول ال 36 عام");
                },
              ),
              HistoryDetailsWidget(
                text:
                    " اجمالي السجلات عليا : ${allHistory.where((e) => e.educationalLevel == "عليا").length}",
                onTap: () {
                  BlocProvider.of<DataCompressionCubit>(context).fetchSpecialSolders(
                      DataCompressionModel(
                          listOfSolders: allHistory
                              .where((e) => e.educationalLevel == "عليا")
                              .toList()));
                  Navigator.pushNamed(context, HistoryDetailsList.id,
                      arguments: "عليا");
                },
              ),
              HistoryDetailsWidget(
                text:
                    "اجمالي السجلات فوق متوسط : ${allHistory.where((e) => e.educationalLevel == "فوق متوسط").length}",
                onTap: () {
                  BlocProvider.of<DataCompressionCubit>(context).fetchSpecialSolders(
                      DataCompressionModel(
                          listOfSolders: allHistory
                              .where((e) => e.educationalLevel == "فوق متوسط")
                              .toList()));
                  Navigator.pushNamed(context, HistoryDetailsList.id,
                      arguments: "فوق متوسط");
                },
              ),
              HistoryDetailsWidget(
                text:
                    "اجمالي السجلات متوسط : ${allHistory.where((e) => e.educationalLevel == "متوسط").length}",
                onTap: () {
                  BlocProvider.of<DataCompressionCubit>(context).fetchSpecialSolders(
                      DataCompressionModel(
                          listOfSolders: allHistory
                              .where((e) => e.educationalLevel == "متوسط")
                              .toList()));
                  Navigator.pushNamed(context, HistoryDetailsList.id,
                      arguments: "متوسط");
                },
              ),
              HistoryDetailsWidget(
                text:
                    "اجمالي السجلات امي : ${allHistory.where((e) => e.educationalLevel == "امي").length}",
                onTap: () {
                  BlocProvider.of<DataCompressionCubit>(context).fetchSpecialSolders(
                      DataCompressionModel(
                          listOfSolders: allHistory
                              .where((e) => e.educationalLevel == "امي")
                              .toList()));
                  Navigator.pushNamed(context, HistoryDetailsList.id,
                      arguments: "امي");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
