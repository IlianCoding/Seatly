import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import 'package:seatly/domain/classroom.dart';

class UShapeLayoutWidget extends StatelessWidget {
  final Classroom classroom;

  const UShapeLayoutWidget({super.key, required this.classroom});

  @override
  Widget build(BuildContext context) {

    return Text(AppLocalizations.of(context)!.theme);
  }
}