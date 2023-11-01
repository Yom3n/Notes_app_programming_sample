import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:notes_app/features/notes/use_cases/create_note.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_rest_service/notes_rest_service.dart';

import 'create_note_test.mocks.dart';

@GenerateMocks([INotesRestService])
void main() {
  late MockINotesRestService notesRestServiceMock;
  late CreateNote sut;

  setUp(() {
    notesRestServiceMock = MockINotesRestService();
    sut = CreateNote(notesRestServiceMock);
  });

  test('Should call NotesRestService with provided data', () async {
    // Arrange
    when(notesRestServiceMock.createNote(any))
        .thenAnswer((_) async => const NoteModel.empty());
    // Act
    await sut.call(const Note(
      title: 'Some title',
      text: 'Some text',
    ));
    //Assert
    verify(notesRestServiceMock.createNote(
      const NoteModel(title: 'Some title', text: 'Some text'),
    ));
    verifyNoMoreInteractions(notesRestServiceMock);
  });

  test('Should return converted model data when call succeed', () async {
    // Arrange
    when(notesRestServiceMock.createNote(any))
        .thenAnswer((_) async => const NoteModel(
              id: 1,
              text: 'Some text',
              title: 'Some title',
            ));
    // Act
    final result = await sut.call(const Note(
      title: 'Some title',
      text: 'Some text',
    ));
    //Assert
    expect(
        result,
        const Note(
          id: 1,
          title: 'Some title',
          text: 'Some text',
        ));
  });
}
