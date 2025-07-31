import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:prueba_task_manager/fetures/countries/domain/entities/country.dart';
import 'package:prueba_task_manager/fetures/countries/domain/repositories/country_repository.dart';
import 'package:prueba_task_manager/fetures/countries/domain/usecases/get_countries_usecase.dart';

class MockCountryRepository extends Mock implements CountryRepository {}

void main() {
  late GetCountriesUseCase useCase;
  late MockCountryRepository mockRepository;

  setUp(() {
    mockRepository = MockCountryRepository();
    useCase = GetCountriesUseCase(mockRepository);
  });

  final mockCountries = [
    Country(code: 'MX', name: 'México', emoji: '', capital: 'CDMX'),
    Country(code: 'PE', name: 'Perú', emoji: '', capital: 'Lima'),
  ];

  test('debe retornar una lista de países', () async {
    // Arrange
    when(
      () => mockRepository.getCountries(),
    ).thenAnswer((_) async => mockCountries);

    // Act
    final result = await useCase();

    // Assert
    expect(result, mockCountries);
    verify(() => mockRepository.getCountries()).called(1);
  });

  test('debe lanzar excepción si falla', () async {
    // Arrange
    when(
      () => mockRepository.getCountries(),
    ).thenThrow(Exception('Error de conexión'));

    // Act & Assert
    expect(() => useCase(), throwsException);
    verify(() => mockRepository.getCountries()).called(1);
  });
}
