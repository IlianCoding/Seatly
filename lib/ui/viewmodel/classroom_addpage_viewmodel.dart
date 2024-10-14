import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import 'package:seatly/domain/position.dart';
import 'package:seatly/domain/classroom.dart';
import 'package:seatly/domain/configuration/layoutType/layout_type.dart';
import 'package:seatly/domain/desk.dart';
import 'package:seatly/service/classroom/i_classroom_service.dart';
import 'package:seatly/ui/model/classroom_add_model.dart';

class ClassroomAddPageViewModel extends StateNotifier<ClassroomAddModel> {
  final IClassroomService classroomService;
  final Uuid uuid = const Uuid();

  ClassroomAddPageViewModel(this.classroomService) : super(ClassroomAddModel());

  void reset() {
    state = ClassroomAddModel();
  }

  double? getDeskCount() {
    return state.amountOfDesks?.toDouble();
  }

  double? getSpecialDeskCount() {
    return state.amountOfSpecialDesks?.toDouble();
  }

  double? getRowCount() {
    return state.amountOfRows?.toDouble();
  }

  LayoutType? getLayoutType() {
    return state.layoutType;
  }

  Future<void> setClassroomName(String name) async {
    state = state.copyWith(name: name);
  }

  Future<void> setLayoutType(LayoutType layoutType) async {
    state = state.copyWith(layoutType: layoutType);
  }

  Future<void> setDeskCount(int totalCount) async {
    state = state.copyWith(amountOfDesks: totalCount);
  }

  Future<void> setRowCount(int totalRows) async {
    state = state.copyWith(amountOfRows: totalRows);
  }

  Future<void> setStudentsPerDesk(int studentsPerDesk) async {
    state = state.copyWith(amountOfStudentsPerDesk: studentsPerDesk);
  }

  Future<void> setSpecialDeskCount(int specialDeskCount) async {
    state = state.copyWith(amountOfSpecialDesks: specialDeskCount);
  }

  Future<void> generateUniqueId() async {
    final existingIds = await classroomService.getAllClassroomIds();
    String newId;
    do {
      newId = uuid.v4();
    } while (existingIds.contains(newId));
    state = state.copyWith(id: newId);
  }

  Future<List<Desk>> generateDesks() async {
    List<Desk> desks = [];
    switch (state.layoutType) {
      case LayoutType.rowByRow:
        desks.addAll(await generateRowLayoutDesks());
        break;
      case LayoutType.groupedLayout:
        desks.addAll(await generateGroupLayoutDesks());
        break;
      case LayoutType.labLayout:
        desks.addAll(await generateGroupLayoutDesks());
        break;
      case LayoutType.uShape:
        desks.addAll(await generateUShapeLayoutDesks());
        break;
      case LayoutType.specialUShape:
        desks.addAll(await generateSpecialUShapeLayoutDesks());
        break;
      default:
        desks.addAll(await generateUShapeLayoutDesks());
        break;
    }
    return desks;
  }

  Future<List<Desk>> generateRowLayoutDesks() async {
    int totalDesks = state.amountOfDesks as int;
    int rows = state.amountOfRows as int;
    int desksPerRow = (totalDesks / rows).ceil();

    List<Desk> desks = [];
    for (int i = 0; i < totalDesks; i++) {
      int row = i ~/ desksPerRow;
      int column = i % desksPerRow;
      desks.add(
          Desk(id: "desk$i", position: Position(row: row, column: column)));
    }

    return desks;
  }

  Future<List<Desk>> generateGroupLayoutDesks() async {
    int totalDesks = state.amountOfDesks as int;
    int desksPerGroup = state.amountOfStudentsPerDesk as int;

    List<Desk> desks = [];
    for (int i = 0; i < totalDesks; i++) {
      int group = i ~/ desksPerGroup;
      int positionInGroup = i % desksPerGroup;
      desks.add(Desk(
          id: "desk$i",
          position: Position(row: group, column: positionInGroup)));
    }

    return desks;
  }

  Future<List<Desk>> generateUShapeLayoutDesks() async {
    int totalDesks = state.amountOfDesks as int;

    List<Desk> desks = [];
    for (int i = 0; i < totalDesks; i++) {
      desks.add(
          Desk(id: "desk$i", position: Position(row: 0, column: i)));
    }

    return desks;
  }

  Future<List<Desk>> generateSpecialUShapeLayoutDesks() async {
    int totalDesks = state.amountOfDesks as int;
    int middleDesks = state.amountOfSpecialDesks as int;
    int middleRows = state.amountOfRows as int;
    int outerDesks = totalDesks - middleDesks;
    int desksPerRow = (middleDesks / middleRows).ceil();

    List<Desk> desks = [];
    for (int i = 0; i < outerDesks; i++) {
      desks.add(Desk(id: "desk$i", position: Position(row: 0, column: i)));
    }

    for (int i = 0; i < middleDesks; i++) {
      int row = (i ~/ desksPerRow) + 1;
      int column = i % desksPerRow;
      desks.add(Desk(id: "desk${outerDesks + i}", position: Position(row: row, column: column)));
    }

    return desks;
  }

  Future<bool> addClassroom() async {
    try {
      await generateUniqueId();
      await classroomService.addClassroom(Classroom(
          id: state.id as String,
          name: state.name as String,
          layoutType: state.layoutType as LayoutType,
          desks: await generateDesks(),
          studentIds: []));
      return true;
    } catch (e) {
      AsyncError(e, StackTrace.current);
      return false;
    }
  }
}