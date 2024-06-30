abstract class ReportStates {}

class ReportInitialState extends ReportStates {}

class ReportLoadingState extends ReportStates {}

class ReportSuccessState extends ReportStates {}

class ResetFormState extends ReportStates {}

class UploadImageErrorState extends ReportStates {
  String? errorMsg;
  UploadImageErrorState({this.errorMsg});
}

class UploadImageSuccessState extends ReportStates {}

class UploadImageLoadingState extends ReportStates {}

class ReportErrorState extends ReportStates {
  String? errorMsg;

  ReportErrorState({this.errorMsg});
}
