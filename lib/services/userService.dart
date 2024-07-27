import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/models/usermodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('Users');

  Future<UserCredential?> registerUser(UserModel user) async {
    try {
      UserModel().toMap();
      UserCredential userdata = await _auth.createUserWithEmailAndPassword(
          email: user.email.toString(), password: user.password.toString());

      await _userCollection.doc(userdata.user!.uid).set({
        'id': userdata.user!.uid,
        'email': userdata.user!.email,
        'password': user.password,
        'username': user.username,
      });
      return userdata;
    } on FirebaseAuthException {
      rethrow;
    }
  }

  Future<DocumentSnapshot?> loginUser(UserModel user) async {
    DocumentSnapshot docs;
    SharedPreferences pref = await SharedPreferences.getInstance();

    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: user.email.toString(), password: user.password.toString());
    String? token =await userCredential.user!.getIdToken();
    docs = await _userCollection.doc(userCredential.user?.uid).get();
    await pref.setString('token', token!);
    await pref.setString('email', docs['email']);
    await pref.setString('password', docs['password']);
    return docs;
  }
}
