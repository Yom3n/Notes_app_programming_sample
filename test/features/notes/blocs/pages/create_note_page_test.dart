import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notes_app/core/ui/my_progress_indicator.dart';
import 'package:notes_app/features/notes/blocs/note_cubit/note_cubit.dart';
import 'package:notes_app/features/notes/pages/create_note_page.dart';

class NoteCubitMock extends MockCubit<NoteState> implements NoteCubit {}

void main() {
  late NoteCubitMock noteCubitMock;
  setUp(() {
    noteCubitMock = NoteCubitMock();
  });

  Future<void> arrangeCreateNotePage(
      {required WidgetTester tester,
      List<NoteState> statesToEmit = const []}) async {
    whenListen(
      noteCubitMock,
      Stream.fromIterable(statesToEmit),
      initialState: const NoteState(noteStateStatus: NoteStatus.idle),
    );
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<NoteCubit>(
          create: (context) => noteCubitMock,
          child: const CreateNotePage(),
        ),
      ),
    );
    await tester.pump();
  }

  testWidgets('When NoteCubit emits Idle state, should show NotePageBody',
      (tester) async {
    await arrangeCreateNotePage(
      tester: tester,
      statesToEmit: [const NoteState(noteStateStatus: NoteStatus.idle)],
    );

    final noteFormField = find.byType(CreateNotePageForm);
    expect(noteFormField, findsOneWidget);
  });

  testWidgets('When NoteCubit emits Loading state, should show LoadingPageBody',
      (tester) async {
    await arrangeCreateNotePage(
      tester: tester,
      statesToEmit: [const NoteState(noteStateStatus: NoteStatus.loading)],
    );

    final noteFormField = find.byType(MyProgressIndicator);
    expect(noteFormField, findsOneWidget);
  });
}
