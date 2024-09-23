import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:seatly/ui/screen/classroom_details_screen.dart';
import 'package:seatly/ui/viewmodel/providers/viewmodel_providers.dart';
import 'package:seatly/ui/widget/classroom_card_widget.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final classrooms = ref.watch(classroomHomepageViewModel);
    final searchQuery = ref.watch(searchQueryProvider);
    final searchController = useTextEditingController(text: searchQuery);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline_rounded),
            onPressed: () {
              //TODO: Add info dialog
            },
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                labelText: 'Search Classroom',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
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
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ClassroomDetailScreen(classroomId: classroom.id)
                              )
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          child: ClassroomCard(classroom: classroom),
                        ),
                      );
                    },
                  );
                },
                error: (error, stack) => Center(child: Text('Error: $error')),
                loading: () => const Center(child: CircularProgressIndicator())
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
                    onPressed: () => {},
                    icon: const Icon(Icons.file_download_outlined, size: 30)
                ),
                FloatingActionButton(
                  onPressed: () {},
                  backgroundColor: Colors.purple[100],
                  child: Icon(Icons.add_circle, color: Colors.grey[800], size: 40),
                ),
                IconButton(
                    onPressed: () => {},
                    icon: const Icon(Icons.settings, size: 30,)
                )
              ],
            ),
          )),
    );
  }
}