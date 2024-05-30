import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../common/types.dart';
import 'new_note_button.dart';
import 'single_note.dart';
class ActiveNotesGrid extends StatelessWidget {
  const ActiveNotesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    double itemsCount = MediaQuery.of(context).size.width / 200;
    return Stack(children: [
      Consumer<NoteGlobalState>(
        builder: (context, notesData, child) {
          return GridView(
            padding: const EdgeInsets.fromLTRB(10, 80, 10, 150),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: (itemsCount > 0 ? itemsCount : 1).toInt(),
                childAspectRatio: (1 / 1)),
            children: notesData
                .getActive()
                .map((elem) => SingleNote(
                      note: elem,
                      endToStart: notesData.removeNote,
                      startToEnd: notesData.toggleArchiveNote,
                    ))
                .toList(),
          );
        },
      ),
      const Positioned(
        bottom: 100,
        left: 0,
        right: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NewNoteButton(),
          ],
        ),
      )
    ]);
  }
}

class ArchivedNotesGrid extends StatelessWidget {
  const ArchivedNotesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    double itemsCount = MediaQuery.of(context).size.width / 200;
    return Stack(children: [
      Consumer<NoteGlobalState>(
        builder: (context, notesData, child) {
          return GridView(
            padding: const EdgeInsets.fromLTRB(10, 80, 10, 150),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: (itemsCount > 0 ? itemsCount : 1).toInt(),
                childAspectRatio: (1 / 1)),
            children: notesData
                .getArchive()
                .map((elem) => SingleNote(
                      note: elem,
                      endToStart: notesData.toggleArchiveNote,
                      startToEnd: notesData.removeNote,
                    ))
                .toList(),
          );
        },
      ),
      const Positioned(
        bottom: 100,
        left: 0,
        right: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NewNoteButton(),
          ],
        ),
      )
    ]);
  }
}
