import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:les_store_app/provider/user_provder.dart';
import 'package:les_store_app/views/authentication/login_screen.dart';
import 'package:les_store_app/views/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  //run the flutter app wrapped in a providerscope
  //pupose: for managing state

  runApp(ProviderScope(child: StoreApp()));
}

// ganti stateless ke consumer untuk data statenya
class StoreApp extends ConsumerWidget {
  const StoreApp({super.key});

  // create a method to check the token from user is available or no
  Future<void> checkUserToken(WidgetRef ref) async {
    // obtain an instance of sharedpreference for local data storage /state
    SharedPreferences preferences = await SharedPreferences.getInstance();
    //Retrive the authentication token and user data stored locally
    String? tokenData = preferences.getString('auth_token');
    String? userJsonData = preferences.getString('user');

    //check both token and userJsonData is available, update the user state
    if (tokenData != null && userJsonData != null) {
      ref.read(userProvder.notifier).setUser(userJsonData);
    } else {
      ref.read(userProvder.notifier).signOut();
    }
  }

  @override // tambahin WidgetRef ref
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: checkUserToken(ref),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final currentUser = ref.watch(userProvder);

          return currentUser != null ? MainScreen() : LoginScreen();
        },
      ),
    );
  }
}
