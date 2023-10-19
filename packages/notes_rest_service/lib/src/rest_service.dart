import 'dart:math';

import 'note_model.dart';

abstract class INotesRestService {
  Future<List<NoteModel>> getNotes(int userId);

  Future<NoteModel> createNote(NoteModel note);

  Future<NoteModel> updateNote(int noteId, NoteModel updatedData);

  Future<void> deleteNote(int noteId);
}

///Fake implementation of notes rest service.
///Simulate behaviour of real backend service
class FakeNotesRestService implements INotesRestService {
  @override
  Future<NoteModel> createNote(NoteModel note) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return NoteModel(
      id: Random().nextInt(10000),
      title: note.title,
      text: note.text,
    );
  }

  @override
  Future<void> deleteNote(int noteId) async {
    await Future.delayed(const Duration(milliseconds: 250));
  }

  @override
  Future<List<NoteModel>> getNotes(int userId) async {
    await Future.delayed(const Duration(milliseconds: 450));
    return <NoteModel>[];
  }

  @override
  Future<NoteModel> updateNote(int noteId, NoteModel updatedData) async {
    await Future.delayed(const Duration(milliseconds: 350));
    return updatedData;
  }
}
