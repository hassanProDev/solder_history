import 'package:solder_history/data/entity/military_violation.dart';
import 'package:solder_history/data/repository/military_violation_repo.dart';

class ViolationManager{
  MilitaryViolationRepo repo;
  ViolationManager(this.repo);

  void addViolation(MilitaryViolation violation){
    repo.addViolation(violation);
  }
  void deleteViolation(String id){
    repo.deleteViolation(id);
  }
  void updateViolation(String id){
    repo.updateViolation(id);
  }
  MilitaryViolation getViolation(info){
    return repo.getViolation(info);
  }
  List<MilitaryViolation> getAllViolation(){
    return repo.getAllViolation();
  }
}