import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:les_store_app/models/user.dart';

class UserProvder extends StateNotifier<User?> {
  // constructure initializing the default value of user object
  // purpose: manage the state of the user object allowing updates
  UserProvder()
    : super(
        User(
          id: '',
          fullName: '',
          email: '',
          state: '',
          city: '',
          locality: '',
          password: '',
          token: '',
        ),
      );

  // getter method to extract value from an object
  User? get user => state;

  //method to set user state from Json
  // purpose: updates the user state based on json string representation of user object
  void setUser(String userJson) {
    state = User.fromJson(userJson);
  }

  // method to c{lear user state
  void signOut() {
    state = null;
  }
}

//make the data accessible within the application
final userProvder = StateNotifierProvider<UserProvder, User?>(
  (ref) => UserProvder(),
);
