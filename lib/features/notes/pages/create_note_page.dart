import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/core/ui/my_progress_indicator.dart';
import 'package:notes_app/features/notes/blocs/note_cubit/note_cubit.dart';

import '../../../models/note.dart';

class CreateNotePage extends StatelessWidget {
  const CreateNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocConsumer<NoteCubit, NoteState>(
          listener: (context, state) {
            if (state.status == NoteStatus.saved) {
              Navigator.pop(context, state.note);
            }
          },
          builder: (context, state) {
            switch (state.status) {
              case NoteStatus.initial:
                return const Text('Page in initial state');
              case NoteStatus.loading:
                return const MyProgressIndicator();
              case NoteStatus.idle:
              case NoteStatus.saved:
              case NoteStatus.validationError:
              case NoteStatus.noteCreationFailure:
                return const CreateNotePageForm();
            }
          },
        ),
      ),
    );
  }
}

class CreateNotePageForm extends StatefulWidget {
  const CreateNotePageForm({super.key});

  @override
  State<CreateNotePageForm> createState() => _CreateNotePageFormState();
}

class _CreateNotePageFormState extends State<CreateNotePageForm> {
  late final TextEditingController titleController, noteController;

  @override
  void initState() {
    titleController = TextEditingController();
    noteController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        TextField(
          key: const Key('TitleFieldKey'),
          controller: titleController,
          decoration: InputDecoration(
            label: const Text('Title'),
            filled: true,
            fillColor: Theme.of(context).primaryColorLight,
            border: InputBorder.none,
          ),
        ),
        const SizedBox(height: 25),
        TextField(
          key: const Key('TextFieldKey'),
          controller: noteController,
          keyboardType: TextInputType.multiline,
          minLines: 5,
          maxLines: null,
          decoration: InputDecoration(
            label: const Text('Note'),
            filled: true,
            fillColor: Theme.of(context).primaryColorLight,
            border: InputBorder.none,
          ),
        ),
        const SizedBox(height: 30),
        Center(
          child: SizedBox(
            width: 240,
            child: ElevatedButton(
              key: const Key('SaveButton'),
              child: const Text('Save'),
              onPressed: () {
                context.read<NoteCubit>().iSaveNote(
                      Note(
                          title: titleController.text,
                          text: noteController.text),
                    );
              },
            ),
          ),
        )
      ],
    );
  }
}
