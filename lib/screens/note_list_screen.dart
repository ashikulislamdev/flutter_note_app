import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_note_app/modal/note.dart';
import 'package:flutter_note_app/screens/add_screen.dart';
import 'package:flutter_note_app/screens/view_note_screen.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class NoteListScreen extends StatefulWidget {
  const NoteListScreen({ Key? key }) : super(key: key);

  @override
  State<NoteListScreen> createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("RS Note"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20, top: 20),
            child: Text(Hive.box<Note>('note').length.toString() + " Notes", style: const TextStyle(fontSize: 22),),
          )
        ],
      ),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: Hive.box<Note>('note').listenable(), 
          builder: (context, Box<Note> box, _){
            return ListView.builder(
              itemCount: box.length,
              itemBuilder: (ctx, i){
                final note = box.getAt(i);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ViewNoteScreen(title: note!.title, description: note.description, imageUrl: note.imageUrl)));
                        },
                        leading: IconButton(
                          onPressed: (){
                            box.deleteAt(i);
                          }, 
                          icon: const Icon(Icons.delete_forever)
                        ),
                        title: Text(note!.title.toString()),
                        subtitle: Text(note.description.toString()),
                        trailing: Image.file(File(note.imageUrl.toString())),
                      ),
                    ),
                  ),
                );
              }
            );
          }
        )
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddNoteScreen()));
        }, 
        label: const Text("+ | Add Note")
      ),
    );
  }
}