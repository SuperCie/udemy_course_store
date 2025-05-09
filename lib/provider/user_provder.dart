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

  //method to recreate user state
  void recreateUserState({
    required String state,
    required String city,
    required String locality,
  }) {
    if (this.state != null) {
      // it means we have some data on provider
      this.state = User(
        id: this.state!.id, // preserver the existing user id
        fullName: this.state!.fullName, // preserver the existing user name
        email: this.state!.email, // preserver the existing user email
        state: state,
        city: city,
        locality: locality,
        password: this.state!.password, // preserver the existing user password
        token: this.state!.token, // preserver the existing user token
      );
    }
  }
}

//make the data accessible within the application
final userProvder = StateNotifierProvider<UserProvder, User?>(
  (ref) => UserProvder(),
);
