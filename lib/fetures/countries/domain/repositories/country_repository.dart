import 'package:prueba_task_manager/fetures/countries/domain/entities/country.dart';

abstract class CountryRepository {
  Future<List<Country>> getCountries();
}
