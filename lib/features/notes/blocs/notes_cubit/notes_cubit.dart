import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:notes_rest_service/notes_rest_service.dart';

import '../../../../models/note.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  final INotesRestService notesRestService;

  NotesCubit(this.notesRestService)
      : super(const NotesState(status: NotesStatus.initial));

  Future<void> iInitialiseNotes(int userId) async {
    emit(state.copyWith(status: NotesStatus.loading, notes: []));
    try {
      final notesModels = await notesRestService.getNotes(userId);
      final notes = notesModels
          .map<Note>((noteModel) => Note.fromNoteModel(noteModel))
          .toList();
      emit(state.copyWith(status: NotesStatus.loaded, notes: notes));
    } on NoteRestServiceException catch (restServiceException) {
      emit(
        state.copyWith(
          status: NotesStatus.error,
          noteErrorData: NoteErrorData(
            NoteErrorStatus.userDoesNotExist,
            exception: restServiceException,
          ),
        ),
      );
    }
  }
}
