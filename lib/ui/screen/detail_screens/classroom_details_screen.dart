import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:seatly/ui/widget/info/info_description_coachmark.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import 'package:seatly/ui/providers/viewmodel_providers.dart';

final searchStudentQueryProvider = StateProvider<String>((ref) => '');

class ClassroomDetailScreen extends ConsumerStatefulWidget {
  final String classroomId;

  const ClassroomDetailScreen({super.key, required this.classroomId});

  @override
  ClassroomDetailScreenState createState() => ClassroomDetailScreenState();
}

class ClassroomDetailScreenState extends ConsumerState<ClassroomDetailScreen> {
  late TextEditingController searchController;
  TutorialCoachMark? tutorialCoachMark;
  List<TargetFocus> targets = [];

  GlobalKey addButtonKey = GlobalKey();
  GlobalKey settingsButtonKey = GlobalKey();
  GlobalKey importButtonKey = GlobalKey();
  GlobalKey searchFieldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    searchController.addListener(() {
      ref.read(searchStudentQueryProvider.notifier).state = searchController.text;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ref.read(classroomDetailPageViewModel(widget.classroomId).notifier).loadClassroomDetails(widget.classroomId);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final classroomDetails = ref.watch(classroomDetailPageViewModel(widget.classroomId));

    return Scaffold(
      appBar: AppBar(
        title: Text(classroomDetails.value?.classroom.name ?? 'Classroom Details'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => {
                //TODO: Implement the editing of classroom details
              },
              icon: const Icon(Icons.edit_outlined)
          )
        ],
      ),
    );
  }
}