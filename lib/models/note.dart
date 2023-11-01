import 'package:equatable/equatable.dart';
import 'package:notes_rest_service/notes_rest_service.dart';

class Note extends Equatable {
  final int? id;
  final String title;
  final String text;

  const Note({this.id, this.title = '', this.text = ''});

  Note.fromNoteModel(NoteModel noteModel)
      : id = noteModel.id,
        text = noteModel.text,
        title = noteModel.title;

  Note copyWith({
    int? id,
    String? title,
    String? text,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      text: text ?? this.text,
    );
  }

  NoteModel toNoteModel() => NoteModel(id: id, title: title, text: text);

  @override
  List<Object?> get props => [id, title, text];
}
