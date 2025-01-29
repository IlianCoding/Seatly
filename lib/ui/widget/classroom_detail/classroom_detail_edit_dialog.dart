import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:seatly/domain/configuration/layoutType/layout_type.dart';
import 'package:seatly/ui/providers/viewmodel_providers.dart';
import 'package:seatly/ui/widget/classroom_detail/classroom_detail_layout_dialog.dart';

class ClassroomEditDialog extends ConsumerStatefulWidget {
  final String classroomId;

  const ClassroomEditDialog({super.key, required this.classroomId});

  @override
  _ClassroomEditDialogState createState() => _ClassroomEditDialogState();
}

class _ClassroomEditDialogState extends ConsumerState<ClassroomEditDialog> {

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(classroomDetailPageViewModel(widget.classroomId));

    String getLocalizedLayoutType(BuildContext context, LayoutType layoutType) {
      switch (layoutType) {
        case LayoutType.rowByRow:
          return AppLocalizations.of(context)!.rowbyrow;
        case LayoutType.groupedLayout:
          return AppLocalizations.of(context)!.grouped;
        case LayoutType.labLayout:
          return AppLocalizations.of(context)!.laboratory;
        case LayoutType.uShape:
          return AppLocalizations.of(context)!.ushape;
        case LayoutType.specialUShape:
          return AppLocalizations.of(context)!.specialushape;
        default:
          return AppLocalizations.of(context)!.rowbyrow; // Default case
      }
    }

    return state.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
      data: (classroomDetails) {
        final nameController = TextEditingController(text: classroomDetails.classroom?.name);
        final desksController = TextEditingController(text: classroomDetails.classroom?.desks.length.toString() ?? '');
        final formKey = GlobalKey<FormState>();
        var selectedLayout = classroomDetails.classroom?.layoutType;

        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
          ),
          title: Text(AppLocalizations.of(context)!.edit),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.changeClassroomName,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) return AppLocalizations.of(context)!.classroomNameRequired;
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                StatefulBuilder(
                  builder: (context, setState) => DropdownButtonFormField<LayoutType>(
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.addClassroomLayoutType,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                      )
                    ),
                    value: selectedLayout,
                    items: LayoutType.values.map((layoutType) {
                      return DropdownMenuItem(
                        value: layoutType,
                        child: Text(getLocalizedLayoutType(context, layoutType)),
                      );
                    }).toList(),
                    onChanged: (LayoutType? newValue) {
                      if (newValue != null) {
                        setState(() {
                          selectedLayout = newValue;
                        });
                      }
                    },
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: desksController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.totalDesks,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) return null;
                    int? desks = int.tryParse(value);
                    if (desks == null || desks <= 0) return AppLocalizations.of(context)!.classroomDesksRequired;
                    if (desks < classroomDetails.students!.length) return AppLocalizations.of(context)!.classroomDesksLessThanStudentCount;
                    return null;
                  },
                )
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(AppLocalizations.of(context)!.cancel),
            ),
            TextButton(
              onPressed: () async {
                if (!formKey.currentState!.validate()) return;
                final viewModel = ref.read(classroomDetailPageViewModel(widget.classroomId).notifier);

                final updatedClassroom = classroomDetails.classroom?.copyWith(
                  id: classroomDetails.classroom?.id,
                  name: nameController.text.trim(),
                  layoutType: selectedLayout,
                  desks: classroomDetails.classroom?.desks,
                  studentIds: classroomDetails.classroom?.studentIds,
                  sortingOptions: classroomDetails.classroom?.sortingOptions
                );

                viewModel.state = AsyncValue.data(classroomDetails.copyWith(
                  classroom: updatedClassroom,
                  totalDesks: desksController.text.isEmpty
                    ? classroomDetails.classroom?.desks.length
                      : int.parse(desksController.text)
                ));

                if (selectedLayout != classroomDetails.classroom?.layoutType || desksController.text.isNotEmpty) {
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (context) => LayoutParametersDialog(classroomId: widget.classroomId)
                  );
                } else {
                  final succes = await viewModel.updateClassroom();
                  if (succes) {
                    Navigator.pop(context);
                  }
                }
              },
              child: Text(AppLocalizations.of(context)!.next),
            )
          ],
        );
      }
    );
  }
}