import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'App_cubit/App_cubit.dart';
import 'App_cubit/App_states.dart';


class Signup extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  //Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppCubit>(
      create: (context) =>
      AppCubit()
        ..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is insertToDatabaseState){
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return  Scaffold(
            resizeToAvoidBottomInset: true,

            body: SingleChildScrollView(
              child: Column(
                children:<Widget>[
                  Image.asset('assets/images/registerr.jpg',scale: 12,alignment: Alignment.topCenter,fit: BoxFit.contain ),
                  //First row contains word 'Login' only
                  const Row(
                      children:[
                        Padding(
                          padding: EdgeInsets.only(left: 20,bottom: 5 , top: 5),
                          child: Text("Signup", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,fontFamily: 'Roboto') ),
                        ),
                      ]),

                              Form(
                                  key:formKey,
                                  child: Column(
                                    children:[//Name text box
                              Padding(
                                padding: const EdgeInsets.only(left: 20,right: 20,bottom: 8),
                                child: TextFormField(
                                  controller: cubit.nameController,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: "Name",
                                      prefixIcon: Icon(Icons.perm_identity)
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Name Must Not Be Empty";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              //Email text box
                              Padding(
                                padding: const EdgeInsets.only(left: 20,right: 20,bottom: 8),
                                child: TextFormField(
                                  controller: cubit.emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: "Email",
                                      prefixIcon: Icon(Icons.mail_outline_rounded)
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Email Must Not Be Empty";
                                    }
                                    if(!value!.contains("@")){
                                      return "Email Must Contain @";
                                    }
                                    cubit.uniqueEmailCheck(email: value);
                                    if(!cubit.uniqueEmail){
                                      return "THIS EMAIL ALREADY REGESTERED!!";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              //؛Phone text box
                              Padding(
                                padding:  const EdgeInsets.only(left: 20,right: 20,bottom: 8),
                                child: TextFormField(
                                  controller: cubit.phoneController,
                                  keyboardType: TextInputType.phone,
                                  textInputAction: TextInputAction.next,
                                  enableSuggestions: true,
                                  decoration:  const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Phone",
                                    prefixIcon: Icon(Icons.phone),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Phone Must Not Be Empty";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              //Password text box
                              Padding(
                                padding:  const EdgeInsets.only(left: 20,right: 20,bottom: 8),
                                child: TextFormField(
                                  controller: cubit.passwordController,
                                  keyboardType: TextInputType.visiblePassword,
                                  textInputAction: TextInputAction.next,
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
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Password Must Not Be Empty";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              //Confirm password text box
                              Padding(
                                padding:  const EdgeInsets.only(left: 20,right: 20,bottom: 8),
                                child: TextFormField(
                                  controller: cubit.confirmPasswordController,
                                  keyboardType: TextInputType.visiblePassword,
                                  textInputAction: TextInputAction.next,
                                  obscureText: cubit.hidePassword,
                                  enableSuggestions: false,
                                  autocorrect: false,
                                  decoration:  const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: "Confirm password",
                                      prefixIcon: Icon(Icons.password),

                                  ),
                                  validator: (value) {
                                    if (value! != cubit.passwordController.text) {
                                      return 'Passwords do not match';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              //Age text box
                              Padding(
                                padding: const EdgeInsets.only(left: 20,right: 20/*,bottom: 8*/),
                                child: TextFormField(
                                  controller: cubit.ageController,
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: "Age",
                                      prefixIcon: Icon(Icons.date_range_rounded)
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Age Must Not Be Empty";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              //Height text box
                              Padding(
                                padding: const EdgeInsets.only(left: 20,right: 20/*,bottom: 8*/),
                                child: TextFormField(
                                  controller: cubit.heightController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: "Height",
                                      prefixIcon: Icon(Icons.height),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Height Must Not Be Empty";
                                    }
                                    return null;
                                  },
                                ),
                              ),
        ],
                                  ),
                              ),
                  //TODO: Add action when signup button is pressed
                  //Signup button
                  ElevatedButton(
                      onPressed: (){
                        if(cubit.passwordController.text==cubit.confirmPasswordController.text){
                        if (formKey.currentState!.validate()) {
                          cubit.insertToDatabase(
                              name: cubit.nameController.text,
                              email: cubit.emailController.text,
                              phone: cubit.phoneController.text,
                            password:cubit.passwordController.text,
                            age: int.parse(cubit.ageController.text),
                            height: double.parse(cubit.heightController.text)
                          );
                        }
                        }
                      },
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
            ),
          );
        },
      ),
    );
  }
}
