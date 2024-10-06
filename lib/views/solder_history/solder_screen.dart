import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solder_history/cubit/data_compression_cubit.dart';
import 'package:solder_history/data/model/solder_model.dart';
import 'package:solder_history/helper/helper_method.dart';
import 'package:solder_history/views/solder_history/widgets/solder_content_widget.dart';
import 'package:url_launcher/url_launcher.dart';

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
    final myCubit = BlocProvider.of<DataCompressionCubit>(context);
    SolderModel solderModel = myCubit.solderData as SolderModel;
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(color: Colors.white,
                onPressed: ()async{
                final Uri launchUri = Uri(
                  scheme: 'tel',
                  path: solderModel.phoneNumber,
                );
                await launchUrl(launchUri);

            }, icon: Icon(Icons.call)),
          )
        ],
        title: Text(
          "مسلسل المجند ${solderModel.sId}",
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
                        "سن المجند :${calculateAge(solderModel.dateOfBirth)}",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        "سن دخول الخدمة :${calculateSpecificAge(birthDate: solderModel.dateOfBirth, specificDate: solderModel.enlistmentDate)}",
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        solderModel.isSent && solderModel.sentDate != null
                            ? "تم تسليم السجل بتاريخ ${solderModel.sentDate?.year ?? 0}-${solderModel.sentDate?.month ?? 0}-${solderModel.sentDate?.day ?? 0}"
                            : "لم يتم تسليم السجل بعد",
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  SolderContentWidget(
                    title1: "منطقة التجنيد: ",
                    content1: solderModel.recruitmentArea,
                    title2: "القوات: ",
                    content2: solderModel.forces,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  SolderContentWidget(
                    title1: "الرقم العسكري: ",
                    content1: solderModel.militaryId,
                    title2: "الرقم الثلاثي: ",
                    content2: solderModel.tripleNumber,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  SolderContentWidget(
                    title1: "الاسم: ",
                    content1: solderModel.name,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  SolderContentWidget(
                    title1: "تاريخ الميلاد: ",
                    content1:
                        "${solderModel.dateOfBirth.year} - ${solderModel.dateOfBirth.month} - ${solderModel.dateOfBirth.day}",
                    title2: "القسم: ",
                    content2: solderModel.center,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  SolderContentWidget(
                    title1: "المحافظة: ",
                    content1: solderModel.governorate,
                    title2: "الرقم القومي: ",
                    content2: solderModel.idNumber,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  SolderContentWidget(
                    title1: "تاريخ الالتحاق بالخدمة: ",
                    content1:
                        "${solderModel.enlistmentDate.year} - ${solderModel.enlistmentDate.month} - ${solderModel.enlistmentDate.day}",
                    title2: "السلاح: ",
                    content2: solderModel.weapon,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  SolderContentWidget(
                    title1: "تاريخ انتهاء الخدمة: ",
                    content1:
                        "${solderModel.serviceEndDate.year} - ${solderModel.serviceEndDate.month} - ${solderModel.serviceEndDate.day}",
                    title2: "الهاتف: ",
                    content2: solderModel.phoneNumber,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  SolderContentWidget(
                    title1: "العنوان: ",
                    content1: solderModel.address,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  SolderContentWidget(
                    title1: "المستوى الطبي: ",
                    content1: solderModel.medicalLevel,
                    title2: "المستوى الثقافي: ",
                    content2: solderModel.educationalLevel,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  SolderContentWidget(
                    title1: "الديانة: ",
                    content1: solderModel.religion,
                    title2: "فصيلة الدم: ",
                    content2: solderModel.bloodType,
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
