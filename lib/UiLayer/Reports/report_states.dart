abstract class CreateReportStates {}

class CreateReportInitialState extends CreateReportStates {}

class CreateReportLoadingState extends CreateReportStates {}

class CreateReportSuccessState extends CreateReportStates {}

class CreateReportErrorState extends CreateReportStates {
  String? errorMsg;

  CreateReportErrorState({this.errorMsg});
}
