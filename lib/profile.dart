import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'App_cubit/App_cubit.dart';
import 'App_cubit/App_states.dart';



class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context){
    AppCubit cubit=BlocProvider.of<AppCubit>(context);
    return BlocBuilder<AppCubit,AppStates>(
        builder: (BuildContext context,dynamic state){
          return  Scaffold(
              appBar: AppBar(title:const Text("Profile")),
              body:  Center(
                child: Column(

                  children: [
                    const Icon(Icons.account_circle,size: 150,color: Colors.black),
                    Text(cubit.user.name,style: const TextStyle(color: Colors.black,fontSize: 40),textAlign: TextAlign.center,),
                    Text(cubit.user.email,style: const TextStyle(color: Colors.black,fontSize: 15),textAlign: TextAlign.center,),
                    Text('0${cubit.user.phone}',style: const TextStyle(color: Colors.black,fontSize: 30),textAlign: TextAlign.center,),
                    Text(cubit.user.age.toString(),style: const TextStyle(color: Colors.black,fontSize: 30),textAlign: TextAlign.center,),
                    Text(cubit.user.height.toString(),style: const TextStyle(color: Colors.black,fontSize: 30),textAlign: TextAlign.center),
                    ElevatedButton(onPressed: (){
                      cubit.logout();
                      Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
                    }, child: const Text("Logout"))
                  ],
                ),
              ),
          );


        }
    );

  }
}
