class DeskDetailsModel {
  final String studentId;
  final String studentName;
  final String studentNationality;
  final String studentImageUri;
  final int studentAge;
  bool studentHasSpecialNeeds;


  DeskDetailsModel({
    required this.studentId,
    required this.studentName,
    required this.studentNationality,
    required this.studentImageUri,
    required this.studentAge,
    required this.studentHasSpecialNeeds,
  });

  DeskDetailsModel copyWith({
    String? studentId,
    String? studentName,
    String? studentNationality,
    String? studentImageUri,
    int? studentAge,
    bool? studentHasSpecialNeeds,
  }) {
    return DeskDetailsModel(
      studentId: studentId ?? this.studentId,
      studentName: studentName ?? this.studentName,
      studentNationality: studentNationality ?? this.studentNationality,
      studentImageUri: studentImageUri ?? this.studentImageUri,
      studentAge: studentAge ?? this.studentAge,
      studentHasSpecialNeeds: studentHasSpecialNeeds ?? this.studentHasSpecialNeeds,
    );
  }

  String get studentIdValue => studentId;
  String get studentNameValue => studentName;
  String get studentNationalityValue => studentNationality;
  String get studentImageUriValue => studentImageUri;
  int get studentBirthDateValue => studentAge;
  bool get studentHasSpecialNeedsValue => studentHasSpecialNeeds;
}