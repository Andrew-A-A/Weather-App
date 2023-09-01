import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iclub/profile.dart';

import 'App_cubit/App_cubit.dart';
import 'App_cubit/App_states.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context){
    AppCubit cubit=BlocProvider.of<AppCubit>(context);


      cubit.getCurrentUserInfo(email: cubit.emailController.text);



    return BlocBuilder<AppCubit,AppStates>(
        builder: (BuildContext context,dynamic state){
          return   WillPopScope(
            onWillPop: () async =>false ,
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: const Text("WELCOME"),
                actions: <Widget>[
                  IconButton(onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> const Profile()));
                  }, icon: const Icon(Icons.account_circle_outlined,size: 40,))
                ],

              ),


            ),
          );

        }
    );

  }
}
