# NoteMe
NoteMe is a Flutter application for creating, deleting, and archiving notes. It is a convenient and easy-to-use tool for organizing your thoughts and ideas.

## Features
- Create Notes: Easily create new notes to jot down your thoughts.
- Delete Notes: Delete notes with a simple swipe left.
- Edit Notes: Edit Title, Description and color of note
- Archive Notes: Archive notes with a swipe right for future use.
- Restore from Archive: Restore archived notes back to the main screen.
# Overview
### HomeMe Class
The HomeMe class contains a CupertinoTabBar that switches between the main screen and the archive screen. It includes:

- Active Notes Grid: Displays all active notes.
- Archived Notes Grid: Displays all archived notes.

### NewNotePage
The NewNotePage file contains the NewNote class, which is the screen where users can create a new note. 

Features include:
- Title: Set the title of the note.
- Description: Write the description of the note.
- Color: Choose the color for the note.

### SingleNote: 
The SingleNote class in the single_note file is responsible for displaying a note card in both Active and Archived notes grids. 
Features include:
- View/Edit Note: Tap on the note card to go to the note editing page.
- Swipe Actions:
- Swipe Left:
  - If active, deletes the note.
  - If archived, makes it active.
- Swipe Right:
  - If active, archives the note.
  - If archived, deletes the note.
    
## Data Storage
Notes are stored locally using SQLite database for persistent storage.

# Getting Started
Prerequisites
Flutter SDK: Flutter installation guide
Dart SDK (included with Flutter)
