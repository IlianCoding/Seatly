import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:seatly/ui/providers/viewmodel_providers.dart';
import 'package:seatly/ui/screen/home_screen.dart';

class AddSpecialUShapeDetailsWidget extends HookConsumerWidget {
  final String label;
  final String secondLabel;
  final String path;
  final Color color;

  const AddSpecialUShapeDetailsWidget({super.key, required this.label, required this.secondLabel, required this.path, required this.color});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(classroomAddPageViewModel.notifier);
    final rowCount = useState(viewModel.getRowCount());
    final deskAmount = useState(viewModel.getSpecialDeskCount());

    void showSuccessNotification(bool success) {
      if(success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.addClassroomSuccess),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.addClassroomUnsuccessful),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: color,
          leading: IconButton(
              onPressed: () {
                viewModel.reset();
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
                  colors: [color, Colors.white]
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
                  child: Image.asset(path, fit: BoxFit.contain, width: 100, height: 100)
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
                                          Text(label, style: const TextStyle(fontSize: 18)),
                                          const SizedBox(height: 10),
                                          Text('${deskAmount.value?.toInt() ?? 0}', style: const TextStyle(fontSize: 14)),
                                          Slider(
                                              value: deskAmount.value ?? 0.0,
                                              min: 0,
                                              max: 15,
                                              label: deskAmount.value?.toInt().toString(),
                                              activeColor: color.withOpacity(0.8),
                                              inactiveColor: color.withOpacity(0.5),
                                              onChanged: (value) {
                                                deskAmount.value = value;
                                              }
                                          ),
                                          const SizedBox(height: 20),
                                          Text(secondLabel, style: const TextStyle(fontSize: 18)),
                                          const SizedBox(height: 10),
                                          Text('${rowCount.value?.toInt() ?? 0}', style: const TextStyle(fontSize: 14)),
                                          Slider(
                                              value: rowCount.value ?? 0.0,
                                              min: 0,
                                              max: useState(viewModel.getDeskCount()).value!.toDouble(),
                                              label: rowCount.value?.toInt().toString(),
                                              activeColor: color.withOpacity(0.8),
                                              inactiveColor: color.withOpacity(0.5),
                                              onChanged: (value) {
                                                rowCount.value = value;
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
                              onPressed: () async {
                                viewModel.setSpecialDeskCount(deskAmount.value?.toInt() ?? 0);
                                viewModel.setRowCount(rowCount.value?.toInt() ?? 0);
                                bool succesFullSave = await viewModel.addClassroom();

                                if(succesFullSave) {
                                  showSuccessNotification(true);
                                } else {
                                  showSuccessNotification(false);
                                }

                                Navigator.pushAndRemoveUntil(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation, secondaryAnimation) => const HomeScreen(),
                                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                      const begin = Offset(1.0, 0.0);
                                      const end = Offset.zero;
                                      const curve = Curves.ease;

                                      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                                      var offsetAnimation = animation.drive(tween);

                                      return SlideTransition(position: offsetAnimation, child: child);
                                    },
                                  ), (route) => false
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                                  backgroundColor: color,
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