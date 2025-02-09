import 'package:seatly/domain/configuration/sortingOptions/different_sorting_options.dart';

abstract class IDifferentSortingOptionsService {
  Future<DifferentSortingOptions?> getDifferentSortingOptions();
  Future<void> changeDifferentSortingOptions(DifferentSortingOptions differentSortingOptions);
  Future<void> initializeDifferentSortingOptions(DifferentSortingOptions differentSortingOptions);
}