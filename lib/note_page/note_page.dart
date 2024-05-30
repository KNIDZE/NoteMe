import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../common/color_picker.dart';
import '../common/types.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key, required this.existingNote} );
  final Note existingNote;
  @override
  State<NotePage> createState() => _NewNoteState();
}

class _NewNoteState extends State<NotePage> {
  
  void handleChange(String property, String value) {
    setState(() {});
    if (property == "title") {
      widget.existingNote.setTitle(value);
    } else if (property == "description") {
      widget.existingNote.setDescription(value);
    } else if (property == "color") {
      widget.existingNote.setColor(value);
    }
  }
  final TextEditingController _titleController = TextEditingController(text: "your Text");
  final TextEditingController _decsController = TextEditingController(text: "your Text");
  @override
  void initState() {
    super.initState();
    _titleController.text = widget.existingNote.getTitle();
    _decsController.text = widget.existingNote.getDescription();
  }
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(widget.existingNote.getTitle()),
          leading:
              Consumer<NoteGlobalState>(builder: (context, notesData, child) {
            return CupertinoNavigationBarBackButton(
              onPressed: () {
                notesData.updateNote(widget.existingNote);
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
                    controller: _titleController,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Color(int.parse(widget.existingNote.getColor())),
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
                    setActiveColor: (color) => handleChange("color", color), initialColor: widget.existingNote.getColor(),),
                Expanded(
                  child: CupertinoTextField(
                    textAlignVertical: TextAlignVertical.top,
                    controller: _decsController,
                    expands: true,
                    minLines: null,
                    maxLines: null,
                      placeholder: "Enter description",
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(int.parse(widget.existingNote.getColor())), width: 2),
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
