import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:notes_app/features/notes/note_failures.dart';
import 'package:notes_app/models/note.dart';

import '../../use_cases/create_note.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  final CreateNote createNote;

  NoteCubit({required this.createNote})
      : super(const NoteState(status: NoteStatus.idle));

  void iSaveNote(Note note) async {
    emit(const NoteState(status: NoteStatus.loading));
    try {
      final createdNote = await createNote(note);
      emit(NoteState(status: NoteStatus.saved, note: createdNote));
    } on NoteCreationFailure {
      emit(const NoteState(status: NoteStatus.noteCreationFailure));
    }
  }
}
