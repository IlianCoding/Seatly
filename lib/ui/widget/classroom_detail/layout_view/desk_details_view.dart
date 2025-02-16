import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:seatly/domain/desk.dart';
import 'package:seatly/domain/student.dart';
import 'package:seatly/ui/providers/viewmodel_providers.dart';
import 'package:seatly/ui/viewmodel/classroom_detailpage_viewmodel.dart';

class DeskDetailWidget extends StatefulWidget {
  final Desk desk;

  const DeskDetailWidget({super.key, required this.desk});

  @override
  _DeskDetailWidgetState createState() => _DeskDetailWidgetState();
}

class _DeskDetailWidgetState extends State<DeskDetailWidget> {
  Student? student;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchStudent();
  }

  void _fetchStudent() {

  }

  @override
  Widget build(BuildContext context) {
  }
}