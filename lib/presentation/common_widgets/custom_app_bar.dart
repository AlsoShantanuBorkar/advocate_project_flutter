import 'package:advocate_project_flutter/blocs/auth_cubit/auth_cubit.dart';
import 'package:advocate_project_flutter/presentation/notifications_management/notifications_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {super.key,
      required this.pageTitle,
      this.showActions = true,
      this.isBack = false});
  final String pageTitle;
  final bool showActions;
  final bool isBack;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: isBack
          ? GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(Icons.arrow_back),
            )
          : null,
      backgroundColor: Colors.white,
      scrolledUnderElevation: 0,
      centerTitle: false,
      title: Text(
        pageTitle,
        style: const TextStyle(
            fontFamily: "Abhaya Libre",
            fontWeight: FontWeight.w500,
            fontSize: 30),
      ),
      actions: showActions
          ? [
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const NotificationPage()));
                },
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade100,
                  ),
                  child: const Icon(
                    Icons.notifications_outlined,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  context.read<AuthCubit>().onLogout(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade100,
                  ),
                  child: const Icon(Icons.person_outline),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
