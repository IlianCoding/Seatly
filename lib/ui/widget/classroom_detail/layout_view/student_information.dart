import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:seatly/domain/student.dart';

class StudentInformationWidget extends StatelessWidget {
  final Student student;

  const StudentInformationWidget({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(student.fullName),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Nationality: ${student.nationality}'),
          Text('Age: ${student.age}'),
          Text('Required Assistance: ${student.hasSpecialNeeds
              ? AppLocalizations.of(context)!.yes
              : AppLocalizations.of(context)!.no}')
        ],
      ),
      actions: [
        TextButton(
            onPressed: () => {
              Navigator.of(context).pop()
            },
            child: Text(AppLocalizations.of(context)!.close)
        )
      ],
    );
  }
}