import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class LpbpFirebaseUser {
  LpbpFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

LpbpFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<LpbpFirebaseUser> lpbpFirebaseUserStream() => FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<LpbpFirebaseUser>(
      (user) {
        currentUser = LpbpFirebaseUser(user);
        return currentUser!;
      },
    );
