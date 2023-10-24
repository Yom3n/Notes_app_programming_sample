import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/notes_cubit.dart';

class NotesFeedPage extends StatelessWidget {
  const NotesFeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes', style: Theme.of(context).textTheme.bodyMedium),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocBuilder<NotesCubit, NotesState>(
          builder: (context, notesState) {
            switch (notesState.status) {
              case NotesStatus.initial:
                return const Center(child: Text('Note not initialized'));
              case NotesStatus.loaded:
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final note = notesState.notes[index];
                    return Text(note.text);
                  },
                  itemCount: notesState.notes.length,
                );
              case NotesStatus.loading:
                return Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                );
              case NotesStatus.error:
                return Text(
                  notesState.noteErrorData?.noteErrorStatus?.toString() ??
                      'An error occurred while loading notes',
                );
            }
          },
        ),
      ),
    );
  }
}
