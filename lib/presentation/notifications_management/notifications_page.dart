import 'package:advocate_project_flutter/presentation/common_widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(
        isBack: true,
        pageTitle: "Notifications",
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Center(
              child: Text("No Unread Notifications"),
            ),
          ),
        ));
  }
}
