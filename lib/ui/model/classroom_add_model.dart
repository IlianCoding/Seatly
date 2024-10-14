import 'package:seatly/domain/configuration/layoutType/layout_type.dart';

class ClassroomAddModel {
  final String? id;
  final String? name;
  final LayoutType? layoutType;
  final int? amountOfDesks;
  final int? amountOfRows;
  final int? amountOfStudentsPerDesk;
  final int? amountOfSpecialDesks;

  ClassroomAddModel({
    this.id,
    this.name,
    this.layoutType,
    this.amountOfDesks,
    this.amountOfRows,
    this.amountOfStudentsPerDesk,
    this.amountOfSpecialDesks
  });

  ClassroomAddModel copyWith({
    String? id,
    String? name,
    LayoutType? layoutType,
    int? amountOfDesks,
    int? amountOfRows,
    int? amountOfStudentsPerDesk,
    int? amountOfSpecialDesks
  }) {
    return ClassroomAddModel(
        id: id ?? this.id,
        name: name ?? this.name,
        layoutType: layoutType ?? this.layoutType,
        amountOfDesks: amountOfDesks ?? this.amountOfDesks,
        amountOfRows: amountOfRows ?? this.amountOfRows,
        amountOfStudentsPerDesk: amountOfStudentsPerDesk ?? this.amountOfStudentsPerDesk,
        amountOfSpecialDesks: amountOfSpecialDesks ?? this.amountOfSpecialDesks
    );
  }
}