import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:notes_app/features/notes/blocs/note_cubit/note_cubit.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_rest_service/notes_rest_service.dart';

import '../notes_cubit/notes_cubit_test.mocks.dart';

@GenerateMocks([INotesRestService])
void main() {
  late MockINotesRestService notesRestServiceMock;

  setUp(() {
    notesRestServiceMock = MockINotesRestService();
  });

  blocTest<NoteCubit, NoteState>(
      'Test if SaveNote is called on NotesRestService with correct data,'
      ' when ISaveNote is called with correct data',
      setUp: () {
        when(notesRestServiceMock.createNote(any))
            .thenAnswer((realInvocation) async => NoteModel.empty());
      },
      build: () => NoteCubit(notesRestService: notesRestServiceMock),
      act: (bloc) => bloc.iSaveNote(
            const Note(title: 'Some title', text: 'Some text'),
          ),
      verify: (_) {
        verify(notesRestServiceMock
            .createNote(NoteModel(title: 'Some title', text: 'Some text')));
        verifyNoMoreInteractions(notesRestServiceMock);
      });
}
