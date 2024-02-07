import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../model/note_model.dart';
import 'firebase_response.dart';

class NoteServices {
  NoteServices._();

  static FirebaseFirestore fireStore = FirebaseFirestore.instance;

  static Future<String?> firebaseCreateNewNotes(Note note) async {
    try {
      await fireStore.collection('notes').doc(note.noteId).set(note.toJson());
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      return "Couldn't add New Notes";
    }
    return null;
  }

  static firebaseAddNotes(
    String title,
    String description,
    Color color,
    String time,
  ) async {
    try {
      Note notes = Note(
          title: title,
          description: description,
          color: color,
          time: time,
          noteId: Uuid().v4());
      String? errorMessage = await firebaseCreateNewNotes(notes);
      if (errorMessage == null) {
        return notes;
      } else {
        return 'Couldn\'t save add notes, Please try again.';
      }
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      return 'Couldn\'t add notes';
    }
  }

   static Future<FirebaseResponse<Note>> updateMenu({required Note notes}) async {
    try {
      DocumentReference docRef;
      print('noteid: ${notes.noteId}');
      if (notes.noteId != null) {
        docRef = await fireStore.collection('notes').doc(notes.noteId);
      } else {
        docRef = await fireStore.collection('notes').doc();
        notes.noteId = docRef.id;
      }
      Note _note = notes;
      docRef.set(_note.toJson(), SetOptions(merge: true));
      return FirebaseResponse(
          message: 'Berhasil mengupdate data', data: notes, success: true);
    } catch (e, s) {
      print('$e $s');
      return FirebaseResponse(
          message: 'Gagal mengupdate data', data: null, success: false);
    }
  }
}
