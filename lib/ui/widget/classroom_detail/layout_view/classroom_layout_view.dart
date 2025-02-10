import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import 'package:seatly/domain/classroom.dart';
import 'package:seatly/domain/configuration/layoutType/layout_type.dart';
import 'package:seatly/ui/widget/classroom_detail/layout_view/grouped_layout_view.dart';
import 'package:seatly/ui/widget/classroom_detail/layout_view/row_by_row_layout_view.dart';
import 'package:seatly/ui/widget/classroom_detail/layout_view/special_ushape_layout_view.dart';
import 'package:seatly/ui/widget/classroom_detail/layout_view/ushape_layout_view.dart';

class ClassroomLayoutWidget extends StatelessWidget {
  final Classroom classroom;

  const ClassroomLayoutWidget({super.key, required this.classroom});

  @override
  Widget build(BuildContext context) {
    switch (classroom.layoutType) {
      case LayoutType.rowByRow:
        return RowByRowLayoutWidget(classroom: classroom);
      case LayoutType.uShape:
        return UShapeLayoutWidget(classroom: classroom);
      case LayoutType.groupedLayout:
        return GroupedLayoutWidget(classroom: classroom);
      case LayoutType.specialUShape:
        return SpecialUShapeLayoutWidget(classroom: classroom);
      case LayoutType.labLayout:
        return GroupedLayoutWidget(classroom: classroom);
      default:
        return Center(
          child: Text(AppLocalizations.of(context)!.classroomLayoutNotFound),
        );
    }
  }
}