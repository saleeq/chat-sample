
import 'package:chat_app/view_states/home_state.dart';
import 'package:chat_app/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

   @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => HomeState()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.red,
            primaryColor: Colors.red.shade800,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          supportedLocales: const [Locale('en')],
          home: SplashView(),
        )
    );
  }

}


