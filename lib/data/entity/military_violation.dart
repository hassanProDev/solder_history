class MilitaryViolation {
  static int id=1000;
  late String? vid;
  DateTime dateOfTheCrime;
  String description;
  String imposedPunishment;
  String orderForThePunishment;

  MilitaryViolation({
    this.vid,
    required this.dateOfTheCrime,
    required this.description,
    required this.imposedPunishment,
    required this.orderForThePunishment,
  }){
   id++;
   vid=id.toString();
  }

  @override
  String toString() {
    return "MilitaryViolation(id:$vid,dateOfTheCrime: $dateOfTheCrime, description: $description, imposedPunishment: $imposedPunishment, orderForThePunishment: $orderForThePunishment)";
  }
}
