import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueba_task_manager/fetures/countries/domain/entities/country.dart';
import 'package:prueba_task_manager/fetures/countries/domain/usecases/get_countries_usecase.dart';
import 'package:prueba_task_manager/fetures/countries/ui/viewmodels/country_view_model.dart';

class MockGetCountriesUseCase extends Mock implements GetCountriesUseCase {}

void main() {
  late MockGetCountriesUseCase mockUseCase;
  late CountryViewModel viewModel;

  final mockCountries = [
    Country(code: 'MX', name: 'México', emoji: '', capital: 'CDMX'),
    Country(code: 'PE', name: 'Perú', emoji: '', capital: 'Lima'),
  ];

  setUp(() {
    mockUseCase = MockGetCountriesUseCase();
    viewModel = CountryViewModel(mockUseCase);
  });

  test('debe cargar países correctamente', () async {
    when(() => mockUseCase()).thenAnswer((_) async => mockCountries);

    await viewModel.loadCountries();

    expect(viewModel.state.hasValue, true);
    expect(viewModel.state.value, mockCountries);
  });

  test('debe manejar errores al cargar', () async {
    when(() => mockUseCase()).thenThrow(Exception('Error GraphQL'));

    await viewModel.loadCountries();

    expect(viewModel.state.hasError, true);
  });
}
