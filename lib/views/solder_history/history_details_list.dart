import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solder_history/core/widget/global_text_field.dart';
import 'package:solder_history/cubit/data_compression_cubit.dart';
import 'package:solder_history/data/model/data_compression_model.dart';
import 'package:solder_history/data/model/solder_model.dart';
import 'package:solder_history/views/solder_history/solder_screen.dart';
import 'package:solder_history/views/solder_history/widgets/solder_item.dart';

class HistoryDetailsList extends StatelessWidget {
static const String id="historyDetailsList";
  @override
  Widget build(BuildContext context) {
    final myCubit = BlocProvider.of<DataCompressionCubit>(context);
    return BlocBuilder<DataCompressionCubit, DataCompressionState>(
      builder: (context, state) {
        // String title=ModalRoute.of(context)?.settings.arguments as String;

        myCubit.getDataComp();
        List<SolderModel> listOfSolder = (myCubit.specialSoldersData.listOfSolders??[]).where((e) =>
        e.name.contains(myCubit.searchController.text) ||
            e.militaryId.contains(myCubit.searchController.text) ||
            e.center.contains(myCubit.searchController.text) ||
            e.address.contains(myCubit.searchController.text) ||
            e.idNumber.contains(myCubit.searchController.text)).toList();
        return Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: Colors.blueAccent,
            title:  Text(
              "سجلات لمجندين ",
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,

          ),
          body: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
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
                  "ابحث من خلال - (الاسم-رقم الشرطة-المركز-الرقم القومي)",
                ),
                SizedBox(
                  height: 12,
                ),
                Expanded(
                  child:  ListView.builder(
                      itemCount: listOfSolder.length,
                      itemBuilder: (context, index) {
                        return SolderItem(
                          onTap: () {
                            SolderModel data =listOfSolder[index]
                            ;
                            BlocProvider.of<DataCompressionCubit>(
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
                ),
              ],
            ),
          ),

        );
      },
    );
  }
}
