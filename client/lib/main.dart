import 'package:client/app/auth/login.dart';
import 'package:client/app/auth/signup.dart';
import 'package:client/app/auth/success.dart';
import 'package:client/app/home.dart';
import 'package:client/app/notes/add.dart';
import 'package:client/app/notes/edit.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPref;

// This is the entry point of our Flutter application.
// The 'main' function is the starting point of all Dart applications.
//
// In our case, this is where we initialize our Flutter application and
// set it up to run on the device or simulator.

void main() async {
  // Ensure that the Flutter framework has been fully initialized before
  // we start running our application.
  //
  // This is necessary because certain Flutter APIs may depend on the
  // framework being initialized.
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize our SharedPreferences instance. 
  // SharedPreferences is a key-value store for simple data persistence.
  // We use it to store our user's authentication token and other settings.
  //
  // The 'await' keyword is used to wait for the initialization to complete.
  // This is necessary because the initialization process involves reading
  // and writing to disk, which can take some time.
  sharedPref = await SharedPreferences.getInstance();

  // Run our application.
  //
  // The 'const' keyword is used to create an instance of the MyApp widget that
  // cannot change over time. This is because the MyApp widget is a constant
  // and does not need to be rebuilt.
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  // This build method returns a MaterialApp widget that defines the root of our application.
  // The MaterialApp widget is a high-level widget that provides many useful things to our app,
  // such as app-wide theming, navigation, and a default set of material design widgets.
  //
  // The MaterialApp widget takes a number of arguments, including a title, a theme, and a set of routes.
  // The title is the name of our app, and the theme defines the visual style of our app.
  // The routes argument is a map that defines the different routes in our app.
  // Each route is defined as a pair of a URL-like string (the key) and a widget (the value).
  // When the user navigates to a route, Flutter will look up the corresponding widget in the map and show it.
  Widget build(BuildContext context) {
    // Check if the user is already logged in by checking if they have a saved ID.
    // If they are not logged in, set the initial route to 'login'.
    // If they are logged in, set the initial route to 'home'.
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hide the debug banner that shows the device's frame rate.
      title: 'Flutter Demo', // Set the title of our app.
      initialRoute: sharedPref.getString("id") == null ? 'login' : 'home', // Set the initial route based on the user's login status.
      routes: {
        // Define the different routes in our app.
        // The 'login' route is defined as a constant instance of the Login widget.
        'login': (context) => const Login(), // Show the Login widget when the user navigates to the 'login' route.
        // The 'signup' route is defined as a constant instance of the SignUp widget.
        'signup': (context) => const SignUp(), // Show the SignUp widget when the user navigates to the 'signup' route.
        // The 'home' route is defined as a constant instance of the Home widget.
        'home': (context) => const Home(), // Show the Home widget when the user navigates to the 'home' route.
        // The 'success' route is defined as a constant instance of the Success widget.
        'success': (context) => const Success(), // Show the Success widget when the user navigates to the 'success' route.
        // The 'addnotes' route is defined as a constant instance of the AddNotes widget.
        'addnotes': (context) => const AddNotes(), // Show the AddNotes widget when the user navigates to the 'addnotes' route.
        // The 'editnots' route is defined as a constant instance of the EditNotes widget.
        'editnots': (context) => const EditNotes(), // Show the EditNotes widget when the user navigates to the 'editnots' route.
      },
    );
  }
}
