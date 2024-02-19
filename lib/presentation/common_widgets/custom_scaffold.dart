import 'package:advocate_project_flutter/presentation/common_widgets/custom_app_bar.dart';
import 'package:advocate_project_flutter/presentation/common_widgets/custom_app_drawer.dart';
import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold(
      {super.key,
      required this.pageTitle,
      required this.body,
      this.fab,
      this.isBack = false});
  final bool isBack;
  final String pageTitle;
  final Widget body;
  final FloatingActionButton? fab;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: fab,
      appBar: CustomAppBar(pageTitle: pageTitle),
      backgroundColor: Colors.white,
      body: body,
      drawer: isBack ? null : CustomAppDrawer(),
    );
  }
}
