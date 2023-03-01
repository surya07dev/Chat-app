import 'package:chat_app/constants/firestore_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserChat {
  String id;
  String photoURL;
  String nickName;
  String aboutMe;
  String phoneNumber;

  UserChat({
    required this.id,
    required this.aboutMe,
    required this.nickName,
    required this.phoneNumber,
    required this.photoURL,
  });

  Map<String, String> toJson() {
    return {
      FirestoreConstants.nickname: nickName,
      FirestoreConstants.aboutMe: aboutMe,
      FirestoreConstants.photoUrl: photoURL,
      FirestoreConstants.phoneNumber: phoneNumber,
    };
  }

  factory UserChat.fromDocument(DocumentSnapshot doc) {
    String aboutMe = "";
    String photoURL = "";
    String nickName = "";
    String phoneNumber = "";

    try {
      aboutMe = doc.get(FirestoreConstants.aboutMe);
    } catch (e) {}
    try {
      aboutMe = doc.get(FirestoreConstants.photoUrl);
    } catch (e) {}
    try {
      aboutMe = doc.get(FirestoreConstants.nickname);
    } catch (e) {}
    try {
      aboutMe = doc.get(FirestoreConstants.phoneNumber);
    } catch (e) {}

    return UserChat(
        id: doc.id,
        aboutMe: aboutMe,
        nickName: nickName,
        phoneNumber: phoneNumber,
        photoURL: photoURL);
  }
}
