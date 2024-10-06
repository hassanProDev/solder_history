import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solder_history/core/widget/global_text_field.dart';
import 'package:solder_history/cubit/data_compression_cubit.dart';
import 'package:solder_history/data/model/solder_model.dart';
import 'package:solder_history/views/solder_history/solder_screen.dart';
import 'package:solder_history/views/solder_history/widgets/waiting_sent_solder_item.dart';
import 'package:solder_history/views/solder_history/widgets/solder_item.dart';

class WaitingSentHistory extends StatelessWidget {
  static const String id = "waitingSentHistory";

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
            e.idNumber.contains(myCubit.searchController.text))&&e.isSent&&e.sentDate=="null")
            .toList();
        myCubit.deviceAccess();
        return myCubit.access
        // true
            ? Scaffold(
          appBar: AppBar(
            iconTheme:const IconThemeData(color: Colors.white),
            backgroundColor: Colors.blueAccent,
            title: const Text(
              "سجلات المجندين",
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
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
                        return WaitingSentSolderItem(
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
