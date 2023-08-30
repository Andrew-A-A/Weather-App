import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:iclub/App_cubit/App_states.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit():super(AppInitialState());

  static AppCubit get(context)=> BlocProvider.of(context);
  bool hidePassword=true;

  late Database database;
  //create database
  void createDatabase() {
    openDatabase(
      'AppDB.db',
      version: 1,
      onCreate: (db, version) {
        print("Database Created");
        db
            .execute(
            "Create Table user (id INTEGER PRIMARY KEY,"
                " name TEXT NOT NULL,email TEXT NOT NULL,"
                "phone INTEGER NOT NULL, "
                "password TEXT NOT NULL,"
                "age INTEGER NOT NULL,"
                "height REAL NOT NULL)")
            .then((value) {
          print("Table created");
        }).catchError((onError) {
          print("Catched Error is ${onError.toString()}");
        });
      },
      onOpen: (db) {
        print("Database Opened");
       // getDataFromDatabase(database: db);
      },
    ).then((value) {
      database = value;
      insertToDatabase();
      getDataFromDatabase();
     // emit(createDatabaseState());
    });
  }

  //Inserting to database
  insertToDatabase(/*{
    required String title,
    required String date,
    required String time
  }*/) async {
    await database.transaction((txn) async {
      txn
          .rawInsert(
         // 'Insert into tasks (title,date,time) VALUES ("${title}","${date}","${time}")')
          'Insert into user (name,email,phone,password,age,height) VALUES ("Wezza","Wezza@gmail.com",01220033535,"Wazwaz1",21,160)')
          .then((value) {
        print("$value insteresd successfully");
        //emit(insertToDatabaseState());
        //getDataFromDatabase(database: database);

      }).catchError((onError) {
        print("inserting Error is ${onError.toString()}");
      });
    });
  }

  //Get from database
  List<Map> users=[];

  void getDataFromDatabase(/*{
    required Database database
  }*/){
    database.rawQuery("Select * from user").then((value){
      users=value;
     // emit(getDataFromDatabaseState());
      print(users);
    });
  }
  void switchPasswordVisibility(){
    if(hidePassword) {
      hidePassword=false;
    } else {
      hidePassword=true;
    }
    emit(ShowPasswordState());
  }
}
