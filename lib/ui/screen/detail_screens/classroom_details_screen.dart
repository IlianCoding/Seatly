import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import 'package:seatly/ui/widget/classroom_detail/classroom_detail_student_card.dart';
import 'package:seatly/domain/configuration/layoutType/layout_type.dart';
import 'package:seatly/ui/widget/info/info_description_coachmark.dart';
import 'package:seatly/ui/providers/viewmodel_providers.dart';
import 'package:seatly/ui/widget/classroom_detail/classroom_detail_general_info_card.dart';
import 'package:seatly/ui/widget/delete_confirmation_dialog.dart';

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

  GlobalKey startShufflingKey = GlobalKey();
  GlobalKey editingButtonKey = GlobalKey();
  GlobalKey importButtonKey = GlobalKey();
  GlobalKey searchFieldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    searchController.addListener(() {
      ref
          .read(searchStudentQueryProvider.notifier)
          .state =
          searchController.text;
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void initTargets() {
    targets.add(
      TargetFocus(
        identify: "ImportButton",
        keyTarget: importButtonKey,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return InfoDescription(
                description: AppLocalizations.of(context)!.importButtonIntro,
                skipButtonText: AppLocalizations.of(context)!.skip,
                nextButtonText: AppLocalizations.of(context)!.next,
                onNext: () => controller.next(),
                onSkip: () => controller.skip(),
              );
            },
          ),
        ],
      ),
    );
    targets.add(
      TargetFocus(
        identify: "AddButton",
        keyTarget: startShufflingKey,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return InfoDescription(
                description: AppLocalizations.of(context)!.addButtonIntro,
                skipButtonText: AppLocalizations.of(context)!.skip,
                nextButtonText: AppLocalizations.of(context)!.next,
                onNext: () => controller.next(),
                onSkip: () => controller.skip(),
              );
            },
          ),
        ],
      ),
    );
    targets.add(
      TargetFocus(
        identify: "SettingsButton",
        keyTarget: editingButtonKey,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return InfoDescription(
                description: AppLocalizations.of(context)!.settingsButtonIntro,
                skipButtonText: AppLocalizations.of(context)!.skip,
                nextButtonText: AppLocalizations.of(context)!.next,
                onNext: () => controller.next(),
                onSkip: () => controller.skip(),
              );
            },
          ),
        ],
      ),
    );
    targets.add(
      TargetFocus(
        identify: "SearchField",
        keyTarget: searchFieldKey,
        shape: ShapeLightFocus.RRect,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return InfoDescription(
                description: AppLocalizations.of(context)!.searchBarFieldIntro,
                skipButtonText: AppLocalizations.of(context)!.skip,
                nextButtonText: AppLocalizations.of(context)!.next,
                onNext: () => controller.next(),
                onSkip: () => controller.skip(),
              );
            },
          ),
        ],
      ),
    );
  }

  void showInfoCoachMark() {
    initTargets();
    tutorialCoachMark = TutorialCoachMark(
      targets: targets,
      colorShadow: Colors.black,
    )
      ..show(context: context);
  }

  @override
  Widget build(BuildContext context) {
    final classroomDetailsAsyncValue = ref.watch(classroomDetailPageViewModel(widget.classroomId));
    final searchQuery = ref.watch(searchStudentQueryProvider);

    Map<String, dynamic> layoutTypeDetails = (() {
      switch (classroomDetailsAsyncValue.value?.classroom!.layoutType) {
        case LayoutType.rowByRow:
          return {
            'image': 'assets/images/rowbyrow.png',
            'color': Colors.orange.shade100,
            'darkColor': Colors.orange.shade400,
            'layouttype': AppLocalizations.of(context)!.rowbyrow
          };
        case LayoutType.groupedLayout:
          return {
            'image': 'assets/images/grouped.png',
            'color': Colors.red.shade100,
            'darkColor': Colors.red.shade400,
            'layouttype': AppLocalizations.of(context)!.grouped
          };
        case LayoutType.labLayout:
          return {
            'image': 'assets/images/laboratory.png',
            'color': Colors.green.shade100,
            'darkColor': Colors.green.shade400,
            'layouttype': AppLocalizations.of(context)!.laboratory
          };
        case LayoutType.uShape:
          return {
            'image': 'assets/images/uShape.png',
            'color': Colors.purple.shade100,
            'darkColor': Colors.purple.shade400,
            'layouttype': AppLocalizations.of(context)!.ushape
          };
        case LayoutType.specialUShape:
          return {
            'image': 'assets/images/specialUShape.png',
            'color': Colors.blue.shade100,
            'darkColor': Colors.blue.shade400,
            'layouttype': AppLocalizations.of(context)!.specialushape
          };
        default:
          return {
            'image': 'assets/images/rowbyrow.png',
            'color': Colors.orange.shade100,
            'darkColor': Colors.orange.shade400,
            'layouttype': AppLocalizations.of(context)!.rowbyrow
          };
      }
    })();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: layoutTypeDetails['color'],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            onPressed: () => showInfoCoachMark(),
            icon: const Icon(Icons.info_outline_rounded),
          ),
          const SizedBox(width: 16)
        ],
      ),
      body: classroomDetailsAsyncValue.when(
        data: (classroomDetails) {
          final students = classroomDetails.students?.where((student) {
            return student.fullName.toLowerCase().contains(searchQuery.toLowerCase());
          }).toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: layoutTypeDetails['color'],
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                ),
                padding: const EdgeInsets.only(bottom: 32, left: 48, right: 48, top: 16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: layoutTypeDetails['color'],
                      child: Image.asset(layoutTypeDetails['image'], width: 65, height: 65),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            classroomDetails.classroom?.name ?? 'Classroom Details',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            layoutTypeDetails['layouttype'],
                            style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.classroomDetails,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ClassroomDetailGeneralInfoCard(
                          color: Colors.redAccent,
                          icon: const Icon(Icons.desk_outlined, color: Colors.redAccent),
                          title: AppLocalizations.of(context)!.totalDesks,
                          explanation: classroomDetails.classroom?.desks.length.toString() ?? '0',
                        ),
                        const SizedBox(height: 16),
                        GestureDetector(
                          onTap: () {
                            // TODO: Add functionality to view the current layout of the classroom
                          },
                          child: ClassroomDetailGeneralInfoCard(
                            color: Colors.orangeAccent,
                            icon: const Icon(Icons.window_outlined, color: Colors.orangeAccent),
                            title: AppLocalizations.of(context)!.layoutView,
                            explanation: AppLocalizations.of(context)!.layoutViewDescription,
                          ),
                        ),
                        const SizedBox(height: 16),
                        GestureDetector(
                          onTap: () {
                            // TODO: Add functionality to seat the students
                          },
                          child: ClassroomDetailGeneralInfoCard(
                            color: Colors.blueAccent,
                            icon: const Icon(Icons.play_circle_outline, color: Colors.blueAccent),
                            title: AppLocalizations.of(context)!.seatStudents,
                            explanation: AppLocalizations.of(context)!.seatStudentsDescription,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.studentList,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 35,
                              child: TextField(
                                key: searchFieldKey,
                                controller: searchController,
                                decoration: InputDecoration(
                                  labelText: AppLocalizations.of(context)!.searchBarStudent,
                                  prefixIcon: const Icon(Icons.search),
                                  border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          IconButton(
                            icon: const Icon(Icons.add_circle_outline_outlined),
                            onPressed: () {
                              // TODO: Add functionality to add a student
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: students?.length ?? 0,
                  itemBuilder: (context, index) {
                    final student = students?[index];
                    return Slidable(
                      key: ValueKey(student?.id),
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              _showDeleteConfirmationDialog(context, ref, student!.id);
                            },
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            icon: Icons.delete_forever,
                            label: AppLocalizations.of(context)!.delete,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 38.0, vertical: 8.0),
                        child: StudentCard(
                          studentName: student!.fullName,
                          birthDate: "${student.birthDate.day}-${student.birthDate.month}-${student.birthDate.year}",
                          imageUri: 'assets/images/empty_portrait.png',
                          color: layoutTypeDetails['color'],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }

    void _showDeleteConfirmationDialog(BuildContext context, WidgetRef ref, String studentId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DeleteConfirmationDialog(
          title: AppLocalizations.of(context)!.deleteDialogTitleStudent,
          content: AppLocalizations.of(context)!.deleteDialogContentStudent,
          onConfirm: () {
            ref.read(classroomDetailPageViewModel(widget.classroomId).notifier)
                .deleteStudentFromClassroom(studentId);
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}