import 'package:json_annotation/json_annotation.dart';

import 'package:seatly/domain/configuration/sortingOptions/sorting_option.dart';

part 'different_sorting_options.g.dart';

@JsonSerializable()
class DifferentSortingOptions {
  @JsonKey()
  final List<SortingOption> selectedOptions;

  DifferentSortingOptions({List<SortingOption>? selectedOptions})
      : selectedOptions = selectedOptions ?? [
    SortingOption.avoidSameNationality,
    SortingOption.avoidAdjacentRepetition,
    SortingOption.avoidSamePlaceRepetition,
  ];

  factory DifferentSortingOptions.fromJson(Map<String, dynamic> json) =>
      _$DifferentSortingOptionsFromJson(json);

  Map<String, dynamic> toJson() => _$DifferentSortingOptionsToJson(this);
}