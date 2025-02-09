import 'package:seatly/domain/configuration/sortingOptions/different_sorting_options.dart';

abstract class IDifferentSortingOptionsRepository{
  Future<DifferentSortingOptions?> readDifferentSortingOptions();

  Future<void> updateDifferentSortingOptions(DifferentSortingOptions differentSortingOptions);

  Future<void> initializeDifferentSortingOptions(DifferentSortingOptions differentSortingOptions);
}