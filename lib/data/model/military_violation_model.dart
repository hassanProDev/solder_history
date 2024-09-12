import 'package:solder_history/core/key_manager/key_manager.dart';
import 'package:solder_history/data/entity/military_violation.dart';

class MilitaryViolationModel extends MilitaryViolation {
  MilitaryViolationModel({
    super.vid,
    required super.dateOfTheCrime,
    required super.description,
    required super.imposedPunishment,
    required super.orderForThePunishment,
  });

  MilitaryViolationModel.fromJson(Map<String, dynamic> json)
      : this(
          vid: json[KeyManager.id],
          dateOfTheCrime: DateTime.parse(json[KeyManager.dateOfTheCrime]),
          description: json[KeyManager.description],
          imposedPunishment: json[KeyManager.imposedPunishment],
          orderForThePunishment: json[KeyManager.orderForThePunishment],
        );

  Map<String, dynamic> toJson() {
    return {
      KeyManager.id: vid,
      KeyManager.dateOfTheCrime: dateOfTheCrime.toString(),
      KeyManager.description: description,
      KeyManager.imposedPunishment: imposedPunishment,
      KeyManager.orderForThePunishment: orderForThePunishment,
    };
  }
}
