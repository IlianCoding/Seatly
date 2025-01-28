import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:seatly/domain/configuration/layoutType/layout_type.dart';

class ClassroomEditDialog extends ConsumerStatefulWidget {
  final String currentName;
  final int currentAmountOfDesks;
  final LayoutType currentLayoutType;
  final int currentStudentCount;
  final Function(String, int) onSave;

  const ClassroomEditDialog({
    super.key,
    required this.currentName,
    required this.currentAmountOfDesks,
    required this.currentLayoutType,
    required this.currentStudentCount,
    required this.onSave,
  });

  @override
  _ClassroomEditDialogState createState() => _ClassroomEditDialogState();
}

class _ClassroomEditDialogState extends ConsumerState<ClassroomEditDialog> {
  late TextEditingController _nameController;
  late LayoutType _layoutTypeController;
  late TextEditingController _desksController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.currentName);
    _layoutTypeController = widget.currentLayoutType;
    _desksController = TextEditingController(text: widget.currentAmountOfDesks.toString());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _desksController.dispose();
    super.dispose();
  }

  String _getLocalizedLayoutType(BuildContext context, LayoutType layoutType) {
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15)
      ),
      title: Text(AppLocalizations.of(context)!.edit),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.addClassroomName,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
                validator: (value) {
                  if(value == null || value.trim().isEmpty){
                    return AppLocalizations.of(context)!.classroomNameRequired;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<LayoutType>(
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.addClassroomLayoutType,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
                value: _layoutTypeController,
                items: LayoutType.values.map((layoutType) {
                  return DropdownMenuItem(
                    value: layoutType,
                    child: Text(_getLocalizedLayoutType(context, layoutType)),
                  );
                }).toList(),
                onChanged: (LayoutType? newValue) {
                  if(newValue != null){
                    setState(() {
                      _layoutTypeController = newValue;
                    });
                  }
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _desksController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.addClassroomTotalDesks,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
                validator: (value) {
                  if(value == null || value.trim().isEmpty){
                    return AppLocalizations.of(context)!.classroomDesksRequired;
                  }
                  int? desks = int.tryParse(value);
                  if(desks == null || desks < 0){
                    return AppLocalizations.of(context)!.classroomDesksInvalid;
                  }
                  if(desks < widget.currentStudentCount){
                    return AppLocalizations.of(context)!.classroomDesksLessThanStudentCount;
                  }
                  return null;
                },
              )
            ],
        ),
      ),
    );
  }
}