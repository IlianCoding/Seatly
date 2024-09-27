import 'package:seatly/domain/configuration/layoutType/layout_type.dart';

class ClassroomAddModel {
  final String? id;
  final String? name;
  final LayoutType? layoutType;
  final int? amountOfDesks;
  final int? amountOfColumns;
  final int? amountOfStudentsPerDesk;
  final int? amountOfSpecialDesks;

  ClassroomAddModel({
    this.id,
    this.name,
    this.layoutType,
    this.amountOfDesks,
    this.amountOfColumns,
    this.amountOfStudentsPerDesk,
    this.amountOfSpecialDesks
  });

  ClassroomAddModel copyWith({
    String? id,
    String? name,
    LayoutType? layoutType,
    int? amountOfDesks,
    int? amountOfColumns,
    int? amountOfStudentsPerDesk,
    int? amountOfSpecialDesks
  }) {
    return ClassroomAddModel(
      id: id ?? this.id,
      name: name ?? this.name,
      layoutType: layoutType ?? this.layoutType,
      amountOfDesks: amountOfDesks ?? this.amountOfDesks,
      amountOfColumns: amountOfColumns ?? this.amountOfColumns,
      amountOfStudentsPerDesk: amountOfStudentsPerDesk ?? this.amountOfStudentsPerDesk,
      amountOfSpecialDesks: amountOfSpecialDesks ?? this.amountOfSpecialDesks
    );
  }
}