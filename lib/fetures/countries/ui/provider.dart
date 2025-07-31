import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueba_task_manager/fetures/countries/data/datasources/country_graphql_datasource.dart';
import 'package:prueba_task_manager/fetures/countries/data/repositories/country_repository_impl.dart';
import 'package:prueba_task_manager/fetures/countries/domain/entities/country.dart';
import 'package:prueba_task_manager/fetures/countries/domain/usecases/get_countries_usecase.dart';
import 'package:prueba_task_manager/fetures/countries/ui/viewmodels/country_view_model.dart';

final countryViewModelProvider =
    StateNotifierProvider<CountryViewModel, AsyncValue<List<Country>>>((ref) {
      final datasource = CountryGraphqlDatasource();
      final repository = CountryRepositoryImpl(datasource);
      final useCase = GetCountriesUseCase(repository);

      return CountryViewModel(useCase);
    });
