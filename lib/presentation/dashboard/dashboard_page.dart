import 'package:advocate_project_flutter/blocs/auth_cubit/auth_cubit.dart';
import 'package:advocate_project_flutter/blocs/cases_list_bloc/case_list_bloc.dart';
import 'package:advocate_project_flutter/blocs/cases_list_bloc/case_list_events.dart';
import 'package:advocate_project_flutter/blocs/schedule_list_bloc/schedule_list_bloc.dart';
import 'package:advocate_project_flutter/blocs/schedule_list_bloc/schedule_list_events.dart';
import 'package:advocate_project_flutter/blocs/schedule_list_bloc/schedule_list_state.dart';
import 'package:advocate_project_flutter/constants/enums/scheduler_enums.dart';
import 'package:advocate_project_flutter/models/scheduler_event_model.dart';
import 'package:advocate_project_flutter/presentation/common_widgets/custom_scaffold.dart';
import 'package:advocate_project_flutter/presentation/scheduler/scheduler_page.dart';
import 'package:advocate_project_flutter/repositories/cases_repository.dart';
import 'package:advocate_project_flutter/repositories/scheduler_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => ScheduleEventListBloc(
          token: context.read<AuthCubit>().state.isLoggedIn
              ? context.read<AuthCubit>().state.user!.token!
              : "",
          eventsRepository: context.read<ScheduleEventRepository>(),
        )..add(
            SchedulesListSubscriptionRequstedEvent(),
          ),
      ),
      BlocProvider(
        create: (context) => CaseListBloc(
          token: context.read<AuthCubit>().state.isLoggedIn
              ? context.read<AuthCubit>().state.user!.token!
              : "",
          casesRepository: context.read<CasesRepository>(),
        )..add(CasesListSubscriptionRequstedEvent()),
      ),
    ], child: const Dashboard());
  }
}

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(
      pageTitle: "Dashboard",
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [ScheduleListWidget()],
          ),
        ),
      ),
    );
  }
}
