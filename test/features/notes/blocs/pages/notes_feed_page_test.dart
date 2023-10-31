import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notes_app/core/ui/my_progress_indicator.dart';
import 'package:notes_app/features/notes/blocs/notes_cubit/notes_cubit.dart';
import 'package:notes_app/features/notes/pages/notes_feed_page.dart';
import 'package:notes_app/models/note.dart';

class MockNotesCubit extends MockCubit<NotesState> implements NotesCubit {}

void main() {
  late MockNotesCubit notesCubitMock;
  setUp(() {
    notesCubitMock = MockNotesCubit();
  });

  ///Pumps [NotesFeedPage] and emits [notesStatesToEmit] through [NotesCubit]
  Future<void> arrangeNotesFeedPage(
      {required WidgetTester tester,
      required List<NotesState> noteStatesToEmit}) async {
    whenListen(
      notesCubitMock,
      Stream.fromIterable(noteStatesToEmit),
      initialState: const NotesState(status: NotesStatus.initial),
    );
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<NotesCubit>.value(
          value: notesCubitMock,
          child: const NotesFeedPage(),
        ),
      ),
    );
    await tester.pump();
  }

  testWidgets(
    'NotesFeedPage show loading indicator when status loading is emitted',
    (tester) async {
      // Arrange
      await arrangeNotesFeedPage(
          tester: tester,
          noteStatesToEmit: [const NotesState(status: NotesStatus.loading)]);
      // Assert
      final loadingIndicator = find.byType(MyProgressIndicator);
      expect(loadingIndicator, findsOneWidget);
    },
  );

  testWidgets(
    'NotesFeedPage show notes feed, and AddNote button when status Loaded is emitted',
    (tester) async {
      // Arrange
      await arrangeNotesFeedPage(tester: tester, noteStatesToEmit: [
        const NotesState(status: NotesStatus.loaded, notes: [
          Note(id: 1, title: 'Title 1', text: 'Text 1'),
          Note(id: 2, title: 'Title 2', text: 'Text 2')
        ])
      ]);
      // Assert
      final notesFeed = find.byType(NotesFeedBody);
      expect(notesFeed, findsOneWidget);
      final addNoteButton = find.byType(AddNoteFab);
      expect(addNoteButton, findsOneWidget);
    },
  );

  testWidgets(
    'NotesFeedPage show error message when status Error is emitted',
    (tester) async {
      // Arrange
      await arrangeNotesFeedPage(tester: tester, noteStatesToEmit: [
        const NotesState(
          status: NotesStatus.error,
          noteErrorData: NoteErrorData(
            NoteErrorStatus.userDoesNotExist,
          ),
        ),
      ]);
      // Assert
      final notesFeed = find.byType(NotesErrorBody);
      expect(notesFeed, findsOneWidget);
    },
  );
}
