import 'package:flutter/material.dart';

class EditedScreen extends StatefulWidget {
  const EditedScreen({super.key});

  @override
  State<EditedScreen> createState() => _EditedScreenState();
}

class _EditedScreenState extends State<EditedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edited'),
      ),
    );
  }
}
