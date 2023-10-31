import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_rest_service/notes_rest_service.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  final INotesRestService notesRestService;

  NoteCubit({required this.notesRestService})
      : super(const NoteState(noteStateStatus: NoteStatus.initial));

  void iSaveNote(Note note) async {
    await notesRestService.createNote(note.toNoteModel());
  }
}
