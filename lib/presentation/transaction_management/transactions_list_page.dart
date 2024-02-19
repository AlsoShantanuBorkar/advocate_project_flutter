import 'package:advocate_project_flutter/presentation/common_widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';

class TransactionListPage extends StatelessWidget {
  const TransactionListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      pageTitle: "Transactions",
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return ListTile(
              title: const Text("John Doe"),
              subtitle: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Txn ID: 10"),
                  Text(DateTime(2024).toIso8601String()),
                ],
              ),
              trailing: Chip(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: BorderSide(color: Colors.green.shade900)),
                  backgroundColor: Colors.lightGreen.shade100,
                  label: Text(
                    "Completed",
                    style: TextStyle(color: Colors.green.shade900),
                  )),
            );
          },
        ),
      ),
    );
  }
}
