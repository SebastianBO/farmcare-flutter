import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class FarmCareFirebaseUser {
  FarmCareFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

FarmCareFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<FarmCareFirebaseUser> farmCareFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<FarmCareFirebaseUser>(
            (user) => currentUser = FarmCareFirebaseUser(user));
