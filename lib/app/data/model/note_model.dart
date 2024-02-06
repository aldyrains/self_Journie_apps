import 'package:flutter/material.dart';

class Note {
  String title;
  String description;
  Color color;
  String time;
  String noteId;

  Note(
      {this.title = '',
      this.noteId = '',
      this.description = '',
      this.time = '',
      this.color = const Color.fromRGBO(255, 255, 255, 1)});

   factory Note.fromJson(Map<String, dynamic> parsedJson) {
    return Note(
        title: parsedJson['title'] ?? '',
        description: parsedJson['description'] ?? '',
        color: parsedJson['color'] ?? '',
        time: parsedJson['time'] ?? '',
        noteId: parsedJson['noteId'] ?? '',

            );
  }

   Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'title': title,
      'description': description,
      'color': color,
      'time': time,
      'noteId': noteId,
      
    };
    return json;
  }
}
