// ignore_for_file: empty_catches

import 'package:chat_app/constants/firestore_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserChat {
  String id;
  String photoUrl;
  String nickName;
  String aboutMe;

  UserChat({
    required this.id,
    required this.aboutMe,
    required this.nickName,
    required this.photoUrl,
  });

  Map<String, String> toJson() {
    return {
      FirestoreConstants.nickname: nickName,
      FirestoreConstants.aboutMe: aboutMe,
      FirestoreConstants.photoUrl: photoUrl,
    };
  }

  factory UserChat.fromDocument(DocumentSnapshot doc) {
    String aboutMe = "";
    String photoUrl = "";
    String nickName = "";

    try {
      aboutMe = doc.get(FirestoreConstants.aboutMe);
    } catch (e) {}
    try {
      nickName = doc.get(FirestoreConstants.nickname);
    } catch (e) {}
    try {
      photoUrl = doc.get(FirestoreConstants.photoUrl);
    } catch (e) {}

    return UserChat(
      id: doc.id,
      aboutMe: aboutMe,
      nickName: nickName,
      photoUrl: photoUrl,
    );
  }
}
