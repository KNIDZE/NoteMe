import 'package:flutter/cupertino.dart';


import '../db/note_database.dart';

class Note {

  final Map<String, String> _noteData = {};

  Note({String ?title,  String ?description,  String ?color, String ?id, int ?isArchived}) {
    title != null? _noteData['title'] = title : _noteData['title'] = '';
    description != null? _noteData['description'] = description : _noteData['description'] = '';
    color != null? _noteData['color'] = color : _noteData['color'] = const Color(0xfffdc734).value.toString();
    if (id != null) _noteData['id'] = id;
    _noteData['archived'] = (isArchived ?? 0).toString() ;
  }
  void setTitle(String title) {
    _noteData['title'] = title;
  }
  void setDescription(String description) {
    _noteData['description'] = description;
  }
  void setColor(String color) {
    _noteData['color'] = color;
  }
  String getTitle() {
    if (_noteData.containsKey('title')) {
      return _noteData['title']!;
      }
    return '';
  }
  String getDescription() {
    if (_noteData.containsKey('description')) {
      return _noteData['description']!;
      }
    return '';
  }
  String getColor() {
    if (_noteData.containsKey('color')) {
      return _noteData['color']!;
      }
    return '';
  }
  Map<String, String> toMap() {
    return  _noteData;
  }
  String getId() {
    if (_noteData.containsKey('id')) {
      return _noteData['id']!;
      }
    return '-1';
  }
  String isArchived(){
    return _noteData['archived'] ?? "0";
  }
  void toggleArchived(){
    _noteData['archived'] = _noteData['archived'] == "0" ? "1" : "0";
  }
  @override
  String toString() {
    return 'Note(title: ${_noteData["title"]}, description: ${_noteData["description"]}, color: ${_noteData["color"]}), id: ${_noteData["id"]}, archived: ${_noteData['archived']})';
  }

}

class NoteGlobalState extends ChangeNotifier{

  final NotesBase notesBase = NotesBase.instance;
  final _activeNotes = <Note>[];
  final _archivedNotes = <Note>[];

  NoteGlobalState(){
    _getNotesFromDB();
  }

  void addActiveNote(Note note) async{
    await notesBase.insertNote(note);
    await _getNotesFromDB();
  }
  Future<void> _getNotesFromDB() async{
    List<List<Note>> notes = await notesBase.getNotes();
    _activeNotes.clear();
    _archivedNotes.clear();
    _activeNotes.addAll(notes[0]);
    _archivedNotes.addAll(notes[1]);
    notifyListeners();
    
  }
  void removeNote(Note note){
    notesBase.deleteNote(note);
    _getNotesFromDB();
  }
  List<Note> getActive(){
    return _activeNotes;
  }
  List<Note> getArchive(){
    return _archivedNotes;
  }
  void toggleArchiveNote(Note note){
    note.toggleArchived();
    
    notesBase.updateNote(note);
    _getNotesFromDB();
    
  }
  void updateNote(Note note){
    notesBase.updateNote(note);
    _getNotesFromDB();
  }
}