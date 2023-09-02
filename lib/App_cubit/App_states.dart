abstract class AppStates{}
class AppInitialState extends AppStates{}

class ShowPasswordState extends AppStates{}

class insertToDatabaseState extends AppStates {}

class createDatabaseState extends AppStates{}

class getDataFromDatabaseState extends AppStates{}

class WrongEmailState extends AppStates{}

class WrongPasswordState extends AppStates{}

class UniqueEmailState extends AppStates{}

class LoggedIn extends AppStates{}

class ShowUserData extends AppStates{}

class RefreshWeatherData extends AppStates{}