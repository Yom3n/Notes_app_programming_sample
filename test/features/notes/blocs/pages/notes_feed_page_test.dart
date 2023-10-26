import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notes_app/core/ui/my_progress_indicator.dart';
import 'package:notes_app/features/notes/blocs/notes_cubit.dart';
import 'package:notes_app/features/notes/pages/notes_feed_page.dart';

class MockNotesCubit extends MockCubit<NotesState> implements NotesCubit {}

void main() {
  late MockNotesCubit notesCubitMock;
  setUp(() {
    notesCubitMock = MockNotesCubit();
  });

  testWidgets(
    'Test page show loading indicator, and then list of notes',
    (tester) async {
      // Arrange

      whenListen(
        notesCubitMock,
        Stream.fromIterable([const NotesState(status: NotesStatus.loading)]),
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
      // Assert
      final loadingIndicator = find.byType(MyProgressIndicator);
      expect(loadingIndicator, findsOneWidget);
    },
  );
}
