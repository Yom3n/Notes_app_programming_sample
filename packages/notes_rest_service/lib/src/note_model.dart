class NoteModel {
  final int? id;
  final String title;
  final String text;

  NoteModel({
    this.id,
    required this.title,
    required this.text,
  });

  NoteModel.empty({
    this.id,
    this.title = '',
    this.text = '',
  });
}
