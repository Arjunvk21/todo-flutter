import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TaskModel {
  String? id;
  String? title;
  String? description;
  DateTime? createdAt;
  bool? status;
  String? userid;

  TaskModel(
      {this.id,
      this.title,
      this.userid,
      this.description,
      this.createdAt,
      this.status});

  factory TaskModel.fromJson(Map<String, dynamic> data) {
    Timestamp? timestamp = data['createdAt'];
    return TaskModel(
      id: data['id'],
      userid: data['userid'],
      title: data['title'],
      description: data['description'],
      createdAt: timestamp?.toDate(),
      status: data['status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userid': userid,
      'title': title,
      'description': description,
      'createdAt': createdAt,
      'status': status
    };
  }
}
