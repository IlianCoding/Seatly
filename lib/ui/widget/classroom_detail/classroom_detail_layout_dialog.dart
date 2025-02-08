import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:seatly/domain/configuration/layoutType/layout_type.dart';
import 'package:seatly/ui/providers/viewmodel_providers.dart';

class LayoutParametersDialog extends ConsumerWidget {
  final String classroomId;

  const LayoutParametersDialog({super.key, required this.classroomId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(classroomDetailPageViewModel(classroomId));

    return state.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
      data: (classroomDetails) {
        final formKey = GlobalKey<FormState>();
        final rowsController = TextEditingController();
        final desksPerGroupController = TextEditingController();
        final middleDesksController = TextEditingController();

        Widget? layoutSpecificField;
        final layoutType = classroomDetails.classroom?.layoutType;

        switch (layoutType) {
          case LayoutType.rowByRow:
            layoutSpecificField = TextFormField(
              controller: rowsController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.amountOfRows,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                  )
              ),
              validator: (value) {
                if (value == null || value.isEmpty) return null;
                final rows = int.tryParse(value);
                if (rows == null || rows <= 0) return AppLocalizations.of(context)!.invalidAmountOfRows;
                return null;
              },
            );
            break;
          case LayoutType.groupedLayout:
            layoutSpecificField = TextFormField(
              controller: desksPerGroupController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.amountOfStudentsPerDesk,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                  )
              ),
              validator: (value) {
                if (value == null || value.isEmpty) return null;
                final desksPerGroup = int.tryParse(value);
                if (desksPerGroup == null || desksPerGroup <= 0) return AppLocalizations.of(context)!.invalidAmountOfStudentsPerDesk;
                return null;
              },
            );
            break;
          case LayoutType.specialUShape:
            layoutSpecificField = Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: middleDesksController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.amountOfPlacesInTheMiddle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return null;
                    final middleDesks = int.tryParse(value);
                    if (middleDesks == null || middleDesks <= 0) return AppLocalizations.of(context)!.invalidAmountOfPlacesInTheMiddle;
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: rowsController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.amountOfRows,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return null;
                    final middleRows = int.tryParse(value);
                    if (middleRows == null || middleRows <= 0) return AppLocalizations.of(context)!.invalidAmountOfRows;
                    return null;
                  },
                ),
              ],
            );
            break;
          case LayoutType.uShape:
            break;
          case LayoutType.labLayout:
            layoutSpecificField = TextFormField(
              controller: desksPerGroupController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.amountOfStudentsPerDesk,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                  )
              ),
              validator: (value) {
                if (value == null || value.isEmpty) return null;
                final desksPerGroup = int.tryParse(value);
                if (desksPerGroup == null || desksPerGroup <= 0) return AppLocalizations.of(context)!.invalidAmountOfStudentsPerDesk;
                return null;
              },
            );
          case null:
            break;
        }

        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)
          ),
          title: Text(AppLocalizations.of(context)!.layoutExtra),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (layoutSpecificField != null)
                  ...
                  [layoutSpecificField, const SizedBox(height: 10)],
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(AppLocalizations.of(context)!.cancel),
            ),
            TextButton(
              onPressed: () async {
                if (!formKey.currentState!.validate()) return;

                final viewModel = ref.read(classroomDetailPageViewModel(classroomId).notifier);

                // Update layout parameters in state
                viewModel.state = AsyncValue.data(classroomDetails.copyWith(
                  totalRows: rowsController.text.isEmpty
                      ? null
                      : int.parse(rowsController.text),
                  amountOfDesksPerGroup: desksPerGroupController.text.isEmpty
                      ? null
                      : int.parse(desksPerGroupController.text),
                  totalMiddleDesks: middleDesksController.text.isEmpty
                      ? null
                      : int.parse(middleDesksController.text),

                ));

                final success = await viewModel.updateClassroom();
                if (success) {
                  ref.read(classroomHomepageViewModel.notifier).refresh();
                  Navigator.pop(context);
                }
              },
              child: Text(AppLocalizations.of(context)!.next),
            ),
          ],
        );
      },
    );
  }
}