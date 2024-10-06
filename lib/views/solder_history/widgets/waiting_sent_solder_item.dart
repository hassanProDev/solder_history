
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:solder_history/core/hive_helper.dart';
import 'package:solder_history/core/widget/global_text_field.dart';
import 'package:solder_history/cubit/data_compression_cubit.dart';
import 'package:solder_history/data/model/data_compression_model.dart';
import 'package:solder_history/data/model/solder_model.dart';
import 'package:solder_history/views/solder_history/update_solder.dart';

class WaitingSentSolderItem extends StatelessWidget {
  SolderModel solderModel;
  void Function()? onTap;

  WaitingSentSolderItem({
    super.key,
    required this.solderModel,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    bool isConnected =
        BlocProvider.of<DataCompressionCubit>(context).isConnected;
    return Card(
      elevation: 5,
      child: Slidable(
        endActionPane: ActionPane(motion: const ScrollMotion(), children: [
          SlidableAction(backgroundColor: Colors.greenAccent,
            onPressed: (context){
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  BlocProvider.of<DataCompressionCubit>(context).fetchSolder(solderModel);


                  return AlertDialog(
                    scrollable: false,
                    title: Text(
                      'تعديل البيانات',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                      Text(solderModel.name),
                      Text(solderModel.militaryId),
                    ],),
                    actions: <Widget>[
                      TextButton(
                        child: Text('اغلق'),
                        onPressed: () {
                          Navigator.pop(context); // Close the dialog
                        },
                      ),
                      isConnected
                          ? TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.blueAccent),
                        child: Text(
                          'تعديل',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, UpdateSolder.id);
                        },
                      )
                          : Text("لا يوجد انترنت"),
                    ],
                  );
                },
              );
          },label: "تعديل البيانات",),
          SlidableAction(
            backgroundColor: Colors.blueAccent,
            onPressed: (context) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  final myCubit =
                  BlocProvider.of<DataCompressionCubit>(context);
                  // print(solderModel);

                  return AlertDialog(
                    scrollable: false,
                    title: Text(
                      'قيد التسليم',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                    content: Form(
                      key: myCubit.sentSolder.formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(solderModel.name),
                          Text(solderModel.militaryId),
                          SizedBox(
                            height: 12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .45,
                                child: Column(
                                  children: [
                                    GlobalTextFormField(
                                      keyboardType: TextInputType.text,
                                      controller: myCubit.sentSolder.sentDate,
                                      textInputAction: TextInputAction.next,
                                      text: "تاريخ التسليم",
                                      enabled: false,
                                      // isPassword: true,
                                      // iconData: Icons.calendar_month,
                                    ),
                                    FilledButton(
                                      onPressed: () {
                                        showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1940),
                                          lastDate: DateTime.now().add(
                                            const Duration(days: 30),
                                          ),
                                        ).then((value) {
                                          if (value == null) return;
                                          myCubit.sentSolder.sentDate.text =
                                              value.toString();
                                          // groupFirebase.startDateText.text =
                                          // "${value.day} - ${value.month} - ${value.year}";
                                        });
                                      },
                                      child: Icon(Icons.calendar_month),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: Text('اغلق'),
                        onPressed: () {
                          Navigator.pop(context); // Close the dialog
                        },
                      ),
                      isConnected
                          ? TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.blueAccent),
                        child: Text(
                          'تسليم',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          if (myCubit.sentSolder.formKey.currentState!
                              .validate()) {
                            BlocProvider.of<DataCompressionCubit>(context)
                                .addSentSolder(solderModel);
                            Navigator.pop(context);
                          }

                          // showDatePicker(
                          //   context: context,
                          //   initialDate: DateTime.now(),
                          //   firstDate: DateTime(1940),
                          //   lastDate: DateTime.now().add(
                          //     const Duration(days: 3 * 365),
                          //   ),
                          // ).then((value) {
                          //   if (value == null) return;
                          //   Navigator.pop(context); // Close the dialog
                          //
                          //   // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          // });
                        },
                      )
                          : Text("لا يوجد انترنت"),
                    ],
                  );
                },
              );
            },
            label: "تسليم السجل",
          )
        ]),
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      scrollable: false,
                      title: Text(
                        'حذف',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.red),
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(solderModel.name),
                          Text(solderModel.militaryId),
                        ],
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text('اغلق'),
                          onPressed: () {
                            Navigator.pop(context); // Close the dialog
                          },
                        ),
                        TextButton(
                          style:
                          TextButton.styleFrom(backgroundColor: Colors.red),
                          child: const Text(
                            'حذف',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            // print("data");
                            // print(DataCompressionModel.fromJson(getDataHive())
                            //     .listOfSolders);
                            // print("sent data");
                            // print(DataCompressionModel.fromJson(getSentHive())
                            //     .listOfSolders);
                            // print("main data");
                            // print(DataCompressionModel.fromJson(getMainHive())
                            //     .listOfSolders);
                            BlocProvider.of<DataCompressionCubit>(context)
                                .deleteSolder(solderModel);
                            Navigator.pop(context); // Close the dialog
                            // if ((BlocProvider.of<DataCompressionCubit>(context)
                            //             .dataList
                            //             .listOfSolders ??
                            //         [])
                            //     .contains(solderModel)) {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //     const SnackBar(
                            //       content: Text("لا يوجد اتصال بالانترنت"),
                            //     ),
                            //   );
                            // }
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'حذف',
            )
          ],
        ),
        child: ListTile(
          onTap: onTap,
          title: Text(solderModel.name),
          subtitle: Text(solderModel.address),
          trailing: Text(solderModel.militaryId),
        ),
      ),
    );
  }

}
