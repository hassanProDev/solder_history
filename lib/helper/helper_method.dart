
int calculateAge(DateTime birthDate) {
  DateTime currentDate = DateTime.now();
  int age = currentDate.year - birthDate.year;
  int month1 = currentDate.month;
  int month2 = birthDate.month;

  if (month2 > month1 || (month1 == month2 && currentDate.day < birthDate.day)) {
    age--;
  }

  return age;
}
int calculateSpecificAge({required DateTime birthDate,required DateTime specificDate}) {
  int age = specificDate.year - birthDate.year;
  int month1 = specificDate.month;
  int month2 = birthDate.month;

  if (month2 > month1 || (month1 == month2 && specificDate.day < birthDate.day)) {
    age--;
  }

  return age;
}
