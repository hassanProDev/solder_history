import 'package:flutter/material.dart';
import 'package:solder_history/views/calc_military_service/date_calc_page.dart';
import 'package:solder_history/views/solder_history/add_solder.dart';
import 'package:solder_history/views/solder_history/history_details.dart';
import 'package:solder_history/views/solder_history/history_details_list.dart';
import 'package:solder_history/views/solder_history/sent_history.dart';
import 'package:solder_history/views/solder_history/solder_list.dart';
import 'package:solder_history/views/solder_history/solder_screen.dart';
import 'package:solder_history/views/solder_history/update_solder.dart';
import 'package:solder_history/views/solder_history/waiting_sent_history.dart';

class RouteManager {
  static Route<dynamic> onGenerate(RouteSettings settings) {
    switch (settings.name) {
      case SolderScreen.id:
        return materialPageRoute(child: SolderScreen());
      case AddSolder.id:
        return materialPageRoute(child: AddSolder());
      case SolderList.id:
        return materialPageRoute(child: SolderList());
      case HistoryDetails.id:
        return materialPageRoute(child: HistoryDetails());
      case HistoryDetailsList.id:
        return materialPageRoute(child: HistoryDetailsList());
      case DateCalcPage.id:
        return materialPageRoute(child: DateCalcPage());
      case SentHistory.id:
        return materialPageRoute(child: SentHistory());
      case WaitingSentHistory.id:
        return materialPageRoute(child: WaitingSentHistory());
      case UpdateSolder.id:
        return materialPageRoute(child: UpdateSolder());

      default:
        return materialPageRoute(child: Container());
    }
  }
}

materialPageRoute({required Widget child}) {
  return MaterialPageRoute(builder: (context) => child);
}
