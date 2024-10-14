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

    void showSuccessNotification() async{
      bool success = await viewModel.addClassroom();
      if(success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.addClassroomSuccess),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushAndRemoveUntil(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => const HomeScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.ease;

                var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);

                return SlideTransition(position: offsetAnimation, child: child);
              },
            ), (route) => false
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.addClassroomUnsuccessful),
            backgroundColor: Colors.red,
          ),
        );
        Navigator.pushAndRemoveUntil(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => const HomeScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.ease;

                var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);

                return SlideTransition(position: offsetAnimation, child: child);
              },
            ), (route) => false
        );
      }
    }

    if(viewModel.getLayoutType() != null) {
      switch(viewModel.getLayoutType()) {
        case LayoutType.rowByRow:
          return AddDetailsWidget(
              label: AppLocalizations.of(context)!.slideTotalRows,
              path: 'assets/images/rowbyrow.png',
              onSelect: (value) {
                viewModel.setRowCount(value);
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
          showSuccessNotification();
          break;
        case LayoutType.specialUShape:
          return AddSpecialUShapeDetailsWidget(
              label: AppLocalizations.of(context)!.slideTotalPlacesInTheMiddle,
              secondLabel: AppLocalizations.of(context)!.slideTotalRowsInTheMiddle,
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