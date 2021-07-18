import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:untitled/utils/graphql.dart';

const String queryCountries = """
query countries {
  countries{
    items{
      id
      code
      name
    }
  }
}
""";

Future<QueryResult> getCountries() async{
  return await graphqlClient.query(QueryOptions(document: gql(queryCountries)));
}