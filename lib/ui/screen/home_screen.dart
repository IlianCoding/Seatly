import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:seatly/ui/providers/viewmodel_providers.dart';

import 'package:seatly/ui/screen/classroom_details_screen.dart';
import 'package:seatly/ui/screen/settings_screen.dart';
import 'package:seatly/ui/widget/classroom_card_widget.dart';
import 'package:seatly/ui/widget/delete_confirmation_dialog.dart';
import 'package:seatly/ui/widget/info/info_description_coachmark.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TutorialCoachMark? tutorialCoachMark;
    List<TargetFocus> targets = [];

    GlobalKey addButtonKey = GlobalKey();
    GlobalKey settingsButtonKey = GlobalKey();
    GlobalKey importButtonKey = GlobalKey();
    GlobalKey searchFieldKey = GlobalKey();

    final classrooms = ref.watch(classroomHomepageViewModel);
    final searchQuery = ref.watch(searchQueryProvider);
    final searchController = useTextEditingController(text: searchQuery);

    void initTargets(){
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
                          onSkip: () => controller.skip()
                      );
                    }
                )
              ]
          )
      );
      targets.add(
        TargetFocus(
          identify: "AddButton",
          keyTarget: addButtonKey,
          contents: [
            TargetContent(
              align: ContentAlign.top,
              builder: (context, controller) {
                return InfoDescription(
                    description: AppLocalizations.of(context)!.addButtonIntro,
                    skipButtonText: AppLocalizations.of(context)!.skip,
                    nextButtonText: AppLocalizations.of(context)!.next,
                    onNext: () => controller.next(),
                    onSkip: () => controller.skip()
                );
              }
            )
          ]
        )
      );
      targets.add(
          TargetFocus(
              identify: "SettingsButton",
              keyTarget: settingsButtonKey,
              contents: [
                TargetContent(
                    align: ContentAlign.top,
                    builder: (context, controller) {
                      return InfoDescription(
                          description: AppLocalizations.of(context)!.settingsButtonIntro,
                          skipButtonText: AppLocalizations.of(context)!.skip,
                          nextButtonText: AppLocalizations.of(context)!.next,
                          onNext: () => controller.next(),
                          onSkip: () => controller.skip()
                      );
                    }
                )
              ]
          )
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
                          onSkip: () => controller.skip()
                      );
                    }
                )
              ]
          )
      );
    }

    void showInfoCoachMark(){
      initTargets();
      tutorialCoachMark = TutorialCoachMark(
          targets: targets,
          colorShadow: Colors.black
      )..show(context: context);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.home),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline_rounded),
            onPressed: () => showInfoCoachMark(),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              key: searchFieldKey,
              controller: searchController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.searchBar,
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
              onChanged: (value) {
                ref.read(searchQueryProvider.notifier).state = value;
              },
            ),
          ),
          Expanded(
            child: classrooms.when(
                data: (classrooms) {
                  final filteredClassrooms = classrooms.where((classroom) {
                    return classroom.name
                        .toLowerCase()
                        .contains(searchQuery.toLowerCase());
                  }).toList();

                  return ListView.builder(
                    itemCount: filteredClassrooms.length,
                    itemBuilder: (context, index) {
                      final classroom = filteredClassrooms[index];
                      return Slidable(
                          key: ValueKey(classroom.id),
                          endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    _showDeleteConfirmationDialog(
                                        context, ref, classroom.id);
                                  },
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete_forever,
                                  label: AppLocalizations.of(context)!.delete,
                                )
                              ]),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ClassroomDetailScreen(
                                              classroomId: classroom.id
                                          )
                                  )
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              child: ClassroomCard(classroom: classroom),
                            ),
                          )
                      );
                    },
                  );
                },
                error: (error, stack) => Center(child: Text('Error: $error')),
                loading: () =>
                    const Center(child: CircularProgressIndicator()
                    )
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 8.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    key: importButtonKey,
                    onPressed: () => {
                          //TODO: Add Importing window
                        },
                    icon: const Icon(Icons.file_download_outlined, size: 30)
                ),
                FloatingActionButton(
                  key: addButtonKey,
                  onPressed: () {},
                  backgroundColor: Colors.purple[100],
                  child:
                      Icon(Icons.add_circle, color: Colors.grey[800], size: 40),
                ),
                IconButton(
                    key: settingsButtonKey,
                    onPressed: () => {
                          Navigator.push(
                              context, 
                              MaterialPageRoute(builder: (context) => const SettingsScreen())
                          )
                        },
                    icon: const Icon(
                      Icons.settings,
                      size: 30,
                    )
                )
              ],
            ),
          )),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, WidgetRef ref, String classroomId) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return DeleteConfirmationDialog(
              title: AppLocalizations.of(context)!.deleteDialogTitleClassroom,
              content: AppLocalizations.of(context)!.deleteDialogContentClassroom,
              onConfirm: () {
                ref
                    .read(classroomHomepageViewModel.notifier)
                    .deleteClassroom(classroomId);
                Navigator.of(context).pop();
              });
        });
  }
}