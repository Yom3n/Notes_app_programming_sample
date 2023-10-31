import 'package:flutter/material.dart';
import 'package:notes_app/features/notes/pages/create_note_page.dart';

///All routes in the app

Route<void> createNoteRoute() {
  return MaterialPageRoute(
      builder: (BuildContext context) => const CreateNotePage());
}
