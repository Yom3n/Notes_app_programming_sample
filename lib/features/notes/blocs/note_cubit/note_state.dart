part of 'note_cubit.dart';

enum NoteStatus {
  initial,
  idle,
  loading,
  saved,
  validationError,
  noteCreationFailure,
}

class NoteState extends Equatable {
  final NoteStatus status;
  final Note note;

  const NoteState({
    required this.status,
    this.note = const Note(),
  });

  @override
  List<Object> get props => [status, note];
}
