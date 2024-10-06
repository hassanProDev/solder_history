import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solder_history/core/hive_helper.dart';
import 'package:solder_history/core/widget/global_text_field.dart';
import 'package:solder_history/cubit/data_compression_cubit.dart';
import 'package:solder_history/data/local/in_hive_data.dart';
import 'package:solder_history/data/model/data_compression_model.dart';
import 'package:solder_history/data/model/solder_model.dart';
import 'package:solder_history/views/calc_military_service/date_calc_page.dart';
import 'package:solder_history/views/solder_history/add_solder.dart';
import 'package:solder_history/views/solder_history/history_details.dart';
import 'package:solder_history/views/solder_history/history_details_list.dart';
import 'package:solder_history/views/solder_history/sent_history.dart';
import 'package:solder_history/views/solder_history/solder_screen.dart';
import 'package:solder_history/views/solder_history/waiting_sent_history.dart';
import 'package:solder_history/views/solder_history/widgets/solder_item.dart';

class SolderList extends StatelessWidget {
  final repo = InHiveData();
  static const String id = "solderList";

  @override
  Widget build(BuildContext context) {
    final myCubit = BlocProvider.of<DataCompressionCubit>(context);

    return BlocBuilder<DataCompressionCubit, DataCompressionState>(
      builder: (context, state) {
        myCubit.getDataComp();
        // print(myCubit.isConnected);
        myCubit.checkInternetConnection();
        // myCubit.updateDevice();
        List<SolderModel>? listOfSolder = (myCubit.dataList.listOfSolders ?? [])
            .where((e) =>
                (e.name.contains(myCubit.searchController.text) ||
                    e.militaryId.contains(myCubit.searchController.text) ||
                    e.center.contains(myCubit.searchController.text) ||
                    e.address.contains(myCubit.searchController.text) ||
                    e.idNumber.contains(myCubit.searchController.text))&&!e.isSent)
            .toList();
        myCubit.deviceAccess();
        return myCubit.access
            // true
            ? Scaffold(
                drawer: Drawer(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent),
                        onPressed: () {
                          myCubit.fetchSolders(DataCompressionModel(
                              listOfSolders: (listOfSolder
                                  .where((e) => e.isSent == false)
                                  .toList())));
                          Navigator.pop(context);

                          Navigator.pushNamed(context, HistoryDetails.id);

                        },
                        child: Text(
                          "جرد السجلات",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent),
                        onPressed: () {                          Navigator.pop(context);

                        Navigator.pushNamed(context, SentHistory.id);
                        },
                        child: Text(
                          "سجلات تم تسليمها",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent),
                        onPressed: () {
                          Navigator.pop(context);

                          Navigator.pushNamed(context, WaitingSentHistory.id);

                        },
                        child:const Text(
                          "سجلات تحت التسليم",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent),
                        onPressed: () {
                          Navigator.pop(context);

                        Navigator.pushNamed(context, DateCalcPage.id);

                        },
                        child:const Text(
                          "حساب مسير الخدمة",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                appBar: AppBar(
                  iconTheme:const IconThemeData(color: Colors.white),
                  backgroundColor: Colors.blueAccent,
                  title: const Text(
                    "سجلات المجندين",
                    style: TextStyle(color: Colors.white),
                  ),
                  centerTitle: true,
                  actions: myCubit.isConnected
                      ? [
                          InkWell(
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.refresh,
                                color: Colors.white,
                              ),
                            ),
                            onTap: () {
                              myCubit.refreshData();
                            },
                          ),
                          (DataCompressionModel.fromJson(getMainHive())
                                          .listOfSolders ??
                                      [])
                                  .isNotEmpty||(DataCompressionModel.fromJson(getSentHive())
                                          .listOfSolders ??
                                      [])
                                  .isNotEmpty||(DataCompressionModel.fromJson(getUpdateDataHive())
                                          .listOfSolders ??
                                      [])
                                  .isNotEmpty
                              ? state is UpdateDataCompressionLoading
                                  ? const SizedBox()
                                  : InkWell(
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.upload,
                                          color: Colors.white,
                                        ),
                                      ),
                                      onTap: () {
                                        myCubit.uploadData();
                                      },
                                    )
                              : const SizedBox(),
                        ]
                      : [],
                ),
                body: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: (state is UpdateDataCompressionLoading) ||
                          (state is DeleteSolderLoading)
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(
                              height: 12,
                            ),
                            GlobalTextFormField(
                              onChange: (v) {
                                myCubit.getSearch();
                              },
                              controller: myCubit.searchController,
                              text:
                                  "ابحث (الاسم-رقم الشرطة-المركز-الرقم القومي-عنوان)",
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Expanded(
                              child: listOfSolder.isNotEmpty
                                  ? ListView.builder(
                                      itemCount: listOfSolder.length,
                                      itemBuilder: (context, index) {
                                        return SolderItem(
                                          onTap: () {
                                            SolderModel data =
                                                listOfSolder[index];
                                            BlocProvider.of<
                                                        DataCompressionCubit>(
                                                    context)
                                                .fetchSolder(data);
                                            Navigator.pushNamed(
                                              context,
                                              SolderScreen.id,
                                            );
                                          },
                                          solderModel: listOfSolder[index],
                                        );
                                      })
                                  : const SizedBox(),
                            ),
                          ],
                        ),
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AddSolder.id);
                  },
                  child: Icon(
                    Icons.add,
                    color: Colors.blueAccent,
                  ),
                ),
              )
            : Scaffold(
                body: Center(
                  child: Text("your device didn't has access"),
                ),
              );
      },
    );
  }
}
