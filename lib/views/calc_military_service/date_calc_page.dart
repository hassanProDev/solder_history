import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solder_history/cubit/data_compression_cubit.dart';
import 'package:solder_history/views/calc_military_service/calc_details.dart';
import 'package:solder_history/views/calc_military_service/widgets/calc_date_widget.dart';

class DateCalcPage extends StatelessWidget {
  static const String id = "dateCalcPage";
  CalcDetails calcDetails = CalcDetails();

  @override
  Widget build(BuildContext context) {
    final myCubit = BlocProvider.of<DataCompressionCubit>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(
          "حساب مسير الخدمة",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            style: TextButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              myCubit.newCalc(calcDetails);
            },
            child: Text(
              "حساب جديد",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 24),
        child: Form(
          key: calcDetails.formKey,
          child: ListView(
            children: [
              ClcDateWidget(
                text: "المدة المقررة للخدمة",
                day: calcDetails.serviceDuration.dayController,
                month: calcDetails.serviceDuration.monthController,
                year: calcDetails.serviceDuration.yearController,
              ),
              ClcDateWidget(
                text: "تاريخ التسريح",
                day: calcDetails.serviceEnd.dayController,
                month: calcDetails.serviceEnd.monthController,
                year: calcDetails.serviceEnd.yearController,
              ),
              ClcDateWidget(
                text: "تاريخ التجنيد",
                day: calcDetails.serviceStart.dayController,
                month: calcDetails.serviceStart.monthController,
                year: calcDetails.serviceStart.yearController,
              ),
              ClcDateWidget(
                text: "تاريخ الغياب",
                day: calcDetails.absence.dayController,
                month: calcDetails.absence.monthController,
                year: calcDetails.absence.yearController,
              ),
              ClcDateWidget(
                text: "تاريخ الحضور",
                day: calcDetails.attendance.dayController,
                month: calcDetails.attendance.monthController,
                year: calcDetails.attendance.yearController,
              ),
              ClcDateWidget(
                text: "المدة الفاقدة",
                day: calcDetails.lossDuration.dayController,
                month: calcDetails.lossDuration.monthController,
                year: calcDetails.lossDuration.yearController,
              ),
              Divider(),
              BlocBuilder<DataCompressionCubit, DataCompressionState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      Text(
                        "مدة الغياب : يوم ${myCubit.absenceDuration.day} شهر ${myCubit.absenceDuration.month} سنة ${myCubit.absenceDuration.year}",
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        "المدة الحسنة : يوم ${myCubit.goodServiceDuration.day} شهر ${myCubit.goodServiceDuration.month} سنة ${myCubit.goodServiceDuration.year}",
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        "اجمالي مدة الخدمة : يوم ${myCubit.allServiceDuration.day} شهر ${myCubit.allServiceDuration.month} سنة ${myCubit.allServiceDuration.year}",
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () {
          if (calcDetails.formKey.currentState!.validate()) {
            myCubit.calcDate(calcDetails);
          }
        },
        child: Text(
          "احساب",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
      ),
    );
  }
}
