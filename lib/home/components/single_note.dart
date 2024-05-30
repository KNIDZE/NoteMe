import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_me_app/note_page/note_page.dart';
import '../../common/types.dart';

class SingleNote extends StatelessWidget {
  const SingleNote(
      {super.key,
      required this.note,
      required this.endToStart,
      required this.startToEnd});
  final Note note;
  final Function endToStart;
  final Function startToEnd;

  void dismissHandler(direction) {
    if (direction == DismissDirection.startToEnd) {
      startToEnd(note);
    }
    if (direction == DismissDirection.endToStart) {
      endToStart(note);
    }
  }

  @override
  Widget build(BuildContext context) {
    //CupertinoThemeData theme = CupertinoTheme.of(context);
    return Dismissible(
      // if i do simple ID key, will be exception "A dismissed Dismissible widget is still part of the tree."
      key: Key(note.getId() + note.isArchived()),
      direction: DismissDirection.horizontal,
      onDismissed: (direction) => {dismissHandler(direction)},
      child: GestureDetector(
        onTap: () => Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) => NotePage(
                      existingNote: note,
                    ))),
        child: Card(
          margin: const EdgeInsets.all(10),
          //color: theme.primaryColor,
          child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    note.getTitle(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Color(int.parse(note.getColor()))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    note.getDescription(),
                    overflow: TextOverflow.fade,
                    maxLines: 2,
                    softWrap: true,
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
