import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seatly/ui/viewmodel/providers/viewmodel_providers.dart';

class ClassroomDetailScreen extends ConsumerWidget {
  final String classroomId;

  const ClassroomDetailScreen({super.key, required this.classroomId});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final classroomDetails = ref.watch(classroomDetailPageViewModel(classroomId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Classroom Details'),
        centerTitle: true,
      ),
    );
  }
}