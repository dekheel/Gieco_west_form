import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gieco_west/DataLayer/Api/firebase_utils.dart';
import 'package:gieco_west/DataLayer/Model/my_user.dart';
import 'package:gieco_west/UiLayer/UsersScreen/users_states.dart';

class UsersScreenViewModel extends Cubit<UsersStates> {
  UsersScreenViewModel({Key? key}) : super(UsersInitialState());

  List<MyUser?> users = [];

  void fetchUser() async {
    emit(UsersLoadingState());
    var snapShots = await FirebaseUtils.getInstance().fetchUserFromFirestore();
    if (snapShots.docs.isEmpty) {
      emit(UsersErrorState(errorMsg: "No users found"));
    } else {
      emit(UsersSuccessState());
      users = snapShots.docs.map((e) => e.data()).toList();
    }
  }

  void activeUser(MyUser user, bool isActive) async {
    emit(UsersActiveLoadingState());
    var either =
        await FirebaseUtils.getInstance().activeUser(user.id!, isActive);
    either.fold((l) {
      emit(UsersActiveErrorState(errorMsg: l.errorMessage));
    }, (response) {
      emit(UsersActiveSuccessState());
    });
  }
}
