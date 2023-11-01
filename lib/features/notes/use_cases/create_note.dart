import 'package:notes_app/core/use_case.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_rest_service/notes_rest_service.dart';

import '../note_failures.dart';

class CreateNote extends UseCase<Note, Note> {
  final INotesRestService notesRestService;

  CreateNote(this.notesRestService);

  @override
  Future<Note> call(Note params) async {
    final noteModel = params.toNoteModel();
    try {
      final createdNote = await notesRestService.createNote(noteModel);
      return Note.fromNoteModel(createdNote);
    } on NoteRestServiceException {
      throw NoteCreationFailure();
    }
  }
}
