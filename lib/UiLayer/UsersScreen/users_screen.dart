import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gieco_west/UiLayer/UsersScreen/Cubit/users_screen_view_model.dart';
import 'package:gieco_west/UiLayer/UsersScreen/users_states.dart';
import 'package:gieco_west/Utils/const.dart';
import 'package:gieco_west/Utils/widgets/custom_text_wgt.dart';
import 'package:gieco_west/Utils/widgets/user_active_row.dart';

class UsersScreen extends StatefulWidget {
  UsersScreen({Key? key}) : super(key: key);

  static String routeName = "usersScreen";

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  UsersScreenViewModel viewModel = UsersScreenViewModel();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UsersScreenViewModel, UsersStates>(
      listener: (context, state) {
        if (state is UsersActiveLoadingState) {
          EasyLoading.show(status: 'جاري التحميل.....');
        } else if (state is UsersActiveErrorState) {
          EasyLoading.dismiss();
          EasyLoading.showError(state.errorMsg ?? "");
        } else if (state is UsersActiveSuccessState) {
          EasyLoading.dismiss();
        }
      },
      bloc: viewModel..fetchUser(),
      builder: (context, state) {
        return Scaffold(
            resizeToAvoidBottomInset: true,
            drawerEnableOpenDragGesture: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              centerTitle: true,
              title: const CustomTextWgt(
                data: "فريق العمل",
                fontSize: 22,
              ),
              automaticallyImplyLeading: true,
            ),
            body: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(Const.scaffoldImage),
                      fit: BoxFit.fill,
                      colorFilter: ColorFilter.mode(
                        Colors.white.withOpacity(0.05),
                        BlendMode.dstATop,
                      ),
                    ),
                  ),
                ),
                state is UsersLoadingState
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : state is UsersErrorState
                        ? Center(
                            child: CustomTextWgt(
                            data: state.errorMsg ?? "",
                          ))
                        : AnimationLimiter(
                            child: ListView.separated(
                                separatorBuilder: (context, index) {
                                  return const Divider(
                                    thickness: 2,
                                  );
                                },
                                itemCount: viewModel.users.length,
                                physics: const BouncingScrollPhysics(
                                    parent: AlwaysScrollableScrollPhysics()),

                                // physics: const ScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return AnimationConfiguration.staggeredGrid(
                                    position: index,
                                    duration: const Duration(milliseconds: 600),
                                    columnCount: 2,
                                    child: ScaleAnimation(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.fastLinearToSlowEaseIn,
                                      scale: 1.5,
                                      child: UserActiveRow(
                                          user: viewModel.users[index],
                                          userActiveFun: (isActive) {
                                            viewModel.activeUser(
                                                viewModel.users[index]!,
                                                isActive);
                                            setState(() {});
                                            // viewModel.users[index]?.active! = isActive;
                                          }),
                                    ),
                                  );
                                }),
                          )
              ],
            ));
      },
    );
  }
}
