import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/features/notes/blocs/note_cubit/note_cubit.dart';
import 'package:notes_app/features/notes/pages/create_note_page.dart';
import 'package:notes_app/features/notes/use_cases/create_note.dart';
import 'package:notes_rest_service/notes_rest_service.dart';

///All routes in the app

Route<void> createNoteRoute() {
  return MaterialPageRoute(
    builder: (BuildContext context) => BlocProvider<NoteCubit>(
      create: (BuildContext context) => NoteCubit(
        createNote: CreateNote(
          FakeNotesRestService(),
        ),
      ),
      child: const CreateNotePage(),
    ),
  );
}
