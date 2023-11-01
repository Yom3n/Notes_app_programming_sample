import 'package:equatable/equatable.dart';

class NoteModel extends Equatable {
  final int? id;
  final String title;
  final String text;

  const NoteModel({
    this.id,
    required this.title,
    required this.text,
  });

  const NoteModel.empty({
    this.id,
    this.title = '',
    this.text = '',
  });

  @override
  List<Object?> get props => [id, title, text];
}
