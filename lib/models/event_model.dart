import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../utils/firebase.dart';

class EventModel extends Equatable{
  String? id;
  String? description;
  String? subject;
  Timestamp? startDate;
  double? duration;
  String? recurrenceRule;
  final Random random = Random();
  EventModel({
    this.id,
    this.subject,
    this.description = '',
    this.duration=2,
    this.startDate,
    this.recurrenceRule
  });

  EventModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subject= json['subject'];
    description = json['description'];
    duration = json['duration'];
    startDate = json['startDate'];
    recurrenceRule = json['recurrenceRule'];
  }

  EventModel copyWith(
      {String? id, String? subject,
        String? ownerId,
        double? duration,
        String? description,
        String? recurrenceRule,
        Timestamp? startDate}){
    return EventModel(
        id: id??uuid.v4(),
        subject: subject??'',
        description: description??this.description,
        duration: duration??2.0,
        startDate: startDate?? Timestamp.now(),
        recurrenceRule: recurrenceRule??''
    );
  }

  factory EventModel.fromDocument(DocumentSnapshot snapshot){
    return EventModel(
        id: snapshot.data().toString().contains('id') ?snapshot['id']:'',
        duration:snapshot.data().toString().contains('duration') ? snapshot['duration']:2,
        description:snapshot.data().toString().contains('description') ? snapshot["description"]:'',
        subject:snapshot.data().toString().contains('subject') ? snapshot['subject']:'',
        startDate:snapshot.data().toString().contains('startDate') ? snapshot['startDate']:'',
        recurrenceRule:snapshot.data().toString().contains('recurrenceRule') ? snapshot['recurrenceRule']:'',
    );
  }

  @override
  List<Object?> get props => [
    id,
    subject,
    description,
    duration,
    startDate,
    recurrenceRule
  ];

}