import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solder_history/core/widget/global_text_field.dart';
import 'package:solder_history/cubit/data_compression_cubit.dart';


class UpdateSolder extends StatelessWidget {
  static const String id = "updateSolder";

  @override
  Widget build(BuildContext context) {
    final myCubit=BlocProvider.of<DataCompressionCubit>(context);
    myCubit.getDataForUpdate();
    return BlocBuilder<DataCompressionCubit, DataCompressionState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "تعديل سجل",
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            backgroundColor: Colors.blueAccent,
          ),
          body: Padding(
            padding: EdgeInsets.all(8),
            child: state is AddDataCompressionLoading
                ? Center(
              child: CircularProgressIndicator(),
            )
                : ListView(
              // controller: _scrollController,
              children: [
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * .45,
                      child: GlobalTextFormField(
                        controller: myCubit.updatedSolder.recruitmentArea,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        text: "منطقة التجنيد",
                      ),
                    ),
                    SizedBox(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * .45,
                        child: GlobalTextFormField(
                          controller: myCubit.updatedSolder.forces,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          text: "القوات",
                        ))
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Form(
                  key: myCubit.updatedSolder.formKey,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width:
                            MediaQuery
                                .of(context)
                                .size
                                .width * .45,
                            child: GlobalTextFormField(
                              controller:myCubit.updatedSolder.militaryId,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              text: "الرقم العسكري",
                            ),
                          ),
                          SizedBox(
                            width:
                            MediaQuery
                                .of(context)
                                .size
                                .width * .45,
                            child: GlobalTextFormField(
                              keyboardType: TextInputType.text,
                              controller: myCubit.updatedSolder.center,
                              textInputAction: TextInputAction.next,
                              text: "القسم/المركز",
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      GlobalTextFormField(
                        controller: myCubit.updatedSolder.name,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        text: "اسم المجند",
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width:
                            MediaQuery
                                .of(context)
                                .size
                                .width * .45,
                            child: Column(
                              children: [
                                GlobalTextFormField(
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  text: "تاريخ الميلاد",
                                  controller: myCubit.updatedSolder.dateOfBirth,
                                  enabled: false,
                                ),
                                FilledButton(
                                  onPressed: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1940),
                                      lastDate: DateTime.now(),
                                    ).then((value) {
                                      if (value == null) return;
                                      myCubit.updatedSolder.dateOfBirth.text =
                                          value.toString();
                                      // groupFirebase.startDateText.text =
                                      // "${value.day} - ${value.month} - ${value.year}";
                                    });
                                  },
                                  child: Icon(Icons.calendar_month),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width:
                            MediaQuery
                                .of(context)
                                .size
                                .width * .45,
                            child: Column(
                              children: [
                                GlobalTextFormField(
                                  keyboardType: TextInputType.text,
                                  controller:
                                  myCubit.updatedSolder.enlistmentDate,
                                  textInputAction: TextInputAction.next,
                                  text: "تاريخ التجنيد",
                                  enabled: false,
                                ),
                                FilledButton(
                                  onPressed: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1940),
                                      lastDate: DateTime.now(),
                                    ).then((value) {
                                      if (value == null) return;
                                      myCubit.updatedSolder.enlistmentDate.text =
                                          value.toString();
                                      // groupFirebase.startDateText.text =
                                      // "${value.day} - ${value.month} - ${value.year}";
                                    });
                                  },
                                  child: Icon(Icons.calendar_month),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width:
                            MediaQuery
                                .of(context)
                                .size
                                .width * .45,
                            child: GlobalTextFormField(
                              keyboardType: TextInputType.text,
                              controller: myCubit.updatedSolder.educationalLevel,
                              textInputAction: TextInputAction.next,
                              text: "المستوى الثقافي",
                            ),
                          ), SizedBox(
                            width:
                            MediaQuery
                                .of(context)
                                .size
                                .width * .45,
                            child: GlobalTextFormField(
                              controller: myCubit.updatedSolder.address,
                              keyboardType: TextInputType.text,
                              text: "العنوان",
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                        ],
                      )
                      ,
                      SizedBox(
                        height: 12,
                      ),

                    ],
                  ),
                ),
                SizedBox(
                  width:
                  MediaQuery
                      .of(context)
                      .size
                      .width * .45,
                  child: GlobalTextFormField(
                    controller: myCubit.updatedSolder.idNumber,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    text: "الرقم القومي",
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * .45,
                      child: GlobalTextFormField(
                        keyboardType: TextInputType.text,
                        controller: myCubit.updatedSolder.governorate,
                        textInputAction: TextInputAction.next,
                        text: "المحافظة",
                      ),
                    ),
                    SizedBox(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * .45,
                        child: GlobalTextFormField(
                          controller: myCubit.updatedSolder.tripleNumber,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          text: "الرقم الثلاثي",
                        )),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * .45,
                      child: Column(
                        children: [
                          GlobalTextFormField(
                            keyboardType: TextInputType.text,
                            controller: myCubit.updatedSolder.serviceEndDate,
                            textInputAction: TextInputAction.next,
                            text: "تاريخ انتهاء الخدمة",
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
                                  const Duration(days: 3 * 365),
                                ),
                              ).then((value) {
                                if (value == null) return;
                                myCubit.updatedSolder.serviceEndDate.text =
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
                    SizedBox(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * .45,
                      child: GlobalTextFormField(
                        controller: myCubit.updatedSolder.phoneNumber,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        text: "الهاتف",
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * .45,
                      child: GlobalTextFormField(
                        keyboardType: TextInputType.text,
                        controller: myCubit.updatedSolder.medicalLevel,
                        textInputAction: TextInputAction.next,
                        text: "المستوى الطبي",
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * .45,
                      child: GlobalTextFormField(
                        controller: myCubit.updatedSolder.weapon,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        text: "السلاح",
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * .45,
                      child: GlobalTextFormField(
                        keyboardType: TextInputType.text,
                        controller: myCubit.updatedSolder.religion,
                        textInputAction: TextInputAction.next,
                        text: "الديانة",
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * .45,
                      child: GlobalTextFormField(
                        controller: myCubit.updatedSolder.bloodType,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.text,
                        text: "فصيلة الدم",
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * .1,
                ),
              ],
            ),
          ),
          floatingActionButtonLocation:
          FloatingActionButtonLocation.centerFloat,
          floatingActionButton: state is AddDataCompressionLoading
              ? SizedBox()
              : FilledButton(
              style: FilledButton.styleFrom(backgroundColor: Colors.indigo),
              onPressed: () {
                if (myCubit.updatedSolder.formKey.currentState!.validate()) {
                  BlocProvider.of<DataCompressionCubit>(context)
                      .updateData();
                  Navigator.pop(context);
                }
              },
              child: Text("تعديل")),
        );
      },
    );
  }

}
