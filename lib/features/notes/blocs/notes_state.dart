part of 'notes_cubit.dart';

enum NotesStatus {
  initial,
  loaded,
  loading,
  error,
}

class NotesState extends Equatable {
  const NotesState({
    required this.status,
    this.notes = const [],
    this.noteErrorData,
  });

  final List<Note> notes;
  final NotesStatus status;
  final NoteErrorData? noteErrorData;

  NotesState copyWith({
    List<Note>? notes,
    NotesStatus? status,
    NoteErrorData? noteErrorData,
  }) {
    return NotesState(
      status: status ?? this.status,
      notes: notes ?? this.notes,
      noteErrorData: noteErrorData ?? this.noteErrorData,
    );
  }

  @override
  List<Object?> get props => [notes, status];
}

enum NoteErrorStatus {
  userDoesNotExist,
}

///Detailed error data
class NoteErrorData extends Equatable {
  const NoteErrorData(
    this.noteErrorStatus, {
    this.exception,
  });

  final Error? exception;
  final NoteErrorStatus? noteErrorStatus;

  bool hasError() {
    return noteErrorStatus != null;
  }

  @override
  List<Object?> get props => [noteErrorStatus];
}
