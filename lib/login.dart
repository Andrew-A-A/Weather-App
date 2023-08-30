import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iclub/signup.dart';

import 'App_cubit/App_cubit.dart';
import 'App_cubit/App_states.dart';

var emailController = TextEditingController();
var passwordController = TextEditingController();

class LoginApp extends StatelessWidget {
   const LoginApp({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppCubit>(
      create: (context) =>
      AppCubit()
        ..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return  Scaffold(
            resizeToAvoidBottomInset: false,
            body: Column(
              children: [
                Image.asset('assets/images/login.jpg',scale: 6,alignment: Alignment.topCenter,fit: BoxFit.contain ),
                //First row contains word 'Login' only
                const Row(
                    children:[
                      Padding(
                        padding: EdgeInsets.only(left: 20,bottom: 15 , top: 15),
                        child: Text("Login", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,fontFamily: 'Roboto') ),
                      ),
                    ]),
                //Email text box
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Email",
                        prefixIcon: Icon(Icons.mail_outline_rounded)
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                //Password text box
                Padding(
                  padding:  const EdgeInsets.only(left: 20,right: 20,bottom: 20),
                  child: TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: passwordController,
                    obscureText: cubit.hidePassword,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration:  InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: "Password",
                        prefixIcon: const Icon(Icons.password),
                      suffixIcon: GestureDetector(child:(cubit.hidePassword) ?const Icon(Icons.remove_red_eye_outlined):const Icon(Icons.remove_red_eye_rounded), onTap:(){
                        cubit.switchPasswordVisibility();
                        },)
                    ),),
                ),
                //TODO: Add action when login button is pressed
                //Login button
                TextButton(
                    onPressed: (){},
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blueAccent,
                      padding: const EdgeInsets.symmetric(horizontal:170,vertical: 15)
                ),
                    child: const Text("Login")
                ),
                 const SizedBox(height: 20),
                 //Last row contains signup text and button
                 Row(
                    children:[
                      const Padding(
                        padding: EdgeInsets.only(left: 30 ),
                        child: Text("New to the app?", style: TextStyle(fontFamily: 'Roboto',color: Colors.grey)),
                      ),
                      //TODO: Add action when register button is pressed
                      TextButton(onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> const Signup()));
                      }, child: const Text("Register"))
                    ]
                 )
              ],
            ),
          );
        },
      ),
    );
  }
}