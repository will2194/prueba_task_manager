import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:prueba_task_manager/core/graph/graphql_client.dart';
import 'package:prueba_task_manager/fetures/countries/data/models/country_model.dart';

class CountryGraphqlDatasource {
  final _query = '''
    query {
      countries {
        code
        name
        capital
        emoji
      }
    }
  ''';

  Future<List<CountryModel>> fetchCountries() async {
    final result = await GraphQLService.client.query(
      QueryOptions(document: gql(_query)),
    );

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final List data = result.data?['countries'] ?? [];

    return data.map((json) => CountryModel.fromJson(json)).toList();
  }
}
