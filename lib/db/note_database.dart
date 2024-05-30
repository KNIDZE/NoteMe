import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../common/types.dart';

class NotesBase {
  static final NotesBase instance = NotesBase._internal();
  static Database? _database;

  NotesBase._internal();
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    
    return await openDatabase(
      join(await getDatabasesPath(), 'note_me_database.db'),
      onCreate: (db, version) {
        
        return db.execute(
          'CREATE TABLE active_notes (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, color TEXT, archived BIT)',
        );
      },
      version: 1,
    );
  }

  // Define a function that inserts dogs into the database
  Future<void> insertNote(Note note) async {
    // Get a reference to the database.
    final db = await database;
    Map noteData = note.toMap();
    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'active_notes',
      {
        "title": noteData['title'],
        "description": noteData['description'],
        "color": noteData['color'],
        "archived" : 0
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }


  Future<List<List<Note>>> getNotes() async {
    // Get a reference to the database.
    final db = await database;

    final List<Map<String, Object?>> activeNotesList = await db.query('active_notes', where: "archived = 0");
    final List<Map<String, Object?>> archivedNotesList = await db.query('active_notes', where: "archived = 1");
    
    List<Note> activeNotes = [ for (final {
            'id': id as int,
            'title': title as String,
            'description': description as String,
            'color': color as String,
          } in activeNotesList)
        Note(
            title: title,
            description: description,
            color: color,
            id: id.toString()),
    ];
    List<Note> archivedNotes = [ for (final {
            'id': id as int,
            'title': title as String,
            'description': description as String,
            'color': color as String,
          } in archivedNotesList)
        Note(
            title: title,
            description: description,
            color: color,
            id: id.toString(),
            isArchived: 1),
    ];
    return [activeNotes, archivedNotes];
  }

  Future<void> updateNote(Note note) async {
    // Get a reference to the database.
    final db = await database;
    // Update the given Dog.
    await db.update(
      'active_notes',
      note.toMap(),
      // Ensure that the Dog has a matching id.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [note.getId()],
    );
  
  }
  Future<void> deleteNote(Note note) async {
    // Get a reference to the database.
    final db = await database;
    // Remove the Dog from the database.
    await db.delete(
      'active_notes',
      // Use a `where` clause to delete a specific dog.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [note.getId()],
    );
  }
}
