import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:seatly/domain/classroom.dart';
import 'package:seatly/domain/configuration/layoutType/layout_type.dart';
import 'package:seatly/domain/desk.dart';
import 'package:seatly/service/classroom/i_classroom_service.dart';
import 'package:uuid/uuid.dart';

class ClassroomAddPageViewModel extends StateNotifier<Classroom>{
  final IClassroomService classroomService;
  final Uuid uuid = const Uuid();

  ClassroomAddPageViewModel(this.classroomService)
      : super(Classroom(
    id: 'dummy',
    name: 'dummy',
    layoutType: LayoutType.rowByRow,
    desks: [],
    studentIds: []
  ));

  void reset(Classroom Function(Classroom) updateFn) {
    state = updateFn(state);
  }

  double getDeskCount() {
    return state.desks.length.toDouble();
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

  Future<void> setDeskCount(int totalCount) async {
    state = state.copyWith(desks: List.generate(totalCount, (index) => Desk(id: index.toString())));
  }

  Future<void> setLayoutType(LayoutType layoutType) async {
    state = state.copyWith(layoutType: layoutType);
  }

  Future<void> addClassroom() async {
    try {
      await generateUniqueId();
      await classroomService.addClassroom(state);
    } catch (e) {
      AsyncError(e, StackTrace.current);
    }
  }
}