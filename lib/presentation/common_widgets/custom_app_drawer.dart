import 'package:advocate_project_flutter/constants/enums/page_enums.dart';
import 'package:advocate_project_flutter/presentation/case_management/case_list_page.dart';
import 'package:advocate_project_flutter/presentation/common_widgets/custom_scaffold.dart';
import 'package:advocate_project_flutter/presentation/dashboard/dashboard_page.dart';
import 'package:advocate_project_flutter/presentation/scheduler/scheduler_page.dart';
import 'package:advocate_project_flutter/presentation/task_management/task_list_page.dart';
import 'package:advocate_project_flutter/presentation/team_management/team_list_page.dart';
import 'package:advocate_project_flutter/presentation/transaction_management/transactions_list_page.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

PageEnum _currentPage = PageEnum.Dashboard;

class CustomAppDrawer extends StatelessWidget {
  const CustomAppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const BeveledRectangleBorder(),
      backgroundColor: Theme.of(context).primaryColor,
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ListTile(
              leading: SvgPicture.asset("assets/icons/app_icon.svg"),
              tileColor: Colors.transparent,
              title: const Text(
                "Dash",
                style: TextStyle(
                    fontFamily: "Abhaya Libre",
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 30),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ListView(
              padding: const EdgeInsets.only(left: 20),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    "MAIN MENU",
                    style: TextStyle(
                        fontFamily: "Abhaya Libre",
                        color: Theme.of(context).secondaryHeaderColor),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const _CustomDrawerTile(
                  currentValue: PageEnum.Dashboard,
                  title: "Dashboard",
                  icon: Icon(
                    Icons.message_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                _CustomDrawerTile(
                  currentValue: PageEnum.CaseListPage,
                  title: "Cases",
                  icon: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: Icon(
                      Icons.bar_chart_outlined,
                      color: Theme.of(context).primaryColor,
                      size: 20,
                    ),
                  ),
                ),
                const _CustomDrawerTile(
                  currentValue: PageEnum.TaskListPage,
                  title: "Tasks",
                  icon: Icon(
                    Icons.task_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const _CustomDrawerTile(
                  currentValue: PageEnum.SchedulerPage,
                  title: "Scheduler",
                  icon: Icon(
                    Icons.task_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const _CustomDrawerTile(
                  currentValue: PageEnum.TeamListPage,
                  title: "Team",
                  icon: Icon(
                    Icons.task_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const _CustomDrawerTile(
                  currentValue: PageEnum.TransactionListPage,
                  title: "Transactions",
                  icon: Icon(
                    Icons.monetization_on_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _CustomDrawerTile extends StatefulWidget {
  const _CustomDrawerTile({
    required this.title,
    required this.icon,
    required this.currentValue,
  });
  final String title;
  final Widget icon;
  final PageEnum currentValue;

  @override
  State<_CustomDrawerTile> createState() => _CustomDrawerTileState();
}

class _CustomDrawerTileState extends State<_CustomDrawerTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 5,
      leading: widget.icon,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(6),
          bottomLeft: Radius.circular(6),
        ),
      ),
      selected: _currentPage == widget.currentValue,
      selectedTileColor: Theme.of(context).indicatorColor,
      tileColor: Colors.transparent,
      title: Text(
        widget.title,
        style: const TextStyle(
            fontFamily: "Abhaya Libre",
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 20),
      ),
      onTap: () {
        if (_currentPage != widget.currentValue) {
          // context.read<DrawerManagementBloc>().add(
          //       ChangeDrawerPage(currentValue),
          //     );
          setState(() {
            _currentPage = widget.currentValue;
          });
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                if (widget.currentValue == PageEnum.Dashboard) {
                  return DashboardPage();
                } else if (widget.currentValue == PageEnum.CaseListPage) {
                  return const CaseListPage();
                } else if (PageEnum.SchedulerPage == widget.currentValue) {
                  return const SchedulerListPage();
                } else if (PageEnum.TeamListPage == widget.currentValue) {
                  return const TeamListPage();
                } else if (PageEnum.TransactionListPage ==
                    widget.currentValue) {
                  return const TransactionListPage();
                } else {
                  return const TaskListPage();
                }
              },
            ),
          );
        }
      },
    );
  }
}
