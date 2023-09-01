

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iclub/Model/User.dart';
import 'package:sqflite/sqflite.dart';
import 'package:iclub/App_cubit/App_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() :super(AppInitialState());
  late User user;
  static AppCubit get(context) => BlocProvider.of(context);
  bool hidePassword = true;
  String? emailcheck;
  String? passwordcheck;
  String? enteredEmail;
  bool uniqueEmail=false;
  bool isLoggedIn=false;
  late Database database;
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var ageController = TextEditingController();
  var heightController = TextEditingController();

  //create database
  void createDatabase() {
    openDatabase(
      'AppDB.db',
      version: 1,
      onCreate: (db, version) {
        if (kDebugMode) {
          print("Database Created");
        }
        db
            .execute(
            "Create Table user (id INTEGER PRIMARY KEY,"
                " name TEXT NOT NULL,email TEXT NOT NULL,"
                "phone INTEGER NOT NULL, "
                "password TEXT NOT NULL,"
                "age INTEGER NOT NULL,"
                "height REAL NOT NULL)")
            .then((value) {
          if (kDebugMode) {
            print("Table created");
          }
        }).catchError((onError) {
          if (kDebugMode) {
            print("Caught Error is ${onError.toString()}");
          }
        });
      },
      onOpen: (db) {
        if (kDebugMode) {
          print("Database Opened");
        }
        getDataFromDatabase(database: db);
      },
    ).then((value) {
      database = value;
      emit(createDatabaseState());
    });
  }



  //Inserting to database
  insertToDatabase({
    required String name,
    required String email,
    required String phone,
    required String password,
    required int age,
    required double height
  }) async {
    await database.transaction((txn) async {
      txn
          .rawInsert(
        // 'Insert into tasks (title,date,time) VALUES ("${title}","${date}","${time}")')
          'Insert into user (name,email,phone,password,age,height) VALUES ("$name","$email","$phone","$password",$age,$height)')
          .then((value) {
        if (kDebugMode) {
          print("$value inserted successfully");
        }
        emit(insertToDatabaseState());
        getDataFromDatabase(database: database);
      }).catchError((onError) {
        if (kDebugMode) {
          print("inserting Error is ${onError.toString()}");
        }
      });
    });
  }

  //Get from database
  List<Map> users = [];

  void getDataFromDatabase({
    required Database database
  }) async {
    await
    database.rawQuery("Select * from user").then((value) {
      users = value;
      emit(getDataFromDatabaseState());
      if (kDebugMode) {
        print(users);
      }
    });
  }
void logout(){
    isLoggedIn=false;
    emailController.clear();
    passwordController.clear();
}

  void switchPasswordVisibility() {
    if (hidePassword) {
      hidePassword = false;
    } else {
      hidePassword = true;
    }
    emit(ShowPasswordState());
  }

void loginSucceeded(){
    isLoggedIn=true;
    emit(LoggedIn());
}
// void getCurrentUserInfo( {required String email , required User user} )  {
//     //'Insert into user (name,email,phone,password,age,height)
//
//   database.rawQuery('SELECT name FROM user WHERE email = "$email"').then((value)
//   {
//   user.name=value as String;
//   });
//
//   database.rawQuery('SELECT password FROM user WHERE email = "$email"').then((value)
//   {
//     user.password=value as String;
//   });
//   database.rawQuery('SELECT phone FROM user WHERE email = "$email"').then((value)
//   {
//     user.phone=value as int;
//   });
//   database.rawQuery('SELECT age FROM user WHERE email = "$email"').then((value)
//   {
//     user.age=value as int;
//   });
//   database.rawQuery('SELECT height FROM user WHERE email = "$email"').then((value)
//   {
//     user.height=value as int;
//   });
//
// }
//

  Future<void> getCurrentUserInfo({required String email}) async {
    //'Insert into user (name,email,phone,password,age,height)

    var name = await database.rawQuery('SELECT name FROM user WHERE email = "$email"');
    var password = await database.rawQuery('SELECT password FROM user WHERE email = "$email"');
    var phone = await database.rawQuery('SELECT phone FROM user WHERE email = "$email"');
    var age = await database.rawQuery('SELECT age FROM user WHERE email = "$email"');
    var height = await database.rawQuery('SELECT height FROM user WHERE email = "$email"');
    user= User(name.first['name'] as String, email,phone.first['phone'] as int, password.first['password'] as String, height.first['height'] as double,age.first['age'] as int);
    emit(ShowUserData());
  }


  void wrongEmail({
    required String email})  async {
    await
    database.rawQuery('SELECT * FROM user WHERE email = "$email"').then((value)
    {
      if (value.isEmpty) {
        emailcheck = "NO ACCOUNT WITH THIS EMAIL!";
      }
      else{
        emailcheck=null;
        enteredEmail=email;
      }
    });
    emit(WrongEmailState());
  }
  void wrongPassword({
    required String password}) async { await
    database.rawQuery('SELECT * FROM user WHERE email = "$enteredEmail" AND password = "$password"').then((
        value) {
      if (value.isEmpty) {
        passwordcheck = "WRONG PASSWORD!";
      }
      else{
        passwordcheck=null;
      }
    });


    emit(WrongPasswordState());
  }
  void uniqueEmailCheck({
    required String email}) async { await
    database.rawQuery('SELECT * FROM user WHERE email = "$email"').then((
        value) {
      if (value.isEmpty) {
        uniqueEmail=true;
      }
      else{
        uniqueEmail=false;
      }
    });
    emit(UniqueEmailState());
  }
}


