import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../new_note/new_note_page.dart';


class NewNoteButton extends StatelessWidget {
  const NewNoteButton({super.key});

  @override
  Widget build(BuildContext context) {
    CupertinoThemeData theme = CupertinoTheme.of(context);
    return Container(
      
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: theme.primaryColor,),
        width: 70,
        height: 70,
      child: IconButton(
        icon: Icon(
          size: 40,
          color: theme.barBackgroundColor,
          Icons.add),
        onPressed: () {
          Navigator.push(context, CupertinoPageRoute(builder: (context) => const NewNote()));
          null;
        },
      ),
    );
  }
}