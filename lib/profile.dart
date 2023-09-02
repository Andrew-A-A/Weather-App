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
              appBar: AppBar(title:const Text("Profile"),backgroundColor: Colors.blue,),
              body:  Center(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 25),
                      width: double.infinity,
                      decoration: const BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.vertical(bottom:Radius.circular(40)),),
                      child: Column(
                        children: [
                          const Icon(Icons.account_circle,size: 200,color: Colors.white),
                          Text(cubit.user.name,style: const TextStyle(color: Colors.white,fontSize: 50),textAlign: TextAlign.center,),
                          const SizedBox(height: 2,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.email,size: 30,color: Colors.white,),
                              const SizedBox(width: 5),
                              Text(cubit.user.email,style: const TextStyle(color: Colors.white,fontSize: 20),textAlign: TextAlign.center,),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.phone,size:35),
                        const SizedBox(width: 5),
                        Text('0${cubit.user.phone}',style: const TextStyle(color: Colors.black,fontSize: 30),textAlign: TextAlign.center,),
                      ],
                    ),
                    Text("Age: ${cubit.user.age.toString()}",style: const TextStyle(color: Colors.black,fontSize: 30),textAlign: TextAlign.center,),
                    Text("Height: ${cubit.user.height.toString()}",style: const TextStyle(color: Colors.black,fontSize: 30),textAlign: TextAlign.center),
                    ElevatedButton(onPressed: (){
                      cubit.logout();
                      Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
                    },
                        child: const Text("Logout")),
                    const Icon(Icons.flutter_dash_outlined,size: 150,color: Colors.blue)
                  ],
                ),
              ),
          );
        }
    );
  }
}
