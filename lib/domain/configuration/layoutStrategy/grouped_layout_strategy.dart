import 'package:injectable/injectable.dart';
import 'package:seatly/domain/classroom.dart';

import 'package:seatly/domain/configuration/layoutStrategy/layout_strategy.dart';

@Singleton(as : ILayoutStrategy)
class GroupedLayoutStrategy implements ILayoutStrategy {
  @override
  bool assignStudents(Classroom classroom) {
    // TODO: implement assignStudents
    throw UnimplementedError();
  }

}