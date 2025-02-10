import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:seatly/ui/providers/viewmodel_providers.dart';
import 'package:seatly/ui/widget/classroom_detail/layout_view/classroom_layout_view.dart';

class ClassroomLayoutViewScreen extends ConsumerStatefulWidget {
  final String classroomId;

  const ClassroomLayoutViewScreen({super.key, required this.classroomId});

  @override
  ClassroomLayoutViewState createState() => ClassroomLayoutViewState();
}

class ClassroomLayoutViewState extends ConsumerState<ClassroomLayoutViewScreen> {

  @override
  Widget build(BuildContext context) {
    final classroomDetails = ref.watch(classroomDetailPageViewModel(widget.classroomId));

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.layoutView),
      ),
      body: ClassroomLayoutWidget(classroom: classroomDetails.value!.classroom!),
    );
  }
}