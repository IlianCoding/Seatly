import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import 'package:seatly/domain/classroom.dart';
import 'package:seatly/domain/configuration/layoutType/layout_type.dart';
import 'package:seatly/domain/desk.dart';
import 'package:seatly/service/classroom/i_classroom_service.dart';
import 'package:seatly/ui/model/classroom_add_model.dart';

class ClassroomAddPageViewModel extends StateNotifier<ClassroomAddModel>{
  final IClassroomService classroomService;
  final Uuid uuid = const Uuid();

  ClassroomAddPageViewModel(this.classroomService) : super(ClassroomAddModel());

  void reset() {
    state = ClassroomAddModel();
  }

  double? getDeskCount() {
    return state.amountOfDesks?.toDouble();
  }

  double? getColumnCount() {
    return state.amountOfColumns?.toDouble();
  }

  LayoutType? getLayoutType() {
    return state.layoutType;
  }

  List<Desk> generateDesks(){
    return List.generate(state.amountOfDesks as int, (index) => Desk(id: index.toString()));
  }

  Future<void> generateUniqueId() async {
    final existingIds = await classroomService.getAllClassroomIds();
    String newId;
    do {
      newId = uuid.v4();
    } while (existingIds.contains(newId));
    state = state.copyWith(id: newId);
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

  Future<void> setColumnCount(int totalColumns) async {
    state = state.copyWith(amountOfColumns: totalColumns);
  }

  Future<void> setStudentsPerDesk(int studentsPerDesk) async {
    state = state.copyWith(amountOfStudentsPerDesk: studentsPerDesk);
  }

  Future<void> setSpecialDeskCount(int specialDeskCount) async {
    state = state.copyWith(amountOfSpecialDesks: specialDeskCount);
  }

  Future<bool> addClassroom() async {
    try {
      await generateUniqueId();
      await classroomService.addClassroom(
        Classroom(
            id: state.id as String,
            name: state.name as String,
            layoutType: state.layoutType as LayoutType,
            desks: generateDesks(),
            studentIds: []
        )
      );
      return true;
    } catch (e) {
      AsyncError(e, StackTrace.current);
      return false;
    }
  }
}