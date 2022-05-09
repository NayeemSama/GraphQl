import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphqlapp/mutation.dart';
import 'package:graphqlapp/utils/Routes.dart';

var productsGraphQL = """query products {
      products(first: 10, channel: "default-channel") {
        edges {
          node {
             id
             name
             description
             thumbnail {
                url
             }
          }
        }
      }
   }""";

var productsGraphQLMutation = """query mutation {
      star {
        edges {
          node {
             id
             name
             description
             thumbnail {
                url
             }
          }
        }
      }
   }""";

var spaceX = """query users {
      users {
        id
        name
        rocket
        twitter
      }
    }""";

var spaceXUser = """query users {
  users(where: {id: {_eq: "2fbd650c-8970-47a1-a453-4fed8f45e5f0"}}) {
    id
    name
    rocket
    twitter
    timestamp
  }
}""";

var hasura = """query users {
  users {
    id
    name
  }
}""";

var spaceXMutation = """ mutation {
  insert_users(objects: {name: "nayeem11111"}) {
    affected_rows
    returning {
      name
    }
  }
}""";

var spM =

r'''mutation Mutation($name:String!) {
  insert_users(objects:[{name:$name}]) {
    affected_rows returning {
      name
    }
  }
}''';

// https://demo.saleor.io/graphql/
// https://api.spacex.land/graphql/
// https://hasura.io/learn/graphql

void main() {
  final HttpLink httpLink = HttpLink("https://api.spacex.land/graphql/");

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(store: InMemoryStore()),
    ),
  );

  var app = GraphQLProvider(client: client, child: const MyApp());
  runApp(app);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
      initialRoute: Routes.mutaionRoute,
      routes: {
        Routes.homeRoute: (context) => Home(),
        Routes.mutaionRoute: (context) => Mutationpage()
      },
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GraphQL'),
      ),
      body: Query(
        options: QueryOptions(
          document: gql(spaceX),//EDIT HERE************************************************************************************************************************************
        ),
        builder: (QueryResult result, {fetchMore, refetch}) {
          if (result.hasException) {
            return Text(result.exception.toString());
          }
          if (result.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final productList = result;
          print(productList);
          return Container();
        },
      ),
    );
  }
}

// Query(
//         options: QueryOptions(
//           document: gql(hasura),//EDIT HERE************************************************************************************************************************************
//         ),
//         builder: (QueryResult result, {fetchMore, refetch}) {
//           if (result.hasException) {
//             return Text(result.exception.toString());
//           }
//           if (result.isLoading) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           final productList = result;
//           print(productList);
//           return Container();
//         },
//       ),
