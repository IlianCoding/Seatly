import 'package:json_annotation/json_annotation.dart';

enum SortingOption{
  @JsonValue('avoidSameNationality')
  avoidSameNationality,
  @JsonValue('avoidAdjacentRepetition')
  avoidAdjacentRepetition,
  @JsonValue('avoidSamePlaceRepetition')
  avoidSamePlaceRepetition
}