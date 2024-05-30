import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../common/color_picker.dart';
import '../common/types.dart';

class NewNote extends StatefulWidget {
  const NewNote({super.key} );
  @override
  State<NewNote> createState() => _NewNoteState();
}

class _NewNoteState extends State<NewNote> {
  final Note noteData = Note();

  void handleChange(String property, String value) {
    setState(() {});
    if (property == "title") {
      noteData.setTitle(value);
    } else if (property == "description") {
      noteData.setDescription(value);
    } else if (property == "color") {
      noteData.setColor(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: const Text("New Note"),
          leading:
              Consumer<NoteGlobalState>(builder: (context, notesData, child) {
            return CupertinoNavigationBarBackButton(
              onPressed: () {
                if (noteData.getTitle() != "") {
                  notesData.addActiveNote(noteData);
                }
                Navigator.pop(context);
              },
            );
          }),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CupertinoTextField(
                    placeholder: "Enter title",
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Color(int.parse(noteData.getColor())),
                          width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                    onChanged: (value) => 
                          handleChange("title", value)
                        ),
                ColorPicker(
                    setActiveColor: (color) => handleChange("color", color)),
                Expanded(
                  child: CupertinoTextField(
                    textAlignVertical: TextAlignVertical.top,
                    expands: true,
                    minLines: null,
                    maxLines: null,
                      placeholder: "Enter description",
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(int.parse(noteData.getColor())), width: 2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      onChanged: (value) =>
                            handleChange("description", value)
                          ),
                ),
              ],
            ),
          ),
        ));
  }
}
