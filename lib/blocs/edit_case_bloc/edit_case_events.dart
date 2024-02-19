import 'package:advocate_project_flutter/constants/enums/case_enums.dart';
import 'package:equatable/equatable.dart';

sealed class EditCaseEvent extends Equatable {
  const EditCaseEvent();

  @override
  List<Object?> get props => [];
}

final class EditCaseNumberChanged extends EditCaseEvent {
  const EditCaseNumberChanged(this.caseNumber);

  final String caseNumber;

  @override
  List<Object> get props => [caseNumber];
}

final class EditCaseDescriptionChanged extends EditCaseEvent {
  const EditCaseDescriptionChanged(this.caseDescription);

  final String caseDescription;

  @override
  List<Object> get props => [caseDescription];
}

final class EditCaseClientNameChanged extends EditCaseEvent {
  const EditCaseClientNameChanged(this.clientName);

  final String clientName;

  @override
  List<Object> get props => [clientName];
}

final class EditCaseClientNumberChanged extends EditCaseEvent {
  const EditCaseClientNumberChanged(this.clientContactNumber);

  final String clientContactNumber;

  @override
  List<Object> get props => [clientContactNumber];
}

final class EditCaseRespondentNameChanged extends EditCaseEvent {
  const EditCaseRespondentNameChanged(this.respondentName);

  final String respondentName;

  @override
  List<Object> get props => [respondentName];
}

final class EditCaseRespondentNumberChanged extends EditCaseEvent {
  const EditCaseRespondentNumberChanged(this.respondentContactNumber);

  final String respondentContactNumber;

  @override
  List<Object> get props => [respondentContactNumber];
}

final class EditCaseRespondentSeniorAdvocateNameChanged extends EditCaseEvent {
  const EditCaseRespondentSeniorAdvocateNameChanged(
      this.respondentSeniorAdvocateName);

  final String respondentSeniorAdvocateName;

  @override
  List<Object> get props => [respondentSeniorAdvocateName];
}

final class EditCaseRespondentJuniorAdvocateOneNameChanged
    extends EditCaseEvent {
  const EditCaseRespondentJuniorAdvocateOneNameChanged(
      this.respondentJuniorAdvocateOneName);

  final String respondentJuniorAdvocateOneName;

  @override
  List<Object> get props => [respondentJuniorAdvocateOneName];
}

final class EditCaseRespondentJuniorAdvocateTwoNameChanged
    extends EditCaseEvent {
  const EditCaseRespondentJuniorAdvocateTwoNameChanged(
      this.respondentJuniorAdvocateTwoName);

  final String respondentJuniorAdvocateTwoName;

  @override
  List<Object> get props => [respondentJuniorAdvocateTwoName];
}

final class EditCaseStatusChanged extends EditCaseEvent {
  const EditCaseStatusChanged(this.caseStatus);

  final CaseStatus caseStatus;

  @override
  List<Object> get props => [caseStatus];
}

final class EditCaseTypeChanged extends EditCaseEvent {
  const EditCaseTypeChanged(this.caseType);

  final String caseType;

  @override
  List<Object> get props => [caseType];
}

final class EditCaseSubTypeChanged extends EditCaseEvent {
  const EditCaseSubTypeChanged(this.caseSubtype);

  final String caseSubtype;

  @override
  List<Object> get props => [caseSubtype];
}

final class EditCaseActNumberChanged extends EditCaseEvent {
  const EditCaseActNumberChanged(this.actNumber);

  final String actNumber;

  @override
  List<Object> get props => [actNumber];
}

final class EditCaseFilingNumberChanged extends EditCaseEvent {
  const EditCaseFilingNumberChanged(this.filingNumber);

  final String filingNumber;

  @override
  List<Object> get props => [filingNumber];
}

final class EditCaseFilingDateChanged extends EditCaseEvent {
  const EditCaseFilingDateChanged(this.filingDate);

  final DateTime filingDate;

  @override
  List<Object> get props => [filingDate];
}

final class EditCaseStageChanged extends EditCaseEvent {
  const EditCaseStageChanged(this.caseStage);

  final CaseStage caseStage;

  @override
  List<Object> get props => [caseStage];
}

final class EditCaseSeverityChanged extends EditCaseEvent {
  const EditCaseSeverityChanged(this.caseSeverity);

  final CaseSeverity caseSeverity;

  @override
  List<Object> get props => [caseSeverity];
}

final class EditCaseFirstHearingDateChanged extends EditCaseEvent {
  const EditCaseFirstHearingDateChanged(this.firstHearingDate);

  final DateTime firstHearingDate;

  @override
  List<Object> get props => [firstHearingDate];
}

final class EditCaseNextHearingDateChanged extends EditCaseEvent {
  const EditCaseNextHearingDateChanged(this.nextHearingDate);

  final DateTime nextHearingDate;

  @override
  List<Object> get props => [nextHearingDate];
}

final class EditCaseFIRDateChanged extends EditCaseEvent {
  const EditCaseFIRDateChanged(this.FIRDate);

  final DateTime FIRDate;

  @override
  List<Object> get props => [FIRDate];
}

final class EditCasePoliceStationChanged extends EditCaseEvent {
  const EditCasePoliceStationChanged(this.policeStation);

  final String policeStation;

  @override
  List<Object> get props => [policeStation];
}

final class EditCaseFIRnumberChanged extends EditCaseEvent {
  const EditCaseFIRnumberChanged(this.firNumber);

  final String firNumber;

  @override
  List<Object> get props => [firNumber];
}

final class EditCaseCourtNumberChanged extends EditCaseEvent {
  const EditCaseCourtNumberChanged(this.courtNumber);

  final String courtNumber;

  @override
  List<Object> get props => [courtNumber];
}

final class EditCaseCourtNameChanged extends EditCaseEvent {
  const EditCaseCourtNameChanged(this.courtName);

  final String courtName;

  @override
  List<Object> get props => [courtName];
}

final class EditCaseJudgeNameChanged extends EditCaseEvent {
  const EditCaseJudgeNameChanged(this.judgeName);

  final String judgeName;

  @override
  List<Object> get props => [judgeName];
}

final class EditCaseJudgePostChanged extends EditCaseEvent {
  const EditCaseJudgePostChanged(this.judgePost);

  final String judgePost;

  @override
  List<Object> get props => [judgePost];
}

final class EditCaseCourtTypeChanged extends EditCaseEvent {
  const EditCaseCourtTypeChanged(this.courtType);

  final CourtType courtType;

  @override
  List<Object> get props => [courtType];
}

final class EditCaseAddComment extends EditCaseEvent {
  const EditCaseAddComment(this.comment);

  final String comment;

  @override
  List<Object?> get props => [comment];
}

final class EditCaseAddFile extends EditCaseEvent {
  const EditCaseAddFile(this.filePath);
  final String filePath;

  @override
  List<Object?> get props => [];
}

final class EditCaseRemoveFile extends EditCaseEvent {
  const EditCaseRemoveFile(this.filePath);
  final String filePath;
  @override
  List<Object?> get props => [];
}

final class EditCaseFileTagChange extends EditCaseEvent {
  final String filePath;
  final String filetag;

  const EditCaseFileTagChange({required this.filePath, required this.filetag});
  @override
  List<Object?> get props => [];
}

final class EditCaseSubmitted extends EditCaseEvent {
  const EditCaseSubmitted();

  @override
  List<Object?> get props => [];
}
