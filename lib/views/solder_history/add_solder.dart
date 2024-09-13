import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solder_history/core/key_manager/key_manager.dart';
import 'package:solder_history/core/widget/global_text_field.dart';
import 'package:solder_history/cubit/data_compression_cubit.dart';
import 'package:solder_history/data/local/in_hive_data.dart';
import 'package:solder_history/data/manager/data_compression_manager.dart';
import 'package:solder_history/data/solder_details.dart';

class AddSolder extends StatelessWidget {
  // final ScrollController _scrollController = ScrollController();
  double scrollStep = 0;
  SolderDetails solderDetails = SolderDetails();
  static const String id = "addSolder";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataCompressionCubit, DataCompressionState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "اضافة سجل",
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
                      Form(
                        key: solderDetails.formKey,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * .45,
                                  child: GlobalTextFormField(
                                    controller: solderDetails.recruitmentArea,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.text,
                                    text: "منطقة التجنيد",
                                  ),
                                ),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width * .45,
                                    child: GlobalTextFormField(
                                      controller: solderDetails.forces,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      text: "القوات",
                                    ))
                              ],
                            ),SizedBox(
                              height: 12,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * .45,
                                  child: GlobalTextFormField(
                                    controller: solderDetails.militaryId,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.number,
                                    text: "الرقم العسكري",
                                  ),
                                ),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width * .45,
                                    child: GlobalTextFormField(
                                      controller: solderDetails.tripleNumber,
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.next,
                                      text: "الرقم الثلاثي",
                                    ))
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            GlobalTextFormField(
                              controller: solderDetails.name,
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
                                  width: MediaQuery.of(context).size.width * .45,
                                  child: Column(
                                    children: [
                                      GlobalTextFormField(
                                        keyboardType: TextInputType.text,
                                        textInputAction: TextInputAction.next,
                                        text: "تاريخ الميلاد",
                                        controller: solderDetails.dateOfBirth,
                                        enabled: false,
                                      ),
                                      FilledButton(
                                        onPressed: () {
                                          showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(1940),
                                            lastDate: DateTime.now().add(
                                              const Duration(days: 3*365),
                                            ),
                                          ).then((value) {
                                            if (value == null) return;
                                            solderDetails.dateOfBirth.text =
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
                                  width: MediaQuery.of(context).size.width * .45,
                                  child: GlobalTextFormField(
                                    keyboardType: TextInputType.text,
                                    controller: solderDetails.center,
                                    textInputAction: TextInputAction.next,
                                    text: "القسم/المركز",
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
                                  width: MediaQuery.of(context).size.width * .45,
                                  child: GlobalTextFormField(
                                    keyboardType: TextInputType.text,
                                    controller: solderDetails.governorate,
                                    textInputAction: TextInputAction.next,
                                    text: "المحافظة",
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * .45,
                                  child: GlobalTextFormField(
                                    controller: solderDetails.idNumber,
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.next,
                                    text: "الرقم القومي",
                                  ),
                                ),
                              ],
                            ),SizedBox(
                              height: 12,
                            ),
                            GlobalTextFormField(
                              controller: solderDetails.address,
                              keyboardType: TextInputType.text,
                              text: "العنوان",
                              textInputAction: TextInputAction.next,
                            ),SizedBox(
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
                                        controller: solderDetails.enlistmentDate,
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
                                            lastDate: DateTime.now().add(
                                              const Duration(days: 3*365),
                                            ),
                                          ).then((value) {
                                            if (value == null) return;
                                            solderDetails.enlistmentDate.text =
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
                                  width: MediaQuery.of(context).size.width * .45,
                                  child: GlobalTextFormField(
                                    controller: solderDetails.weapon,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                    text: "السلاح",
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
            
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
                                  controller: solderDetails.serviceEndDate,
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
                                        const Duration(days: 3*365),
                                      ),
                                    ).then((value) {
                                      if (value == null) return;
                                      solderDetails.serviceEndDate.text =
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
                            width: MediaQuery.of(context).size.width * .45,
                            child: GlobalTextFormField(
                              controller: solderDetails.phoneNumber,
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
                            width: MediaQuery.of(context).size.width * .45,
                            child: GlobalTextFormField(
                              keyboardType: TextInputType.text,
                              controller: solderDetails.medicalLevel,
                              textInputAction: TextInputAction.next,
                              text: "المستوى الطبي",
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .45,
                            child: GlobalTextFormField(
                              keyboardType: TextInputType.text,
                              controller: solderDetails.educationalLevel,
                              textInputAction: TextInputAction.next,
                              text: "المستوى الثقافي",
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
                            width: MediaQuery.of(context).size.width * .45,
                            child: GlobalTextFormField(
                              keyboardType: TextInputType.text,
                              controller: solderDetails.religion,
                              textInputAction: TextInputAction.next,
                              text: "الديانة",
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .45,
                            child: GlobalTextFormField(
                              controller: solderDetails.bloodType,
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.text,
                              text: "فصيلة الدم",
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .1,
                      ),
                    ],
                  ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton:state is AddDataCompressionLoading?SizedBox(): FilledButton(
              style: FilledButton.styleFrom(backgroundColor: Colors.indigo),
              onPressed: () {
                if (solderDetails.formKey.currentState!.validate()) {
                  BlocProvider.of<DataCompressionCubit>(context)
                      .addData(solderDetails.solderModel());
                  Navigator.pop(context);
                }
              },
              child: Text("اضافة")),
        );
      },
    );
  }
}
