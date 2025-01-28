import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:seatly/domain/classroom.dart';
import 'package:seatly/domain/configuration/layoutType/layout_type.dart';
import 'package:seatly/service/classroom/i_classroom_service.dart';
import 'package:seatly/ui/model/classroom_add_model.dart';

class ClassroomAddPageViewModel extends StateNotifier<ClassroomAddModel> {
  final IClassroomService classroomService;

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

  Future<bool> addClassroom() async {
    try {
      await classroomService.addClassroom(
        Classroom(
          id: "Temporary",
          name: state.name!,
          layoutType: state.layoutType!,
          desks: [],
          studentIds: [],
        ),
        state.amountOfDesks!,
        state.amountOfRows,
        state.amountOfStudentsPerDesk,
        state.amountOfSpecialDesks,
        state.amountOfRows
      );
      return true;
    } catch (e) {
      AsyncError(e, StackTrace.current);
      return false;
    }
  }
}