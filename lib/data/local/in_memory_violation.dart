import 'package:solder_history/data/entity/military_violation.dart';
import 'package:solder_history/data/repository/military_violation_repo.dart';

class InMemoryViolation extends MilitaryViolationRepo {
  List<MilitaryViolation> violations = [];

  @override
  void addViolation(MilitaryViolation violation) {
    violations.add(violation);
  }

  @override
  void deleteViolation(String id) {
    violations.removeWhere((e) => e.vid == id);
  }

  @override
  List<MilitaryViolation> getAllViolation() {
    return violations;
  }

  @override
  MilitaryViolation getViolation(info) {
    return violations.firstWhere((e) => e.vid == info);
  }

  @override
  void updateViolation(String id) {
    throw "";
  }
}
