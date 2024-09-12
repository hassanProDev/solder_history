import 'package:solder_history/data/entity/military_violation.dart';

abstract class MilitaryViolationRepo{
  void addViolation(MilitaryViolation violation);
  void deleteViolation(String id);
  void updateViolation(String id);
  MilitaryViolation getViolation(info);
  List<MilitaryViolation> getAllViolation();
}