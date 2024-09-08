import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum LayoutType {
  rowByRow,
  uShape,
  specialUShape,
  labLayout,
  groupedLayout
}