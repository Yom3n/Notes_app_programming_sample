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
    return <NoteModel>[
      NoteModel(id: 1, title: 'First note', text: 'First note text'),
      NoteModel(
          id: 2,
          title: 'Lorem ipsum long',
          text:
              '''Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'''),
      NoteModel(id: 3, title: 'Last note', text: 'Last note text'),
    ];
  }

  @override
  Future<NoteModel> updateNote(int noteId, NoteModel updatedData) async {
    await Future.delayed(const Duration(milliseconds: 350));
    return updatedData;
  }
}
