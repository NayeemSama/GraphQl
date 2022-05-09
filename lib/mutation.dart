import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class Mutationpage extends StatefulWidget {
  const Mutationpage({Key? key}) : super(key: key);

  @override
  _MutationState createState() => _MutationState();
}

var spaceXMutation = """ mutation {
  insert_users(objects: {name: "nayeem46547"}) {
    affected_rows
    returning {
      name
    }
  }
}""";

var spM = r'''mutation Mutation($name:String!) {
  insert_users(objects:[{name:$name}]) {
    affected_rows returning {
      name
    }
  }
}''';

class _MutationState extends State<Mutationpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mutation'),
      ),
      body: Mutation(
        options: MutationOptions(
          document: gql(spM),
          update: (GraphQLDataProxy cache, QueryResult? result) {
            return cache;
          },
          onCompleted: (dynamic resultData) {
          },
        ),
        builder: (
          RunMutation runMutation,
          QueryResult? result,
        ) {
          return FlatButton(
              onPressed: () {
                runMutation({
                  'name': "nayeem11446541",
                });
                print('result');
                print(result);
              },
              child: const Text('Add Counter')
          );
        },
      ),
    );
  }
}
