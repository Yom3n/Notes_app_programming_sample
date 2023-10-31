

import 'package:notes_app/core/use_case.dart';
import 'package:notes_app/models/note.dart';

class CreateNote extends UseCase<Note, Note>{
  @override
  Note call(Note params) {
    // TODO: implement call. UseCase layer is required to not deal with toModel/fromModel in blocs
    throw UnimplementedError();
  }

}