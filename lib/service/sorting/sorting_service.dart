import 'package:injectable/injectable.dart';

import 'package:seatly/domain/configuration/sortingOptions/different_sorting_options.dart';
import 'package:seatly/repository/sorting/i_sorting_repository.dart';
import 'package:seatly/service/sorting/i_sorting_service.dart';

@Singleton(as : IDifferentSortingOptionsService)
class DifferentSortingOptionsService implements IDifferentSortingOptionsService {
  final IDifferentSortingOptionsRepository _differentSortingOptionsRepository;

  DifferentSortingOptionsService(this._differentSortingOptionsRepository);

  @override
  Future<void> changeDifferentSortingOptions(DifferentSortingOptions differentSortingOptions) async {
    try {
      await _differentSortingOptionsRepository.updateDifferentSortingOptions(differentSortingOptions);
    } catch (e) {
      throw Exception('Error updating different sorting options: $e');
    }
  }

  @override
  Future<DifferentSortingOptions?> getDifferentSortingOptions() async {
    try {
      return await _differentSortingOptionsRepository.readDifferentSortingOptions();
    } catch (e) {
      throw Exception('Error reading different sorting options: $e');
    }
  }

  @override
  Future<void> initializeDifferentSortingOptions(DifferentSortingOptions differentSortingOptions) async {
    try {
      DifferentSortingOptions? existingOptions = await _differentSortingOptionsRepository.readDifferentSortingOptions();

      if (existingOptions == null) {
        await _differentSortingOptionsRepository.initializeDifferentSortingOptions(differentSortingOptions);
      }
    } catch (e) {
      throw Exception('Error initializing different sorting options: $e');
    }
  }
}