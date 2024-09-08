class Student {
  final String id;
  final String firstName;
  final String lastName;
  final String nationality;
  final String imageUri;
  final DateTime birthDate;
  bool hasSpecialNeeds;

  Student({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.nationality,
    required this.imageUri,
    required this.birthDate,
    this.hasSpecialNeeds = false,
  });

  int get age {
    final now = DateTime.now();
    final years = now.year - birthDate.year;
    if (now.month < birthDate.month || (now.month == birthDate.month && now.day < birthDate.day)) {
      return years - 1;
    }
    return years;
  }

  String get fullName => '$firstName $lastName';
}