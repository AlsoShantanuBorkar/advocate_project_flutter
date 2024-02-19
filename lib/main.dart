import 'package:advocate_project_flutter/apis/auth_api/auth_api.dart';
import 'package:advocate_project_flutter/apis/cases_api/cases_api.dart';
import 'package:advocate_project_flutter/apis/scheduler_api/scheduler_api.dart';
import 'package:advocate_project_flutter/apis/task_apis/task_api.dart';
import 'package:advocate_project_flutter/apis/team_api/team_api.dart';
import 'package:advocate_project_flutter/blocs/app_bloc_observer.dart';
import 'package:advocate_project_flutter/blocs/auth_cubit/auth_cubit.dart';
import 'package:advocate_project_flutter/blocs/auth_cubit/auth_state.dart';
import 'package:advocate_project_flutter/blocs/team_list_bloc/team_list_bloc.dart';
import 'package:advocate_project_flutter/blocs/team_list_bloc/team_list_events.dart';
import 'package:advocate_project_flutter/constants/colors/theme_1.dart';
import 'package:advocate_project_flutter/models/scheduler_event_model.dart';
import 'package:advocate_project_flutter/presentation/common_widgets/custom_scaffold.dart';
import 'package:advocate_project_flutter/presentation/dashboard/dashboard_page.dart';
import 'package:advocate_project_flutter/presentation/user_auth_management/login_page.dart';
import 'package:advocate_project_flutter/repositories/auth_repository.dart';
import 'package:advocate_project_flutter/repositories/cases_repository.dart';
import 'package:advocate_project_flutter/repositories/scheduler_repository.dart';
import 'package:advocate_project_flutter/repositories/task_repository.dart';
import 'package:advocate_project_flutter/repositories/team_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences sharedPreferencesInstance =
      await SharedPreferences.getInstance();
  final CaseAPI caseAPI =
      CaseAPI(sharedPreferencesIntsance: sharedPreferencesInstance);

  final TaskAPI taskAPI =
      TaskAPI(sharedPreferencesIntsance: sharedPreferencesInstance);

  final TeamMemberAPI teamMemberAPI =
      TeamMemberAPI(sharedPreferencesIntsance: sharedPreferencesInstance);

  final AuthAPI authAPI =
      AuthAPI(sharedPreferencesInstance: sharedPreferencesInstance);

  final ScheduleEventAPI scheduleEventAPI =
      ScheduleEventAPI(sharedPreferencesIntsance: sharedPreferencesInstance);

  Bloc.observer = const AppBlocObserver();

  final CasesRepository casesRepository = CasesRepository(caseAPI: caseAPI);

  final TasksRepository tasksRepository = TasksRepository(taskAPI: taskAPI);

  final TeamMembersRepository teamMembersRepository =
      TeamMembersRepository(teamMemberAPI: teamMemberAPI);

  final AuthRepository authRepository = AuthRepository(authAPI: authAPI);

  final ScheduleEventRepository scheduleEventRepository =
      ScheduleEventRepository(scheduleEventAPI: scheduleEventAPI);

  runApp(MyApp(
    casesRepository: casesRepository,
    tasksRepository: tasksRepository,
    teamMembersRepository: teamMembersRepository,
    authRepository: authRepository,
    scheduleEventRepository: scheduleEventRepository,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.casesRepository,
    required this.tasksRepository,
    required this.teamMembersRepository,
    required this.authRepository,
    required this.scheduleEventRepository,
  });
  final ScheduleEventRepository scheduleEventRepository;
  final AuthRepository authRepository;
  final TeamMembersRepository teamMembersRepository;
  final CasesRepository casesRepository;
  final TasksRepository tasksRepository;
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<CasesRepository>.value(value: casesRepository),
        RepositoryProvider<TasksRepository>.value(value: tasksRepository),
        RepositoryProvider<TeamMembersRepository>.value(
            value: teamMembersRepository),
        RepositoryProvider<AuthRepository>.value(value: authRepository),
        RepositoryProvider<ScheduleEventRepository>.value(
            value: scheduleEventRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => TeamMemberListBloc(
              teamMembersRepository: context.read<TeamMembersRepository>(),
            )..add(TeamMembersListSubscriptionRequstedEvent()),
          ),
          BlocProvider(
            create: (context) => AuthCubit(
              authRepository: context.read<AuthRepository>(),
              context: context,
            ),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: theme_1,
          home: BlocBuilder<AuthCubit, AuthState>(
            buildWhen: (previous, current) {
              return previous.isLoggedIn != current.isLoggedIn;
            },
            builder: (context, state) {
              if (state.isLoading) {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (!state.isLoggedIn) {
                return const MainApp();
              }

              return DashboardPage();
            },
          ),
        ),
      ),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoginScreen();
  }
}
