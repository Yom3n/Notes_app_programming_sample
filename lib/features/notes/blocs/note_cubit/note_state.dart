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
  final NoteStatus noteStateStatus;
  final Note note;

  const NoteState({
    required this.noteStateStatus,
    this.note = const Note(),
  });

  @override
  List<Object> get props => [noteStateStatus, note];
}
