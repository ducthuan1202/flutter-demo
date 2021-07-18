import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:untitled/constants.dart';
import 'package:untitled/screens/story/create.dart';
import 'package:untitled/utils/graphql.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load(fileName: '.env');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return GraphQLProvider(
      client: graphqlValueNotifier,

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Welcome to Flutter',
        home: StoryCreateScreen(),
        theme: ThemeData(
          inputDecorationTheme: InputDecorationTheme(

            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: formFocusedBorderColor),
              borderRadius: BorderRadius.circular(formBorderRadius),
            ),

            enabledBorder:OutlineInputBorder(
              borderSide: BorderSide(color: formEnabledBorderColor),
              borderRadius: BorderRadius.circular(formBorderRadius),
            ),

            errorBorder:OutlineInputBorder(
              borderSide: BorderSide(color: formErrorBorderColor),
              borderRadius: BorderRadius.circular(formBorderRadius),
            ),

            focusedErrorBorder:OutlineInputBorder(
              borderSide: BorderSide(color: formFocusedErrorBorderColor),
              borderRadius: BorderRadius.circular(formBorderRadius),
            ),
          ),
        ),

      ),
    );
  }

}
