import 'package:prueba_task_manager/fetures/countries/data/datasources/country_graphql_datasource.dart';
import 'package:prueba_task_manager/fetures/countries/domain/entities/country.dart';
import 'package:prueba_task_manager/fetures/countries/domain/repositories/country_repository.dart';

class CountryRepositoryImpl implements CountryRepository {
  final CountryGraphqlDatasource datasource;

  CountryRepositoryImpl(this.datasource);

  @override
  Future<List<Country>> getCountries() => datasource.fetchCountries();
}
