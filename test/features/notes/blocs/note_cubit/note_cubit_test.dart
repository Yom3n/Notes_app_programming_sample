import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:notes_app/features/notes/blocs/note_cubit/note_cubit.dart';
import 'package:notes_app/features/notes/use_cases/create_note.dart';
import 'package:notes_app/models/note.dart';

import 'note_cubit_test.mocks.dart';

@GenerateMocks([CreateNote])
void main() {
  late MockCreateNote createNoteMock;

  setUp(() {
    createNoteMock = MockCreateNote();
  });

  blocTest<NoteCubit, NoteState>(
      'When ISaveNote is called with correct data test if createNote is called',
      setUp: () {
        when(createNoteMock(any)).thenAnswer((_) async => const Note());
      },
      build: () => NoteCubit(createNote: createNoteMock),
      act: (bloc) => bloc.iSaveNote(
            const Note(title: 'Some title', text: 'Some text'),
          ),
      verify: (_) {
        verify(
            createNoteMock(const Note(title: 'Some title', text: 'Some text')));
        verifyNoMoreInteractions(createNoteMock);
      });
}
