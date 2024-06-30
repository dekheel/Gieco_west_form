abstract class AuthStates {}

class AuthInitialState extends AuthStates {}

class AuthLoadingState extends AuthStates {}

class AuthSuccessState extends AuthStates {}

class ShowPassState extends AuthStates {}

class HidePassState extends AuthStates {}

class AuthErrorState extends AuthStates {
  String? errorMsg;

  AuthErrorState({this.errorMsg});
}
