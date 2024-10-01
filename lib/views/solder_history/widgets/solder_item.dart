import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:solder_history/cubit/data_compression_cubit.dart';
import 'package:solder_history/data/model/solder_model.dart';

class SolderItem extends StatelessWidget {
  SolderModel solderModel;
  void Function()? onTap;

  SolderItem({
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
          SlidableAction(
            backgroundColor: Colors.blueAccent,
            onPressed: (context) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    scrollable: false,
                    title: Text(
                      'قيد التسليم',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.blueAccent),
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
                      isConnected
                          ? TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.blueAccent),
                              child: Text(
                                'اضف مسلسل',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                // BlocProvider.of<DataCompressionCubit>(context)
                                //     .fetchSolder(solderModel);
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1940),
                                  lastDate: DateTime.now().add(
                                    const Duration(days: 3 * 365),
                                  ),
                                ).then((value) {
                                  if (value == null) return;
                                  Navigator.pop(context); // Close the dialog

                                  // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                });
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
                          child:const Text(
                            'حذف',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            BlocProvider.of<DataCompressionCubit>(context)
                                .deleteSolder(solderModel);
                            Navigator.pop(context); // Close the dialog
                            if ((BlocProvider.of<DataCompressionCubit>(context)
                                        .dataList
                                        .listOfSolders ??
                                    [])
                                .contains(solderModel)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                               const SnackBar(
                                  content: Text("لا يوجد اتصال بالانترنت"),
                                ),
                              );
                            }
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
