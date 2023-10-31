import 'package:flutter/material.dart';

class CreateNotePage extends StatelessWidget {
  const CreateNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add note'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(10),
        child: CreateNotePageBody(),
      ),
    );
  }
}

class CreateNotePageBody extends StatefulWidget {
  const CreateNotePageBody({super.key});

  @override
  State<CreateNotePageBody> createState() => _CreateNotePageBodyState();
}

class _CreateNotePageBodyState extends State<CreateNotePageBody> {
  late final TextEditingController titleController, noteController;

  @override
  void initState() {
    titleController = TextEditingController();
    noteController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        TextField(
          controller: titleController,
          decoration: InputDecoration(
            label: const Text('Title'),
            filled: true,
            fillColor: Theme.of(context).primaryColorLight,
            border: InputBorder.none,
          ),
        ),
        const SizedBox(height: 25),
        TextField(
          controller: noteController,
          keyboardType: TextInputType.multiline,
          minLines: 5,
          maxLines: null,
          decoration: InputDecoration(
            label: const Text('Note'),
            filled: true,
            fillColor: Theme.of(context).primaryColorLight,
            border: InputBorder.none,
          ),
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          child: const Text('Save'),
          onPressed: () {
            throw UnimplementedError();
          },
        )
      ],
    );
  }
}
