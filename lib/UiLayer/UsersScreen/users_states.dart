abstract class UsersStates {}

class UsersInitialState extends UsersStates {}

class UsersLoadingState extends UsersStates {}

class UsersSuccessState extends UsersStates {}

class UsersErrorState extends UsersStates {
  String? errorMsg;
  UsersErrorState({this.errorMsg});
}

class UsersActiveLoadingState extends UsersStates {}

class UsersActiveSuccessState extends UsersStates {}

class UsersActiveErrorState extends UsersStates {
  String? errorMsg;
  UsersActiveErrorState({this.errorMsg});
}
