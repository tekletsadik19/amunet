import '../models/event_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/ebook/book.dart';
import '../models/post_model.dart';

class MyDatabase {
  Future<List<PostModel>> fetchItems(PostModel? post) async {
    final itemsCollectionRef = FirebaseFirestore.instance.collection('posts');

    if (post == null) {
      final documentSnapshot = await itemsCollectionRef
          .orderBy("timestamp", descending: true)
          .limit(1000)
          .get();

      return documentSnapshot.docs
          .map<PostModel>(
            (data) => PostModel.fromJson(data.data()),
      )
          .toList();
    } else {
      final documentSnapshot = await itemsCollectionRef
          .orderBy("timestamp", descending: true)
          .startAfter([post.timestamp])
          .limit(1000)
          .get();

      return documentSnapshot.docs
          .map<PostModel>(
            (data) => PostModel.fromJson(data.data()),
      )
          .toList();
    }
  }
  Future<List<EventModel>> fetchEvents(EventModel? event) async {
    final itemsCollectionRef = FirebaseFirestore.instance.collection('events');
    final documentSnapshot = await itemsCollectionRef
        .get();
    List<EventModel> events = documentSnapshot.docs
        .map(
          (data) => EventModel(
            id: data.data()['id'],
            subject: data.data()['subject'],
            description: data.data()['description'],
            duration: double.tryParse(data.data()['duration'].toString()),
            startDate: data.data()['startDate'],
            recurrenceRule: data.data()['recurrenceRule'],
          ),
    )
        .toList();
    return events;
  }

  Future<List<Book>> fetchEbooks(Book? book) async {
    final itemsCollectionRef = FirebaseFirestore.instance.collection('books');

    if (book == null) {
      final documentSnapshot = await itemsCollectionRef
          .orderBy("dateTime", descending: true)
          .limit(1000)
          .get();

      return documentSnapshot.docs
          .map<Book>(
            (data) => Book.fromJson(data.data()),
      )
          .toList();
    } else {
      final documentSnapshot = await itemsCollectionRef
          .orderBy("dateTime", descending: true)
          .startAfter([book.dateTime])
          .limit(1000)
          .get();

      return documentSnapshot.docs
          .map<Book>(
            (data) => Book.fromJson(data.data()),
      )
          .toList();
    }
  }
}