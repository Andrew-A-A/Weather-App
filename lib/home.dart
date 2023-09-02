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
    cubit.fetchWeather();


      return BlocBuilder<AppCubit,AppStates>(
        builder: (BuildContext context,dynamic state){
          return   WillPopScope(
            onWillPop: () async =>false ,
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: const Text("WELCOME"),
                actions: <Widget>[
                  IconButton(onPressed: ()
                    {Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> const Profile()));},
                      icon: const Icon(Icons.account_circle_outlined,size: 40,))
                  ],
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(currentWeatherIcon(cubit.weather!.current.condition.text),size: 200),
                    Text(cubit.weather!.current.condition.text),
                    Text("${cubit.weather!.current.temp.toInt()}℃",style: const TextStyle(fontSize: 30),),
                    Text("Feels like: ${cubit.weather!.current.feelsLike.toInt()}℃"),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Wind Direction: "),
                        Icon(currentDirectionIcon(cubit.weather!.current.windDirection),size: 20,),
                      ],
                    ),
                  ElevatedButton(onPressed: (){
                    cubit.fetchWeather();
                    cubit.emit(RefreshWeatherData());

                  }, child: Text("Refresh"))
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}

IconData currentWeatherIcon(String txt){
  switch (txt){
    case "Sunny":
      return Icons.sunny;
    case "Cloudy":
      return Icons.wb_cloudy_rounded;
    case "Fog":
      return Icons.foggy;
    default:
      return Icons.water_drop;

  }


}
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
