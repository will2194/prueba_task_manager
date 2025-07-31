import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:prueba_task_manager/fetures/countries/domain/entities/country.dart';
import 'package:prueba_task_manager/fetures/countries/domain/repositories/country_repository.dart';
import 'package:prueba_task_manager/fetures/countries/domain/usecases/get_countries_usecase.dart';
import 'package:prueba_task_manager/fetures/countries/ui/provider.dart';
import 'package:prueba_task_manager/fetures/countries/ui/viewmodels/country_view_model.dart';
import 'package:prueba_task_manager/fetures/countries/ui/views/country_view.dart';

class MockCountryRepository extends Mock implements CountryRepository {}

void main() {
  testWidgets('debe mostrar listado de países', (tester) async {
    // Arrange
    final repo = MockCountryRepository();
    final useCase = GetCountriesUseCase(repo);

    when(() => repo.getCountries()).thenAnswer(
      (_) async => [
        Country(code: 'MX', name: 'México', emoji: '', capital: 'CDMX'),
        Country(code: 'PE', name: 'Perú', emoji: '', capital: 'Lima'),
      ],
    );

    final viewModel = CountryViewModel(useCase);

    // Act
    await tester.pumpWidget(
      ProviderScope(
        overrides: [countryViewModelProvider.overrideWith((ref) => viewModel)],
        child: const MaterialApp(home: CountryView()),
      ),
    );

    await tester.pumpAndSettle();

    // Assert
    expect(find.text('México (MX)'), findsOneWidget);
    expect(find.text('Perú (PE)'), findsOneWidget);

    expect(find.text('CDMX'), findsOneWidget);
    expect(find.text('Lima'), findsOneWidget);
  });
}
