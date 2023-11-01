import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:notes_app/features/notes/blocs/note_cubit/note_cubit.dart';
import 'package:notes_app/features/notes/note_failures.dart';
import 'package:notes_app/features/notes/use_cases/create_note.dart';
import 'package:notes_app/models/note.dart';

import 'note_cubit_test.mocks.dart';

@GenerateMocks([CreateNote])
void main() {
  late MockCreateNote createNoteMock;

  setUp(() {
    createNoteMock = MockCreateNote();
  });

  const tNote = Note(title: 'Some title', text: 'Some text');

  blocTest<NoteCubit, NoteState>(
      'When ISaveNote is called with correct data test if createNote is called',
      setUp: () {
        when(createNoteMock(any)).thenAnswer((_) async => const Note());
      },
      build: () => NoteCubit(createNote: createNoteMock),
      act: (bloc) => bloc.iSaveNote(tNote),
      verify: (_) {
        verify(createNoteMock(tNote));
        verifyNoMoreInteractions(createNoteMock);
      });

  blocTest<NoteCubit, NoteState>(
      'When ISaveNote is called with correct data should emit Loading, and Saved states',
      setUp: () {
        when(createNoteMock(any))
            .thenAnswer((_) async => tNote.copyWith(id: 1));
      },
      build: () => NoteCubit(createNote: createNoteMock),
      act: (bloc) => bloc.iSaveNote(tNote),
      expect: () => [
            const NoteState(noteStateStatus: NoteStatus.loading),
            const NoteState(
              noteStateStatus: NoteStatus.saved,
              note: Note(id: 1, title: 'Some title', text: 'Some text'),
            ),
          ]);

  blocTest<NoteCubit, NoteState>(
      '''When createNote use case throws NoteCreationFailure should emit Error state''',
      setUp: () {
        when(createNoteMock(any)).thenThrow(NoteCreationFailure());
      },
      build: () => NoteCubit(createNote: createNoteMock),
      act: (bloc) => bloc.iSaveNote(tNote),
      expect: () => [
            const NoteState(noteStateStatus: NoteStatus.loading),
            const NoteState(noteStateStatus: NoteStatus.noteCreationFailure),
          ]);
}
