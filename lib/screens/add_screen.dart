
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_note_app/modal/note.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({ Key? key }) : super(key: key);

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
final _formKey = GlobalKey<FormState>();

XFile? _image;
String? title;
String? description;

getImage() async{
  final image = await ImagePicker.platform.getImage(source: ImageSource.camera);
  
  setState(() {
    _image = image;
  });
}

submitData() async {
  final isValid = _formKey.currentState!.validate();

  if (isValid) {
    Hive.box<Note>('note').add(Note(title, description, _image!.path));
    Navigator.of(context).pop();
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ADD NEW NOTE"),
        actions: [
          IconButton(
            onPressed: (){
              submitData();
            }, 
            icon: const Icon(Icons.save)
          )
        ],
      ),
      body: SafeArea(child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: const  InputDecoration(
                    hintText: "Enter note title"
                  ),
                  autofocus: false,
                  textInputAction: TextInputAction.next,
                  onChanged: (val){
                    setState(() {
                      title = val;
                    });
                  },
                ),
                TextFormField(
                  decoration: const  InputDecoration(
                    hintText: "Enter note description"
                  ),
                  autofocus: false,
                  minLines: 2,
                  maxLines: 15,
                  onChanged: (val){
                    setState(() {
                      description = val;
                    });
                  },
                ),
                SizedBox(height: 25,),
          
                _image == null ? Container() : Image.file(File(_image!.path))
              ],
            ),
          ),
        )
      )),
      floatingActionButton: FloatingActionButton(onPressed: getImage, child: const Icon(Icons.add_a_photo),)
    );
  }
}