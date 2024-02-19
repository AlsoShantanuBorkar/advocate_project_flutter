// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';

import 'package:advocate_project_flutter/constants/enums/case_enums.dart';
import 'package:advocate_project_flutter/models/case_model.dart';

class EditCaseState extends Equatable {
  final EditCaseStatus stateStatus;
  final Case? initialCase;

  final String caseNumber;
  final String clientName;
  final String clientContactNumber;

  final String caseDescription;
  final String respondentName;
  final String respondentContactNumber;
  final String respondentSeniorAdvocateName;

  final String respondentJuniorAdvocateOneName;
  final String respondentJuniorAdvocateTwoName;
  final List<String> comments;
  final CaseStatus caseStatus;
  final String caseType;
  final String caseSubtype;
  final String actNumber;
  final String filingNumber;
  final DateTime filingDate;
  final CaseStage caseStage;
  final CaseSeverity caseSeverity;
  final DateTime firstHearingDate;
  final DateTime nextHearingDate;
  final String policeStation;
  final String FIRnumber;
  final DateTime FIRdate;
  final String courtNumber;
  final CourtType courtType;
  final String courtName;
  final String judgePost;
  final String judgeName;
  final List<Map<String, dynamic>> fileList;
  const EditCaseState({
    this.stateStatus = EditCaseStatus.initial,
    this.initialCase,
    required this.caseNumber,
    required this.clientName,
    required this.clientContactNumber,
    required this.caseDescription,
    required this.respondentName,
    required this.respondentContactNumber,
    required this.respondentSeniorAdvocateName,
    required this.respondentJuniorAdvocateOneName,
    required this.respondentJuniorAdvocateTwoName,
    required this.comments,
    required this.caseStatus,
    required this.caseType,
    required this.caseSubtype,
    required this.actNumber,
    required this.filingNumber,
    required this.filingDate,
    required this.caseStage,
    required this.caseSeverity,
    required this.firstHearingDate,
    required this.nextHearingDate,
    required this.policeStation,
    required this.FIRnumber,
    required this.FIRdate,
    required this.courtNumber,
    required this.courtType,
    required this.courtName,
    required this.judgePost,
    required this.judgeName,
    required this.fileList,
  });

  bool get isNewCase => initialCase == null;

  EditCaseState copyWith({
    EditCaseStatus? stateStatus,
    Case? initialCase,
    String? caseNumber,
    String? clientName,
    String? clientContactNumber,
    String? caseDescription,
    String? respondentName,
    String? respondentContactNumber,
    String? respondentSeniorAdvocateName,
    String? respondentJuniorAdvocateOneName,
    String? respondentJuniorAdvocateTwoName,
    List<String>? comments,
    CaseStatus? caseStatus,
    String? caseType,
    String? caseSubtype,
    String? actNumber,
    String? filingNumber,
    DateTime? filingDate,
    CaseStage? caseStage,
    CaseSeverity? caseSeverity,
    DateTime? firstHearingDate,
    DateTime? nextHearingDate,
    String? policeStation,
    String? FIRnumber,
    DateTime? FIRdate,
    String? courtNumber,
    CourtType? courtType,
    String? courtName,
    String? judgePost,
    String? judgeName,
    List<Map<String, dynamic>>? fileList,
  }) {
    return EditCaseState(
      stateStatus: stateStatus ?? this.stateStatus,
      initialCase: initialCase ?? this.initialCase,
      caseNumber: caseNumber ?? this.caseNumber,
      clientName: clientName ?? this.clientName,
      clientContactNumber: clientContactNumber ?? this.clientContactNumber,
      caseDescription: caseDescription ?? this.caseDescription,
      respondentName: respondentName ?? this.respondentName,
      respondentContactNumber:
          respondentContactNumber ?? this.respondentContactNumber,
      respondentSeniorAdvocateName:
          respondentSeniorAdvocateName ?? this.respondentSeniorAdvocateName,
      respondentJuniorAdvocateOneName: respondentJuniorAdvocateOneName ??
          this.respondentJuniorAdvocateOneName,
      respondentJuniorAdvocateTwoName: respondentJuniorAdvocateTwoName ??
          this.respondentJuniorAdvocateTwoName,
      comments: comments ?? this.comments,
      caseStatus: caseStatus ?? this.caseStatus,
      caseType: caseType ?? this.caseType,
      caseSubtype: caseSubtype ?? this.caseSubtype,
      actNumber: actNumber ?? this.actNumber,
      filingNumber: filingNumber ?? this.filingNumber,
      filingDate: filingDate ?? this.filingDate,
      caseStage: caseStage ?? this.caseStage,
      caseSeverity: caseSeverity ?? this.caseSeverity,
      firstHearingDate: firstHearingDate ?? this.firstHearingDate,
      nextHearingDate: nextHearingDate ?? this.nextHearingDate,
      policeStation: policeStation ?? this.policeStation,
      FIRnumber: FIRnumber ?? this.FIRnumber,
      FIRdate: FIRdate ?? this.FIRdate,
      courtNumber: courtNumber ?? this.courtNumber,
      courtType: courtType ?? this.courtType,
      courtName: courtName ?? this.courtName,
      judgePost: judgePost ?? this.judgePost,
      judgeName: judgeName ?? this.judgeName,
      fileList: fileList ?? this.fileList,
    );
  }

  @override
  List<Object> get props {
    return [
      stateStatus,
      caseNumber,
      clientName,
      clientContactNumber,
      caseDescription,
      respondentName,
      respondentContactNumber,
      respondentSeniorAdvocateName,
      respondentJuniorAdvocateOneName,
      respondentJuniorAdvocateTwoName,
      comments,
      caseStatus,
      caseType,
      caseSubtype,
      actNumber,
      filingNumber,
      filingDate,
      caseStage,
      caseSeverity,
      firstHearingDate,
      nextHearingDate,
      policeStation,
      FIRnumber,
      FIRdate,
      courtNumber,
      courtType,
      courtName,
      judgePost,
      judgeName,
      fileList
    ];
  }
}
