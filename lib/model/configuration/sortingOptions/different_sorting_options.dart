import 'sorting_option.dart';

class DifferentSortingOptions {
  final List<SortingOption> selectedOptions;

  DifferentSortingOptions({List<SortingOption>? selectedOptions})
      : selectedOptions = selectedOptions ?? [
    SortingOption.avoidSameNationality,
    SortingOption.avoidAdjacentRepetition,
    SortingOption.avoidSamePlaceRepetition,
  ];
}