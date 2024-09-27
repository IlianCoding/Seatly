import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:seatly/domain/configuration/layoutType/layout_type.dart';
import 'package:seatly/ui/providers/add_classroom_providers.dart';
import 'package:seatly/ui/providers/viewmodel_providers.dart';
import 'package:seatly/ui/screen/add_screens/add_classroom_specific.dart';
import 'package:seatly/ui/widget/add/classroom_add_layout_type_widget.dart';

class AddClassroomLayoutTypeScreen extends HookConsumerWidget {
  const AddClassroomLayoutTypeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(classroomAddPageViewModel.notifier);
    final selectedLayoutType = ref.watch(layoutTypeProvider);

    final layoutTypes = [
      {'label': 'Row by Row', 'icon': 'assets/images/rowbyrow.png', 'value': LayoutType.rowByRow, 'color': Colors.orange},
      {'label': 'Special U Shape', 'icon': 'assets/images/specialUShape.png', 'value': LayoutType.specialUShape, 'color': Colors.blue},
      {'label': 'Laboratory', 'icon': 'assets/images/laboratory.png', 'value': LayoutType.labLayout, 'color': Colors.green},
      {'label': 'Groups', 'icon': 'assets/images/grouped.png', 'value': LayoutType.groupedLayout, 'color': Colors.red},
      {'label': 'U shape', 'icon': 'assets/images/uShape.png', 'value': LayoutType.uShape, 'color': Colors.purple},
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade200,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.purple.shade200, Colors.white]
          )
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppLocalizations.of(context)!.addClassroomLayoutType, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text(AppLocalizations.of(context)!.addClassroomLayoutTypeDescription, style: const TextStyle(fontSize: 16, color: Colors.grey)),
              const SizedBox(height: 30),

              Expanded(
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                    ),
                    itemCount: layoutTypes.length,
                    itemBuilder: (context, index) {
                      final layoutTypeData = layoutTypes[index];
                      final isSelected = selectedLayoutType == layoutTypeData['value'];

                      return GestureDetector(
                        onTap: () {
                          ref.read(layoutTypeProvider.notifier).selectLayoutType(layoutTypeData['value'] as LayoutType);
                        },
                        child: CategoryCard(
                          label: layoutTypeData['label'] as String,
                          path: layoutTypeData['icon'] as String,
                          color: isSelected ? (layoutTypeData['color'] as Color).withOpacity(0.5) : layoutTypeData['color'] as Color,
                        ),
                      );
                    },
                  )
              ),
              Center(
                child: SizedBox(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      viewModel.setLayoutType(selectedLayoutType!);

                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => const AddClassroomSpecific(),
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            const begin = Offset(1.0, 0.0);
                            const end = Offset.zero;
                            const curve = Curves.ease;

                            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                            var offsetAnimation = animation.drive(tween);

                            return SlideTransition(position: offsetAnimation, child: child);
                          },
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      backgroundColor: Colors.purple.shade200,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                      elevation: 12.0,
                      shadowColor: Colors.black.withOpacity(0.9),
                    ),
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context)!.next,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}