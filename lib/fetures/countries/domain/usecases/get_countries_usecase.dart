import 'package:prueba_task_manager/fetures/countries/domain/entities/country.dart';
import 'package:prueba_task_manager/fetures/countries/domain/repositories/country_repository.dart';

class GetCountriesUseCase {
  final CountryRepository repository;

  GetCountriesUseCase(this.repository);

  Future<List<Country>> call() => repository.getCountries();
}
