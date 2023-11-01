import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_rest_service/notes_rest_service.dart';

import '../../use_cases/create_note.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  final CreateNote createNote;

  NoteCubit({required this.createNote})
      : super(const NoteState(noteStateStatus: NoteStatus.initial));

  void iSaveNote(Note note) async {
    await createNote(note);
  }
}
