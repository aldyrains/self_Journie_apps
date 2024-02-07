import 'package:flutter/material.dart';

class Note {
  String title;
  String description;
  Color color;
  String time;
  String noteId;
  String imageNotes;

  Note(
      {this.title = '',
      this.noteId = '',
      this.description = '',
      this.time = '',
      this.imageNotes = '',
      this.color = const Color.fromRGBO(255, 255, 255, 1)});

  factory Note.fromJson(Map<String, dynamic> parsedJson) {
    return Note(
      title: parsedJson['title'] ?? '',
      description: parsedJson['description'] ?? '',
      color: parsedJson['color'] ?? '',
      time: parsedJson['time'] ?? '',
      noteId: parsedJson['noteId'] ?? '',
      imageNotes: parsedJson['imagesNotes'] ?? ''
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'title': title,
      'description': description,
      'color': color,
      'time': time,
      'noteId': noteId,
      'imageNotes': imageNotes
    };
    return json;
  }
}
