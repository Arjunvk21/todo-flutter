import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserModel {
  String? id;
  String? username;
  String? email;
  String? password;

  UserModel({this.id, this.email, this.password, this.username});

  factory UserModel.fromJson(DocumentSnapshot data) {
    return UserModel(
        id: data['id'],
        email: data['email'],
        password: data['password'],
        username: data['username']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id':id,
      'username':username,
      'password':password,
      'email':email
    };
  }
}
