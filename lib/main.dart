import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:solder_history/core/hive_helper.dart';
import 'package:solder_history/core/key_manager/key_manager.dart';
import 'package:solder_history/cubit/data_compression_cubit.dart';
import 'package:solder_history/data/firebase/in_firebase_access.dart';
import 'package:solder_history/data/firebase/in_firebase_data.dart';
import 'package:solder_history/data/local/in_hive_data.dart';
import 'package:solder_history/data/manager/data_compression_manager.dart';
import 'package:solder_history/data/manager/firebase_comp_manager.dart';
import 'package:solder_history/data/model/data_compression_model.dart';
import 'package:solder_history/data/model/device_auth_model.dart';
import 'package:solder_history/data/model/solder_model.dart';
import 'package:solder_history/helper/helper_method.dart';
import 'package:solder_history/route_manager.dart';
import 'package:solder_history/views/solder_history/add_solder.dart';
import 'package:solder_history/views/solder_history/solder_list.dart';

import 'package:solder_history/views/solder_history/solder_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  getDeviceId();
  await Hive.initFlutter();
  await Hive.openBox("DataCompression");
  await Hive.openBox("device");
  // deviceBox.delete("auth");
  InFirebaseAccess().updateDevice();
  // print(getAuthDevice());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DataCompressionCubit>(
            create: (_) => DataCompressionCubit()..getDataComp())
      ],
      child: SafeArea(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            Locale("en"),
            Locale('ar'), // arabic
          ],
          onGenerateRoute: RouteManager.onGenerate,
          initialRoute: SolderList.id,
          locale: Locale("ar"),
        ),
      ),
    );
  }
}
