import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final GraphQLClient graphqlClient = GraphQLClient(
    link: HttpLink(dotenv.env['API_GRAPHQL_ENDPOINT'].toString()),
    cache: GraphQLCache(store: InMemoryStore()),
);

final ValueNotifier<GraphQLClient> graphqlValueNotifier = ValueNotifier(graphqlClient);

