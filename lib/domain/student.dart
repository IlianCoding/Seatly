import 'package:json_annotation/json_annotation.dart';

part 'student.g.dart';

@JsonSerializable()
class Student {
  final String id;
  final String firstName;
  final String lastName;
  final String nationality;
  final String imageUri;
  @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
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

  // Calculating the age of the student
  int get age {
    final now = DateTime.now();
    final years = now.year - birthDate.year;
    if (now.month < birthDate.month || (now.month == birthDate.month && now.day < birthDate.day)) {
      return years - 1;
    }
    return years;
  }

  // Requesting the full name of the student
  String get fullName => '$firstName $lastName';

  // JSON serialization
  factory Student.fromJson(Map<String, dynamic> json) => _$StudentFromJson(json);
  Map<String, dynamic> toJson() => _$StudentToJson(this);

  static DateTime _dateTimeFromJson(String date) => DateTime.parse(date);
  static String _dateTimeToJson(DateTime date) => date.toIso8601String();
}