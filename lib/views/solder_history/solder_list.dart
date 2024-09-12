import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:solder_history/core/hive_helper.dart';
import 'package:solder_history/core/widget/global_text_field.dart';
import 'package:solder_history/cubit/data_compression_cubit.dart';
import 'package:solder_history/data/local/in_hive_data.dart';
import 'package:solder_history/data/model/data_compression_model.dart';
import 'package:solder_history/data/model/solder_model.dart';
import 'package:solder_history/views/solder_history/add_solder.dart';
import 'package:solder_history/views/solder_history/solder_screen.dart';
import 'package:solder_history/views/solder_history/widgets/solder_item.dart';

class SolderList extends StatelessWidget {
  final repo = InHiveData();
  static const String id = "solderList";

  @override
  Widget build(BuildContext context) {
    final myCubit = BlocProvider.of<DataCompressionCubit>(context);

    return BlocBuilder<DataCompressionCubit, DataCompressionState>(
      // listener: (context, state) {
      //   // if(state is UpdateDataCompressionSuccess){
      //   //   myCubit.getSearch();
      //   // }
      // },
      builder: (context, state) {
        myCubit.getDataComp();
        List<SolderModel>? listOfSolder =
            (myCubit.dataList.listOfSolders ?? [])
                .where((e) =>
                    e.name.contains(myCubit.searchController.text) ||
                    e.militaryId.contains(myCubit.searchController.text) ||
                    e.center.contains(myCubit.searchController.text) ||
                    e.idNumber.contains(myCubit.searchController.text))
                .toList();
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blueAccent,
            leading: InkWell(
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
            title: const Text("سجلات المجندين"),
            centerTitle: true,
            actions: [
              getMainNull() != null
                  ? state is UpdateDataCompressionLoading
                      ? SizedBox()
                      : InkWell(
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.upload,
                              color: Colors.white,
                            ),
                          ),
                          onTap: () {
                            myCubit.updateData();
                          },
                        )
                  : const SizedBox(),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(18.0),
            child: (state is UpdateDataCompressionLoading) ||
                    (state is DeleteSolderLoading)
                ? CircularProgressIndicator()
                : Column(
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
                            "ابحث من خلال - (الاسم-رقم الشرطة-المركز-الرقم القومي)",
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
                                    onDelete: (_) {
                                      DataCompressionModel data =
                                      DataCompressionModel(listOfSolders: [
                                        listOfSolder[index]
                                      ]);
                                      myCubit.deleteSolder(data.listOfSolders![index]);
                                    },
                                    onTap: () {
                                      DataCompressionModel data =
                                          DataCompressionModel(listOfSolders: [
                                        listOfSolder[index]
                                      ]);
                                      BlocProvider.of<DataCompressionCubit>(
                                              context)
                                          .fetchSolder(data);
                                      Navigator.pushNamed(context, SolderScreen.id,);
                                    },
                                    address: listOfSolder[index].address,
                                    name: listOfSolder[index].name,
                                    militaryId: listOfSolder[index].militaryId,
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
        );
      },
    );
  }
}
