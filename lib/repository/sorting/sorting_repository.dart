import 'package:injectable/injectable.dart';

import 'package:seatly/core/utils/json_write_read.dart';
import 'package:seatly/domain/configuration/sortingOptions/different_sorting_options.dart';
import 'package:seatly/repository/sorting/i_sorting_repository.dart';

@Singleton(as : IDifferentSortingOptionsRepository)
class DifferentSortingOptionsRepository implements IDifferentSortingOptionsRepository {
  final String fileName = 'classroomSeperator.json';
  final JsonWriteRead _jsonWriteRead;

  DifferentSortingOptionsRepository({
    required JsonWriteRead jsonWriteRead,
  }) : _jsonWriteRead = jsonWriteRead;

  @override
  Future<DifferentSortingOptions?> readDifferentSortingOptions() {
    // TODO: implement readDifferentSortingOptions
    throw UnimplementedError();
  }

  @override
  Future<void> updateDifferentSortingOptions(DifferentSortingOptions differentSortingOptions) {
    // TODO: implement updateDifferentSortingOptions
    throw UnimplementedError();
  }

  @override
  Future<void> initializeDifferentSortingOptions() {
    // TODO: implement initializeDifferentSortingOptions
    throw UnimplementedError();
  }
}