import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueba_task_manager/fetures/countries/domain/entities/country.dart';
import 'package:prueba_task_manager/fetures/countries/domain/usecases/get_countries_usecase.dart';

class CountryViewModel extends StateNotifier<AsyncValue<List<Country>>> {
  final GetCountriesUseCase useCase;

  CountryViewModel(this.useCase) : super(const AsyncLoading()) {
    loadCountries();
  }

  Future<void> loadCountries() async {
    state = const AsyncLoading();
    try {
      final countries = await useCase();
      state = AsyncData(countries);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
