import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/features/notes/blocs/notes_cubit.dart';
import 'package:notes_rest_service/notes_rest_service.dart';

import 'features/notes/pages/notes_feed_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        appBarTheme:
            AppBarTheme.of(context).copyWith(backgroundColor: Colors.amber),
        useMaterial3: true,
      ),
      home: BlocProvider(
          create: (BuildContext context) {
            return NotesCubit(FakeNotesRestService())..iInitialiseNotes(123);
          },
          child: const NotesFeedPage()),
    );
  }
}
