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
  Future<DifferentSortingOptions?> readDifferentSortingOptions() async {
    final file = await _jsonWriteRead.getFile(fileName);
    final data = await _jsonWriteRead.readDataFromFile(file);
    final differentSortingOptions = _parseDifferentSortingOptions(data);

    return differentSortingOptions.firstOrNull;
  }

  @override
  Future<void> updateDifferentSortingOptions(DifferentSortingOptions differentSortingOptions) async {
    final file = await _jsonWriteRead.getFile(fileName);
    final data = await _jsonWriteRead.readDataFromFile(file);

    if (!data.containsKey('differentSortingOptions') ||
        data['differentSortingOptions'] is! List) {
      data['differentSortingOptions'] = [];
    }

    data['differentSortingOptions'] = [differentSortingOptions.toJson()];
    await _jsonWriteRead.writeDataToFile(file, data);
  }

  @override
  Future<void> initializeDifferentSortingOptions(DifferentSortingOptions differentSortingOptions) async {
    final file = await _jsonWriteRead.getFile(fileName);
    final data = await _jsonWriteRead.readDataFromFile(file);

    if (!data.containsKey('differentSortingOptions') ||
        data['differentSortingOptions'] is! List) {
      data['differentSortingOptions'] = [];
    }

    data['differentSortingOptions'].add(differentSortingOptions.toJson());
    await _jsonWriteRead.writeDataToFile(file, data);
  }

  List<DifferentSortingOptions> _parseDifferentSortingOptions(Map<String, dynamic> data) {
    final differentSortingOptionsJson = data['differentSortingOptions'] as List<dynamic>?;
    if(differentSortingOptionsJson == null) {
      return [];
    }
    return differentSortingOptionsJson.map((e) => DifferentSortingOptions.fromJson(e as Map<String, dynamic>)).toList();
  }
}