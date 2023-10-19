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

  NoteModel toNoteModel() => NoteModel(id: id, title: title, text: text);

  @override
  List<Object?> get props => [id, title, text];
}
