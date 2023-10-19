part of 'notes_cubit.dart';

enum NotesStatus {
  initial,
  idle,
  loading,
}

class NotesState extends Equatable {
  const NotesState({required this.status, this.notes = const []});

  final List<Note> notes;
  final NotesStatus status;

  NotesState copyWith({List<Note>? notes, NotesStatus? status}) {
    return NotesState(
      status: status ?? this.status,
      notes: notes ?? this.notes,
    );
  }

  @override
  List<Object?> get props => [notes, status];
}
