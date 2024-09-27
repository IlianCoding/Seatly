import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seatly/domain/configuration/layoutType/layout_type.dart';

class LayoutTypeNotifier extends StateNotifier<LayoutType?> {
  LayoutTypeNotifier() : super(null);

  void selectLayoutType(LayoutType layoutType) {
    state = layoutType;
  }
}

final layoutTypeProvider = StateNotifierProvider<LayoutTypeNotifier, LayoutType?>((ref) {
  return LayoutTypeNotifier();
});