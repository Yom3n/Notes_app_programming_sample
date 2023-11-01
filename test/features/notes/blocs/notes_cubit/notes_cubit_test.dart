import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:notes_app/features/notes/blocs/notes_cubit/notes_cubit.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_rest_service/notes_rest_service.dart';

import 'notes_cubit_test.mocks.dart';

@GenerateMocks([INotesRestService])
void main() {
  late MockINotesRestService notesRestServiceMock;

  setUp(() {
    notesRestServiceMock = MockINotesRestService();
  });

  blocTest<NotesCubit, NotesState>(
    '''When initialiseNotes is called with correct userId, should call
     rest service with correct Id and
      emit states [Loading, Loaded] with correct data''',
    setUp: () {
      when(notesRestServiceMock.getNotes(any)).thenAnswer((_) async => [
            const NoteModel(id: 1, title: 'First note', text: 'First note text'),
            const NoteModel(id: 2, title: 'Second note', text: 'Second note text'),
            const NoteModel(id: 3, title: 'Third note', text: 'Third note text'),
          ]);
    },
    build: () => NotesCubit(notesRestServiceMock),
    act: (bloc) {
      bloc.iInitialiseNotes(123);
    },
    verify: (bloc) {
      verify(notesRestServiceMock.getNotes(123));
      verifyNoMoreInteractions(notesRestServiceMock);
    },
    expect: () => <NotesState>[
      const NotesState(status: NotesStatus.loading),
      const NotesState(status: NotesStatus.loaded, notes: [
        Note(id: 1, title: 'First note', text: 'First note text'),
        Note(id: 2, title: 'Second note', text: 'Second note text'),
        Note(id: 3, title: 'Third note', text: 'Third note text'),
      ]),
    ],
  );

  blocTest<NotesCubit, NotesState>(
    '''When initialiseNotes is called with correct userId, should call
     rest service with correct Id and
      emit states [Loading, Loaded] with correct data''',
    setUp: () {
      when(notesRestServiceMock.getNotes(any)).thenThrow(
        NoteRestServiceException(statusCode: 404, errorMessage: 'Not found'),
      );
    },
    build: () => NotesCubit(notesRestServiceMock),
    act: (bloc) {
      bloc.iInitialiseNotes(123);
    },
    expect: () => <NotesState>[
      const NotesState(status: NotesStatus.loading),
      const NotesState(
        status: NotesStatus.error,
        noteErrorData: NoteErrorData(NoteErrorStatus.userDoesNotExist),
      ),
    ],
  );
}
