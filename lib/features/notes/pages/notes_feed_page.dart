import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/ui/my_progress_indicator.dart';
import '../../../models/note.dart';
import '../blocs/notes_cubit.dart';

class NotesFeedPage extends StatelessWidget {
  const NotesFeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const AddNoteFab(),
      appBar: AppBar(
        title: Text('Notes', style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocBuilder<NotesCubit, NotesState>(
          builder: (context, notesState) {
            switch (notesState.status) {
              case NotesStatus.initial:
                return const Center(child: Text('Note not initialized'));
              case NotesStatus.loaded:
                return NotesFeedBody(
                  notes: notesState.notes,
                );
              case NotesStatus.loading:
                return const MyProgressIndicator();
              case NotesStatus.error:
                assert(
                  notesState.noteErrorData != null,
                  'Emitted error state without note error data!',
                );
                return NotesErrorBody(
                  noteErrorData: notesState.noteErrorData!,
                );
            }
          },
        ),
      ),
    );
  }
}

class NotesFeedBody extends StatelessWidget {
  const NotesFeedBody({super.key, required this.notes});

  final List<Note> notes;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final note = notes[index];
        return NoteItem(
          key: Key('list_note${note.id}'),
          note: note,
        );
      },
      itemCount: notes.length,
    );
  }
}

class NoteItem extends StatelessWidget {
  const NoteItem({super.key, required this.note});

  final Note note;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Material(
        elevation: 8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                note.text,
                style: Theme.of(context).textTheme.bodySmall,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NotesErrorBody extends StatelessWidget {
  const NotesErrorBody({super.key, required this.noteErrorData});

  final NoteErrorData noteErrorData;

  @override
  Widget build(BuildContext context) {
    return Text(
      noteErrorData.noteErrorStatus?.toString() ??
          'An error occurred while loading notes',
    );
  }
}

class AddNoteFab extends StatelessWidget {
  const AddNoteFab({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
        onPressed: () {
          throw UnimplementedError();
        });
  }
}
