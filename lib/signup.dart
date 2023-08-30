import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'App_cubit/App_cubit.dart';
import 'App_cubit/App_states.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

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
           // resizeToAvoidBottomInset: false,

            body: Column(
              children: [
                Image.asset('assets/images/registerr.jpg',scale: 12,alignment: Alignment.topCenter,fit: BoxFit.contain ),
                //First row contains word 'Login' only
                const Row(
                    children:[
                      Padding(
                        padding: EdgeInsets.only(left: 20,bottom: 5 , top: 5),
                        child: Text("Signup", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,fontFamily: 'Roboto') ),
                      ),
                    ]),


                SingleChildScrollView(
                    child: Stack(
                        children: <Widget>[
                          Column(children: [
                            //Name text box
                            Padding(
                              padding: const EdgeInsets.only(left: 20,right: 20,bottom: 8),
                              child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Name",
                                    prefixIcon: Icon(Icons.perm_identity)
                                ),
                              ),
                            ),
                            //Email text box
                            Padding(
                              padding: const EdgeInsets.only(left: 20,right: 20,bottom: 8),
                              child: TextFormField(
                                keyboardType: TextInputType.emailAddress,

                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Email",
                                    prefixIcon: Icon(Icons.mail_outline_rounded)
                                ),
                              ),
                            ),
                            //؛Phone text box
                            Padding(
                              padding:  const EdgeInsets.only(left: 20,right: 20,bottom: 8),
                              child: TextFormField(
                                keyboardType: TextInputType.phone,
                                enableSuggestions: true,
                                decoration:  const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Phone",
                                  prefixIcon: Icon(Icons.phone),
                                ),),
                            ),
                            //Password text box
                            Padding(
                              padding:  const EdgeInsets.only(left: 20,right: 20,bottom: 8),
                              child: TextFormField(
                                keyboardType: TextInputType.visiblePassword,

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
                            //Confirm password text box
                            Padding(
                              padding:  const EdgeInsets.only(left: 20,right: 20,bottom: 8),
                              child: TextFormField(
                                keyboardType: TextInputType.visiblePassword,

                                obscureText: cubit.hidePassword,
                                enableSuggestions: false,
                                autocorrect: false,
                                decoration:  InputDecoration(
                                    border: const OutlineInputBorder(),
                                    labelText: "Confirm password",
                                    prefixIcon: const Icon(Icons.password),
                                    suffixIcon: GestureDetector(child:(cubit.hidePassword) ?const Icon(Icons.remove_red_eye_outlined):const Icon(Icons.remove_red_eye_rounded), onTap:(){
                                      cubit.switchPasswordVisibility();
                                    },)
                                ),),
                            ),
                            //Age text box
                            Padding(
                              padding: const EdgeInsets.only(left: 20,right: 20,bottom: 8),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Age",
                                    prefixIcon: Icon(Icons.date_range_rounded)
                                ),
                              ),
                            ),
                            //Height text box
                            Padding(
                              padding: const EdgeInsets.only(left: 20,right: 20,bottom: 8),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Height",
                                    prefixIcon: Icon(Icons.height)
                                ),
                              ),
                            ),],)

                        ]
                    )
                ),

                //TODO: Add action when signup button is pressed
                //Signup button
                TextButton(
                    onPressed: (){},
                    style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(horizontal:170,vertical: 15)
                    ),
                    child: const Text("Signup")
                ),
                //Last row contains login text and button
                Row(
                    children:[
                      const Padding(
                        padding: EdgeInsets.only(left: 30 ),
                        child: Text("Joined us before?", style: TextStyle(fontFamily: 'Roboto',color: Colors.grey)),
                      ),
                      //TODO: Add action when register button is pressed
                      TextButton(onPressed: (){
                        Navigator.pop(context);
                      }, child: const Text("Login"))
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
