import 'package:equatable/equatable.dart';

class Note extends Equatable {
  final int? id;
  final String title;
  final String text;

  const Note({this.id, this.title = '', this.text = ''});

  @override
  List<Object?> get props => [id, title, text];
}
