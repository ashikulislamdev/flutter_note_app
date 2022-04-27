import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';

class ViewNoteScreen extends StatelessWidget {
  final String? title;
  final String? description;
  final String? imageUrl;
  const ViewNoteScreen({
    Key? key,
    required this.title,
    required this.description,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: SafeArea(child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(description!, style: const TextStyle(fontSize: 25),),
              const SizedBox(height: 20,),
              Image.file(File(imageUrl!))
            ],
          ),
        )
      )),
    );
  }
}
