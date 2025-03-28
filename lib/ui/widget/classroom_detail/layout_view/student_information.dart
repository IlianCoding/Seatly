import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:seatly/ui/model/desk_details_model.dart';

class StudentInformationWidget extends StatelessWidget {
  final DeskDetailsModel studentInformation;

  const StudentInformationWidget({super.key, required this.studentInformation});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(studentInformation.studentName),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Nationality: ${studentInformation.studentNationality}'),
          Text('Age: ${studentInformation.studentAge}'),
          Text('Required Assistance: ${studentInformation.studentHasSpecialNeeds
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