import 'package:injectable/injectable.dart';

import 'package:seatly/domain/configuration/sortingOptions/different_sorting_options.dart';
import 'package:seatly/repository/sorting/i_sorting_repository.dart';
import 'package:seatly/service/sorting/i_sorting_service.dart';

@Singleton(as : IDifferentSortingOptionsService)
class DifferentSortingOptionsService implements IDifferentSortingOptionsService {
  final IDifferentSortingOptionsRepository _differentSortingOptionsRepository;

  DifferentSortingOptionsService(this._differentSortingOptionsRepository);

  @override
  Future<void> changeDifferentSortingOptions(DifferentSortingOptions differentSortingOptions) {
    // TODO: implement changeDifferentSortingOptions
    throw UnimplementedError();
  }

  @override
  Future<DifferentSortingOptions?> getDifferentSortingOptions() {
    // TODO: implement getDifferentSortingOptions
    throw UnimplementedError();
  }

  @override
  Future<void> initializeDifferentSortingOptions(DifferentSortingOptions differentSortingOptions) {
    // TODO: implement initializeDifferentSortingOptions
    throw UnimplementedError();
  }
}