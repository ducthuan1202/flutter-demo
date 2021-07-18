import 'package:flutter/material.dart';
import 'package:untitled/story/partials/form.dart';

class StoryCreateScreen extends StatefulWidget {
  const StoryCreateScreen({Key? key}) : super(key: key);

  @override
  _StoryCreateScreenState createState() => _StoryCreateScreenState();
}

class _StoryCreateScreenState extends State<StoryCreateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Story'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: StoryForm(),
      ),
    );
  }
}
