import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:iclub/App_cubit/App_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() :super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  bool hidePassword = true;
  String? emailcheck;
  String? passwordcheck;
  bool uniqueEmail=false;
  late Database database;

  var nameController = new TextEditingController();
  var emailController = new TextEditingController();
  var phoneController = new TextEditingController();
  var passwordController = new TextEditingController();
  var confirmPasswordController = TextEditingController();
  var ageController = new TextEditingController();
  var heightController = new TextEditingController();

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
          'Insert into user (name,email,phone,password,age,height) VALUES ("${name}","${email}","${phone}","${password}",${age},${height})')
          .then((value) {
        print("$value insteresd successfully");
        emit(insertToDatabaseState());
        getDataFromDatabase(database: database);
      }).catchError((onError) {
        print("inserting Error is ${onError.toString()}");
      });
    });
  }

  //Get from database
  List<Map> users = [];

  void getDataFromDatabase({
    required Database database
  }) {
    database.rawQuery("Select * from user").then((value) {
      users = value;
      emit(getDataFromDatabaseState());
      print(users);
    });
  }

  void switchPasswordVisibility() {
    if (hidePassword) {
      hidePassword = false;
    } else {
      hidePassword = true;
    }
    emit(ShowPasswordState());
  }

  void wrongEmail({
    required String email}) {
    database.rawQuery('SELECT * FROM user WHERE email = "${email}"').then((
        value) {
      if (value.isEmpty) {
        emailcheck = "NO ACCOUNT WITH THIS EMAIL!";
      }
      else{
        emailcheck=null;
      }
    });
    emit(WrongEmailState());
  }
  void wrongPassword({
    required String password}) {
    database.rawQuery('SELECT * FROM user WHERE password = "${password}"').then((
        value) {
      if (value.isEmpty) {
        passwordcheck = "NO ACCOUNT WITH THIS PASSWORD!";
      }
      else{
        passwordcheck=null;
      }
    });
    emit(WrongPasswordState());
  }
  void uniqueEmailCheck({
    required String email}) {
    database.rawQuery('SELECT * FROM user WHERE email = "${email}"').then((
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
