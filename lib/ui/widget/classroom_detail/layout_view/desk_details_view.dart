import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:seatly/domain/desk.dart';
import 'package:seatly/ui/providers/viewmodel_providers.dart';
import 'package:seatly/ui/widget/classroom_detail/layout_view/student_information.dart';

class DeskDetailWidget extends ConsumerStatefulWidget {
  final Desk desk;

  const DeskDetailWidget({super.key, required this.desk});

  @override
  _DeskDetailWidgetState createState() => _DeskDetailWidgetState();
}

class _DeskDetailWidgetState extends ConsumerState<DeskDetailWidget> {
  @override
  Widget build(BuildContext context) {
    final deskDetails = ref.watch(deskDetailPageViewModel(widget.desk.id));

    return deskDetails.when(
        data: (deskDetails) => StudentInformationWidget(studentInformation: deskDetails),
        loading: () => const CircularProgressIndicator(),
        error: (error, stack) => Text('Error: $error'),
    );
  }
}