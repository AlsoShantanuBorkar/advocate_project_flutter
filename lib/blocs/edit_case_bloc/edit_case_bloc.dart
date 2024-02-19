import 'package:advocate_project_flutter/blocs/edit_case_bloc/edit_case_events.dart';
import 'package:advocate_project_flutter/blocs/edit_case_bloc/edit_case_state.dart';
import 'package:advocate_project_flutter/constants/enums/case_enums.dart';
import 'package:advocate_project_flutter/models/case_model.dart';
import 'package:advocate_project_flutter/repositories/cases_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditCaseBloc extends Bloc<EditCaseEvent, EditCaseState> {
  final String token;
  EditCaseBloc({
    this.token = "",
    required CasesRepository casesRepository,
    required Case? initialCase,
  })  : _casesRepository = casesRepository,
        super(EditCaseState(
          initialCase: initialCase,
          caseNumber: initialCase?.caseNumber ?? "",
          clientName: initialCase?.clientName ?? "",
          clientContactNumber: initialCase?.clientContactNumber ?? "",
          caseDescription: initialCase?.caseDescription ?? "",
          respondentName: initialCase?.respondentName ?? "",
          respondentContactNumber: initialCase?.respondentContactNumber ?? "",
          respondentSeniorAdvocateName:
              initialCase?.respondentSeniorAdvocateName ?? "",
          respondentJuniorAdvocateOneName:
              initialCase?.respondentJuniorAdvocateOneName ?? "",
          respondentJuniorAdvocateTwoName:
              initialCase?.respondentJuniorAdvocateTwoName ?? "",
          comments: initialCase?.comments ?? [],
          caseStatus: initialCase?.caseStatus ?? CaseStatus.Pending,
          caseType: initialCase?.caseType ?? "",
          caseSubtype: initialCase?.caseSubtype ?? "",
          actNumber: initialCase?.actNumber ?? "",
          filingNumber: initialCase?.filingNumber ?? "",
          filingDate: initialCase?.filingDate ?? DateTime.now(),
          caseStage: initialCase?.caseStage ?? CaseStage.Pending,
          caseSeverity: initialCase?.caseSeverity ?? CaseSeverity.Low,
          firstHearingDate: initialCase?.firstHearingDate ?? DateTime.now(),
          nextHearingDate: initialCase?.nextHearingDate ?? DateTime.now(),
          policeStation: initialCase?.policeStation ?? "",
          FIRnumber: initialCase?.FIRnumber ?? "",
          FIRdate: initialCase?.FIRdate ?? DateTime.now(),
          courtNumber: initialCase?.courtNumber ?? "",
          courtType: initialCase?.courtType ?? CourtType.DistrictCourt,
          courtName: initialCase?.courtName ?? "",
          judgePost: initialCase?.judgePost ?? "",
          judgeName: initialCase?.judgeName ?? "",
          fileList: initialCase?.fileList ?? [],
        )) {
    on<EditCaseDescriptionChanged>(_onCaseDescriptionChanged);

    on<EditCaseNumberChanged>(_onCaseNumberChanged);

    on<EditCaseTypeChanged>(_onCaseTypeChanged);

    on<EditCaseStatusChanged>(_onCaseStatusChanged);

    on<EditCaseSubTypeChanged>(_onCaseSubTypeChanged);

    on<EditCaseClientNameChanged>(_onClientNameChanged);

    on<EditCaseClientNumberChanged>(_onClientNumberChanged);

    on<EditCaseRespondentNameChanged>(_onRespondentNameChanged);

    on<EditCaseRespondentNumberChanged>(_onRespondentNumberChanged);

    on<EditCaseRespondentSeniorAdvocateNameChanged>(
        _onRespondentSeniorAdvocateChanged);

    on<EditCaseRespondentJuniorAdvocateOneNameChanged>(
        _onRespondentJuniorAdvocateOneChanged);

    on<EditCaseRespondentJuniorAdvocateTwoNameChanged>(
        _onRespondentJuniorAdvocateTwoChanged);

    on<EditCaseAddComment>(_onAddComment);

    on<EditCaseFilingNumberChanged>(_onFilingNumberChanged);

    on<EditCaseFilingDateChanged>(_onFilingDateChanged);

    on<EditCaseActNumberChanged>(_onActNumberChanged);

    on<EditCaseSeverityChanged>(_onCaseSeverityChanged);

    on<EditCaseStageChanged>(_onCaseStageChanged);

    on<EditCaseFirstHearingDateChanged>(_onFirstHearingDateChanged);

    on<EditCaseNextHearingDateChanged>(_onNextHearingDateChanged);

    on<EditCaseFIRDateChanged>(_onFIRDateChanged);

    on<EditCaseFIRnumberChanged>(_onFIRnumberChanged);

    on<EditCasePoliceStationChanged>(_onPoliceStationChanged);

    on<EditCaseCourtNumberChanged>(_onCourtNumberChanged);

    on<EditCaseCourtTypeChanged>(_onCourtTypeChanged);

    on<EditCaseCourtNameChanged>(_onCourtNameChanged);

    on<EditCaseJudgeNameChanged>(_onJudgeNameChanged);

    on<EditCaseJudgePostChanged>(_onJudgePostChanged);

    on<EditCaseAddFile>(_onFileAdd);

    on<EditCaseRemoveFile>(_onFileRemove);

    on<EditCaseFileTagChange>(_onFileTagChange);

    on<EditCaseSubmitted>(_onSubmitted);
  }

  final CasesRepository _casesRepository;

  void _onCaseNumberChanged(
    EditCaseNumberChanged event,
    Emitter<EditCaseState> emit,
  ) {
    emit(state.copyWith(caseNumber: event.caseNumber));
  }

  void _onCaseDescriptionChanged(
    EditCaseDescriptionChanged event,
    Emitter<EditCaseState> emit,
  ) {
    emit(state.copyWith(caseDescription: event.caseDescription));
  }

  void _onCaseTypeChanged(
    EditCaseTypeChanged event,
    Emitter<EditCaseState> emit,
  ) {
    emit(state.copyWith(caseType: event.caseType));
  }

  void _onCaseStatusChanged(
    EditCaseStatusChanged event,
    Emitter<EditCaseState> emit,
  ) {
    emit(state.copyWith(caseStatus: event.caseStatus));
  }

  void _onCaseSubTypeChanged(
    EditCaseSubTypeChanged event,
    Emitter<EditCaseState> emit,
  ) {
    emit(state.copyWith(caseSubtype: event.caseSubtype));
  }

  void _onClientNameChanged(
    EditCaseClientNameChanged event,
    Emitter<EditCaseState> emit,
  ) {
    emit(state.copyWith(clientName: event.clientName));
  }

  void _onClientNumberChanged(
    EditCaseClientNumberChanged event,
    Emitter<EditCaseState> emit,
  ) {
    emit(state.copyWith(clientContactNumber: event.clientContactNumber));
  }

  void _onRespondentNameChanged(
    EditCaseRespondentNameChanged event,
    Emitter<EditCaseState> emit,
  ) {
    emit(state.copyWith(respondentName: event.respondentName));
  }

  void _onRespondentNumberChanged(
    EditCaseRespondentNumberChanged event,
    Emitter<EditCaseState> emit,
  ) {
    emit(
        state.copyWith(respondentContactNumber: event.respondentContactNumber));
  }

  void _onRespondentSeniorAdvocateChanged(
    EditCaseRespondentSeniorAdvocateNameChanged event,
    Emitter<EditCaseState> emit,
  ) {
    emit(state.copyWith(
        respondentSeniorAdvocateName: event.respondentSeniorAdvocateName));
  }

  void _onRespondentJuniorAdvocateOneChanged(
    EditCaseRespondentJuniorAdvocateOneNameChanged event,
    Emitter<EditCaseState> emit,
  ) {
    emit(state.copyWith(
        respondentJuniorAdvocateOneName:
            event.respondentJuniorAdvocateOneName));
  }

  void _onRespondentJuniorAdvocateTwoChanged(
    EditCaseRespondentJuniorAdvocateTwoNameChanged event,
    Emitter<EditCaseState> emit,
  ) {
    emit(state.copyWith(
        respondentJuniorAdvocateTwoName:
            event.respondentJuniorAdvocateTwoName));
  }

  void _onAddComment(
    EditCaseAddComment event,
    Emitter<EditCaseState> emit,
  ) {
    List<String> comments = state.comments;
    comments.add(event.comment);
    emit(state.copyWith(comments: comments));
  }

  void _onFilingNumberChanged(
    EditCaseFilingNumberChanged event,
    Emitter<EditCaseState> emit,
  ) {
    emit(state.copyWith(filingNumber: event.filingNumber));
  }

  void _onFilingDateChanged(
    EditCaseFilingDateChanged event,
    Emitter<EditCaseState> emit,
  ) {
    emit(state.copyWith(filingDate: event.filingDate));
  }

  void _onActNumberChanged(
    EditCaseActNumberChanged event,
    Emitter<EditCaseState> emit,
  ) {
    emit(state.copyWith(actNumber: event.actNumber));
  }

  void _onCaseStageChanged(
    EditCaseStageChanged event,
    Emitter<EditCaseState> emit,
  ) {
    emit(state.copyWith(caseStage: event.caseStage));
  }

  void _onCaseSeverityChanged(
    EditCaseSeverityChanged event,
    Emitter<EditCaseState> emit,
  ) {
    emit(state.copyWith(caseSeverity: event.caseSeverity));
  }

  void _onFirstHearingDateChanged(
    EditCaseFirstHearingDateChanged event,
    Emitter<EditCaseState> emit,
  ) {
    emit(state.copyWith(firstHearingDate: event.firstHearingDate));
  }

  void _onNextHearingDateChanged(
    EditCaseNextHearingDateChanged event,
    Emitter<EditCaseState> emit,
  ) {
    emit(state.copyWith(nextHearingDate: event.nextHearingDate));
  }

  void _onFIRDateChanged(
    EditCaseFIRDateChanged event,
    Emitter<EditCaseState> emit,
  ) {
    emit(state.copyWith(FIRdate: event.FIRDate));
  }

  void _onPoliceStationChanged(
    EditCasePoliceStationChanged event,
    Emitter<EditCaseState> emit,
  ) {
    emit(state.copyWith(policeStation: event.policeStation));
  }

  void _onFIRnumberChanged(
    EditCaseFIRnumberChanged event,
    Emitter<EditCaseState> emit,
  ) {
    emit(state.copyWith(FIRnumber: event.firNumber));
  }

  void _onCourtNumberChanged(
    EditCaseCourtNumberChanged event,
    Emitter<EditCaseState> emit,
  ) {
    emit(state.copyWith(courtNumber: event.courtNumber));
  }

  void _onCourtTypeChanged(
    EditCaseCourtTypeChanged event,
    Emitter<EditCaseState> emit,
  ) {
    emit(state.copyWith(courtType: event.courtType));
  }

  void _onCourtNameChanged(
    EditCaseCourtNameChanged event,
    Emitter<EditCaseState> emit,
  ) {
    emit(state.copyWith(courtName: event.courtName));
  }

  void _onJudgeNameChanged(
    EditCaseJudgeNameChanged event,
    Emitter<EditCaseState> emit,
  ) {
    emit(state.copyWith(judgeName: event.judgeName));
  }

  void _onJudgePostChanged(
    EditCaseJudgePostChanged event,
    Emitter<EditCaseState> emit,
  ) {
    emit(state.copyWith(judgePost: event.judgePost));
  }

  void _onFileAdd(
    EditCaseAddFile event,
    Emitter<EditCaseState> emit,
  ) {
    emit(state.copyWith(fileList: [
      ...state.fileList,
      {"path": event.filePath}
    ]));
  }

  void _onFileRemove(
    EditCaseRemoveFile event,
    Emitter<EditCaseState> emit,
  ) {
    List<Map<String, dynamic>> files = state.fileList;
    int x = files.indexWhere((element) => element["path"] == event.filePath);
    files.removeAt(x);
    emit(state.copyWith(fileList: files));
  }

  void _onFileTagChange(
    EditCaseFileTagChange event,
    Emitter<EditCaseState> emit,
  ) {
    List<Map<String, dynamic>> files = state.fileList;
    int x = files.indexWhere((element) => element["path"] == event.filePath);
    files[x]["tag"] = event.filetag;
    emit(state.copyWith(fileList: files));
  }

  void _onSubmitted(
    EditCaseSubmitted event,
    Emitter<EditCaseState> emit,
  ) async {
    emit(state.copyWith(stateStatus: EditCaseStatus.loading));
    final Case newCase = (state.initialCase ??
            Case(
              caseNumber: '',
              filingDate: DateTime.now(),
              firstHearingDate: DateTime.now(),
              nextHearingDate: DateTime.now(),
              FIRdate: DateTime.now(),
            ))
        .copyWith(
            caseNumber: state.caseNumber,
            clientName: state.clientName,
            clientContactNumber: state.clientContactNumber,
            caseDescription: state.caseDescription,
            respondentName: state.respondentName,
            respondentContactNumber: state.respondentContactNumber,
            respondentSeniorAdvocateName: state.respondentSeniorAdvocateName,
            respondentJuniorAdvocateOneName:
                state.respondentJuniorAdvocateOneName,
            respondentJuniorAdvocateTwoName:
                state.respondentJuniorAdvocateTwoName,
            comments: state.comments,
            caseStatus: state.caseStatus,
            caseType: state.caseType,
            caseSubtype: state.caseSubtype,
            actNumber: state.actNumber,
            filingNumber: state.filingNumber,
            filingDate: state.filingDate,
            caseStage: state.caseStage,
            caseSeverity: state.caseSeverity,
            firstHearingDate: state.firstHearingDate,
            nextHearingDate: state.nextHearingDate,
            policeStation: state.policeStation,
            FIRnumber: state.FIRnumber,
            FIRdate: state.FIRdate,
            courtNumber: state.courtNumber,
            courtType: state.courtType,
            courtName: state.courtName,
            judgePost: state.judgePost,
            judgeName: state.judgeName,
            fileList: state.fileList);

    try {
      if (state.initialCase != null) {
        await _casesRepository.deleteCase(token, state.initialCase!.caseNumber);
      }
      await _casesRepository.saveCase(token, newCase).then((value) {
        if (value) {
          emit(state.copyWith(stateStatus: EditCaseStatus.success));
        } else {
          emit(state.copyWith(stateStatus: EditCaseStatus.failure));
        }
      });
    } catch (e) {
      emit(state.copyWith(stateStatus: EditCaseStatus.failure));
    }
  }
}
