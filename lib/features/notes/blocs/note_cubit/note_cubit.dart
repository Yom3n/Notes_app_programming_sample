import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:notes_app/models/note.dart';

import '../../use_cases/create_note.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  final CreateNote createNote;

  NoteCubit({required this.createNote})
      : super(const NoteState(noteStateStatus: NoteStatus.initial));

  void iSaveNote(Note note) async {
    emit(const NoteState(noteStateStatus: NoteStatus.loading));
    final createdNote = await createNote(note);
    emit(NoteState(noteStateStatus: NoteStatus.saved, note: createdNote));
  }
}
