import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iclub/App_cubit/App_cubit.dart';
import 'package:iclub/login.dart';
import 'MyBlocObserver.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //SharedPreferences prefs =await SharedPreferences.getInstance();
 // email=prefs.getString("email");
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context)=>AppCubit()..createDatabase(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true,
          ),
          home:LoginApp()  //email==null?LoginApp():const Home()
      )
    );
  }
}

