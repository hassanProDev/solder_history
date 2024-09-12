import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solder_history/cubit/data_compression_cubit.dart';
import 'package:solder_history/data/model/solder_model.dart';
import 'package:solder_history/helper/helper_method.dart';
import 'package:solder_history/views/solder_history/widgets/solder_content_widget.dart';

class SolderScreen extends StatelessWidget {
  static const String id = "solderScreen";

  @override
  Widget build(BuildContext context) {
    // SolderModel solder
    // SolderModel(
    //   name: "احمد علاء محمد محمد احمد عبدالله",
    //   forces: "الامن المركزي",
    //   militaryId: "1234567821",
    //   enlistmentDate: DateTime(2023,10,3),
    //   center: "قسم اول اكتوبر الجيزة",
    //   governorate: "الجيزة",
    //   address: "قسم اول اكتوبر سنورس الاتحاد  ش45 ع96 الفيوم",
    //   idNumber: "1532154134154324",
    //   weapon: "وزارة الداخلية وزارة الدفاع",
    //   tripleNumber: "123451235451324123",
    //   dateOfBirth: DateTime(2001,2,13),
    //   educationalLevel: "مؤهل عالي فوق قوي",
    //   recruitmentArea: "الجيزة اكتوبر",
    //   serviceEndDate: DateTime(2024,11,25),
    //   medicalLevel: "لائق ا2 ولائق جدا",
    //   bloodType: "B+++",
    //   religion: "مسلم وافتخر الحمدلله علي هذه النعمه",
    //   phoneNumber: "0122356132215",
    //   service: "بدون سنة زياده",
    //   serviceDuration: "",
    //   lostDuration: DateTime(2000),
    //   listMilitaryViolation: [],
    //   netServiceDuration: DateTime(2002),
    // );
    final myCubit= BlocProvider.of<DataCompressionCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "سجل المجند",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 12,
                  ),
                  Column(
                    children: [
                      Text(
                        "سن المجند :${calculateAge(myCubit.solderData.listOfSolders![0].dateOfBirth)}",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        "سن دخول الخدمة :${calculateSpecificAge(birthDate: myCubit.solderData.listOfSolders![0].dateOfBirth, specificDate: myCubit.solderData.listOfSolders![0].enlistmentDate)}",
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        "سن افتراض خروجه :${calculateSpecificAge(birthDate: myCubit.solderData.listOfSolders![0].dateOfBirth, specificDate: myCubit.solderData.listOfSolders![0].serviceEndDate)}",
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  SolderContentWidget(
                    title1: "منطقة التجنيد: ",
                    content1:
                    myCubit.solderData.listOfSolders![0].recruitmentArea,
                    title2: "القوات: ",
                    content2: myCubit.solderData.listOfSolders![0].forces,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  SolderContentWidget(
                    title1: "الرقم العسكري: ",
                    content1: myCubit.solderData.listOfSolders![0].militaryId,
                    title2: "الرقم الثلاثي: ",
                    content2: myCubit.solderData.listOfSolders![0].tripleNumber,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  SolderContentWidget(
                    title1: "الاسم: ",
                    content1: myCubit.solderData.listOfSolders![0].name,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  SolderContentWidget(
                    title1: "تاريخ الميلاد: ",
                    content1:
                    "${myCubit.solderData.listOfSolders![0].dateOfBirth.year} - ${myCubit.solderData.listOfSolders![0].dateOfBirth.month} - ${myCubit.solderData.listOfSolders![0].dateOfBirth.day}",
                    title2: "القسم: ",
                    content2: myCubit.solderData.listOfSolders![0].center,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  SolderContentWidget(
                    title1: "المحافظة: ",
                    content1: myCubit.solderData.listOfSolders![0].governorate,
                    title2: "الرقم القومي: ",
                    content2: myCubit.solderData.listOfSolders![0].idNumber,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  SolderContentWidget(
                    title1: "تاريخ الالتحاق بالخدمة: ",
                    content1:
                    "${myCubit.solderData.listOfSolders![0].enlistmentDate.year} - ${myCubit.solderData.listOfSolders![0].enlistmentDate.month} - ${myCubit.solderData.listOfSolders![0].enlistmentDate.day}",
                    title2: "السلاح: ",
                    content2: myCubit.solderData.listOfSolders![0].weapon,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  SolderContentWidget(
                    title1: "تاريخ انتهاء الخدمة: ",
                    content1:
                    "${myCubit.solderData.listOfSolders![0].serviceEndDate.year} - ${myCubit.solderData.listOfSolders![0].serviceEndDate.month} - ${myCubit.solderData.listOfSolders![0].serviceEndDate.day}",
                    title2: "الهاتف: ",
                    content2: myCubit.solderData.listOfSolders![0].phoneNumber,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  SolderContentWidget(
                    title1: "العنوان: ",
                    content1: myCubit.solderData.listOfSolders![0].address,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  SolderContentWidget(
                    title1: "المستوى الطبي: ",
                    content1: myCubit.solderData.listOfSolders![0].medicalLevel,
                    title2: "المستوى الثقافي: ",
                    content2:
                    myCubit.solderData.listOfSolders![0].educationalLevel,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  SolderContentWidget(
                    title1: "الديانة: ",
                    content1: myCubit.solderData.listOfSolders![0].religion,
                    title2: "فصيلة الدم: ",
                    content2: myCubit.solderData.listOfSolders![0].bloodType,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
