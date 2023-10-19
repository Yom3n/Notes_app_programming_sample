import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../models/note.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(const NotesState(status: NotesStatus.initial));
}
