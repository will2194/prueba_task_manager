import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:prueba_task_manager/core/values/string_values.dart';

class GraphQLService {
  static final HttpLink httpLink = HttpLink(apiBaseUrlGraphQl);

  static final GraphQLClient client = GraphQLClient(
    link: httpLink,
    cache: GraphQLCache(store: InMemoryStore()),
  );
}
