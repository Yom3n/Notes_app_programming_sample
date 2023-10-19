import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:notes_app/features/notes/blocs/notes_cubit.dart';
import 'package:notes_rest_service/notes_rest_service.dart';

@GenerateMocks([INotesRestService])

void main() {


  blocTest<NotesCubit, NotesState>(
    'When initialiseNotes is called with correct userId, should call rest service with correct ID',
    setUp: (){

    },
    build: () => NotesCubit(),
    act: (bloc) {
      // bloc.iInitialiseNotes(123);
    },
    expect: () =>
    <NotesState>[
      const NotesState(status: NotesStatus.initial),
    ],
  );
}
