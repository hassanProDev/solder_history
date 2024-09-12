import 'package:flutter/material.dart';
import 'package:solder_history/views/solder_history/add_solder.dart';
import 'package:solder_history/views/solder_history/solder_list.dart';
import 'package:solder_history/views/solder_history/solder_screen.dart';

class RouteManager {
  static Route<dynamic> onGenerate(RouteSettings settings) {
    switch (settings.name) {
      case SolderScreen.id:
        return materialPageRoute(child: SolderScreen());
      case AddSolder.id:
        return materialPageRoute(child: AddSolder());
      case SolderList.id:
        return materialPageRoute(child: SolderList());

      default:
        return materialPageRoute(child: Container());
    }
  }
}

materialPageRoute({required Widget child}) {
  return MaterialPageRoute(builder: (context) => child);
}
