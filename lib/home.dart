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
    //Fetch logged in user data from database
    cubit.getCurrentUserInfo(email: cubit.emailController.text);
    //Fetch weather data from the API
    cubit.fetchWeather();
    return BlocBuilder<AppCubit,AppStates>(
        builder: (BuildContext context,dynamic state){
          //Use WillPopScope to prevent usage of the back button
          return   WillPopScope(
            onWillPop: () async =>false ,
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: const Text("WELCOME"),
                actions: <Widget>[
                  IconButton(onPressed: ()
                    {Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> const Profile()));},
                      icon: const Icon(Icons.account_circle_outlined,size: 40,color: Colors.blue))
                  ],
              ),
              //Rounded box container
              body: Container(
                margin: const EdgeInsets.symmetric(vertical: 150,horizontal: 50),
                decoration: const BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.all(Radius.circular(40)),),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(currentWeatherIcon(cubit.weather.current.condition.text),size: 200,color: Colors.white,),
                    Text(cubit.weather.current.condition.text,style: const TextStyle(fontSize: 20,color: Colors.white),),
                    Text("${cubit.weather.current.temp.toInt()}℃",style: const TextStyle(fontSize: 30,color: Colors.white),),
                    Text("Feels like: ${cubit.weather.current.feelsLike.toInt()}℃",style: const TextStyle(color: Colors.white)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Wind Direction: ",style: TextStyle(color: Colors.white)),
                        Icon(currentDirectionIcon(cubit.weather.current.windDirection),size: 20,color: Colors.white,),
                      ],
                    ),
                  ElevatedButton(onPressed: (){
                    cubit.fetchWeather();
                    }, child: const Text("Refresh"))
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}

//Function returns icon for each state of the weather
IconData currentWeatherIcon(String txt){
  switch (txt){
    case "Sunny":
      return Icons.sunny;
    case"Clear":
      return Icons.nightlight_round_rounded;
    case "Cloudy":
      return Icons.wb_cloudy_rounded;
    case "Fog":
      return Icons.foggy;
    case "Partly cloudy":
      return Icons.cloud_queue_sharp;
    case "Error in API":
      return Icons.error_outline_rounded;
    default:
      return Icons.water_drop;

  }


}

//Function returns icon for each direction of the wind
IconData currentDirectionIcon(String txt){
  switch (txt){
    case "N":
      return Icons.north;
    case "S":
      return Icons.south;
    case "E":
      return Icons.east;
    default:
      return Icons.west;

  }


}
