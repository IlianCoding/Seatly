import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ionicons/ionicons.dart';
import 'package:seatly/domain/classroom.dart';
import 'package:seatly/domain/configuration/layoutType/layout_type.dart';

import 'package:seatly/ui/providers/viewmodel_providers.dart';
import 'package:seatly/ui/screen/add_screens/add_classroom_layout_type.dart';

class AddClassroomNameScreen extends HookConsumerWidget {
  const AddClassroomNameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(classroomAddPageViewModel.notifier);
    final nameController = useTextEditingController();
    final deskCount = useState(viewModel.getDeskCount());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade200,
        leading: IconButton(
            onPressed: () {
              viewModel.reset((state) => Classroom(
                  id: 'dummy',
                  name: 'dummy',
                  layoutType: LayoutType.rowByRow,
                  desks: [],
                  studentIds: []
              ));
              Navigator.pop(context);
            }, 
            icon: const Icon(Icons.arrow_back_ios)
        ),
      ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.purple.shade200, Colors.white]
              )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: 120,
                  height: 120,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle
                  ),
                  child: Icon(Ionicons.book_outline, size: 80, color: Colors.purple.shade200)
              ),
              const SizedBox(height: 50),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Card(
                        elevation: 18,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                    AppLocalizations.of(context)!.addClassroomDetails,
                                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)
                                ),
                                const SizedBox(height: 20),
                                TextField(
                                  controller: nameController,
                                  decoration: InputDecoration(
                                      labelText: AppLocalizations.of(context)!.addClassroomName,
                                      border: const OutlineInputBorder()
                                  ),
                                ),
                                const SizedBox(height: 40),
                                Card(
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(AppLocalizations.of(context)!.addClassroomTotalDesks, style: const TextStyle(fontSize: 18)),
                                        const SizedBox(height: 10),
                                        Text('${deskCount.value.toInt()}', style: const TextStyle(fontSize: 14)),
                                        Slider(
                                            value: deskCount.value,
                                            min: 0,
                                            max: 50,
                                            label: deskCount.value.toInt().toString(),
                                            activeColor: Colors.purple.shade200,
                                            inactiveColor: Colors.purple.shade100,
                                            onChanged: (value) {
                                              deskCount.value = value;
                                            }
                                        ),
                                      ],
                                    )
                                  ),
                                ),
                                const SizedBox(height: 40),
                              ],
                            )
                        ),
                      ),
                      Positioned(
                        bottom: -20,
                        left: 50,
                        right: 50,
                        child: SizedBox(
                          width: 150,
                          height: 50,
                          child: ElevatedButton(
                              onPressed: () {
                                viewModel.setClassroomName(nameController.text);
                                viewModel.setDeskCount(deskCount.value.toInt());

                                Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                        pageBuilder: (context, animation, secondaryAnimation) => const AddClassroomLayoutTypeScreen(),
                                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                          const begin = Offset(1.0, 0.0);
                                          const end = Offset.zero;
                                          const curve = Curves.ease;

                                          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                                          var offsetAnimation = animation.drive(tween);

                                          return SlideTransition(position: offsetAnimation, child: child);
                                        }
                                    )
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                                  backgroundColor: Colors.purple.shade200,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                                  elevation: 12.0,
                                  shadowColor: Colors.black.withOpacity(0.9)
                              ),
                              child: Center(
                                child: Text(AppLocalizations.of(context)!.next, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                              )
                          ),
                        ),
                      )
                    ],
                  )
              )
            ],
          ),
        )
    );
  }
}