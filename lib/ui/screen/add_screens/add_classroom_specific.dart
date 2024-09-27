import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:seatly/domain/configuration/layoutType/layout_type.dart';

import 'package:seatly/ui/providers/viewmodel_providers.dart';
import 'package:seatly/ui/screen/home_screen.dart';
import 'package:seatly/ui/widget/add/classroom_add_details_widget.dart';
import 'package:seatly/ui/widget/add/classroom_add_special_u_shape_details_widget.dart';

class AddClassroomSpecific extends HookConsumerWidget {
  const AddClassroomSpecific({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(classroomAddPageViewModel.notifier);

    if(viewModel.getLayoutType() != null) {
      switch(viewModel.getLayoutType()) {
        case LayoutType.rowByRow:
          return AddDetailsWidget(
              label: AppLocalizations.of(context)!.slideTotalColumns,
              path: 'assets/images/rowbyrow.png',
              onSelect: (value) {
                viewModel.setColumnCount(value);
              },
              color: Colors.orange,
          );
        case LayoutType.groupedLayout:
          return AddDetailsWidget(
              label: AppLocalizations.of(context)!.slideTotalStudentsPerDesk,
              path: 'assets/images/grouped.png',
              onSelect: (value) {
                viewModel.setStudentsPerDesk(value);
              },
              color: Colors.red,
          );
        case LayoutType.labLayout:
          return AddDetailsWidget(
              label: AppLocalizations.of(context)!.slideTotalStudentsPerDesk,
              path: 'assets/images/laboratory.png',
              onSelect: (value) {
                viewModel.setStudentsPerDesk(value);
              },
              color: Colors.green,
          );
        case LayoutType.uShape:
          viewModel.addClassroom();
          return const HomeScreen();
        case LayoutType.specialUShape:
          return AddSpecialUShapeDetailsWidget(
              label: AppLocalizations.of(context)!.slideTotalPlacesInTheMiddle,
              path: 'assets/images/specialUShape.png',
              color: Colors.blue,
          );
        default:
          Navigator.pop(context);
      }
    } else {
      Navigator.pop(context);
    }

    return const Scaffold();
  }
}