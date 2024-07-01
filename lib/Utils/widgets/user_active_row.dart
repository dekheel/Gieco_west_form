import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gieco_west/DataLayer/Model/my_user.dart';
import 'package:gieco_west/Utils/widgets/custom_text_wgt.dart';

class UserActiveRow extends StatelessWidget {
  UserActiveRow({required this.user, required this.userActiveFun, super.key});

  void Function(bool)? userActiveFun;
  final MyUser? user;

  @override
  Widget build(BuildContext context) {
    return FadeInAnimation(
      child: ListTile(
        title: CustomTextWgt(
          data: user!.name!,
        ),
        // onTap: () {},
        trailing: CupertinoSwitch(
            trackColor: Colors.red,
            value: user!.active!,
            onChanged: userActiveFun),
      ),
    );
  }
}
