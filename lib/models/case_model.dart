// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:advocate_project_flutter/constants/enums/case_enums.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

@immutable
@JsonSerializable()
class Case extends Equatable {
  String? caseID;
  String caseNumber;
  String clientName;
  String clientContactNumber;
  String caseDescription;
  String respondentName;
  String respondentContactNumber;
  String respondentSeniorAdvocateName;
  String respondentJuniorAdvocateOneName;
  String respondentJuniorAdvocateTwoName;
  List<String> comments;
  CaseStatus caseStatus;
  String caseType;
  String caseSubtype;
  String actNumber;
  String filingNumber;
  DateTime filingDate;
  CaseStage caseStage;
  CaseSeverity caseSeverity;
  DateTime firstHearingDate;
  DateTime nextHearingDate;
  String policeStation;
  String FIRnumber;
  DateTime FIRdate;
  String courtNumber;
  CourtType courtType;
  String courtName;
  String judgePost;
  String judgeName;
  List<Map<String, dynamic>> fileList;
  Case(
      {String? caseID,
      this.caseNumber = "",
      this.clientName = "",
      this.clientContactNumber = "",
      this.caseDescription = "",
      this.respondentName = "",
      this.respondentContactNumber = "",
      this.respondentSeniorAdvocateName = "",
      this.respondentJuniorAdvocateOneName = "",
      this.respondentJuniorAdvocateTwoName = "",
      this.comments = const [],
      this.caseStatus = CaseStatus.Pending,
      this.caseType = "",
      this.caseSubtype = "",
      this.actNumber = "",
      this.filingNumber = "",
      required this.filingDate,
      this.caseStage = CaseStage.Pending,
      this.caseSeverity = CaseSeverity.Low,
      required this.firstHearingDate,
      required this.nextHearingDate,
      this.policeStation = "",
      this.FIRnumber = "",
      required this.FIRdate,
      this.courtNumber = "",
      this.courtType = CourtType.DistrictCourt,
      this.courtName = "",
      this.judgePost = "",
      this.judgeName = "",
      this.fileList = const []})
      : assert(
          caseID == null || caseID.isNotEmpty,
          'caseID must either be null or not empty',
        ),
        caseID = caseID ?? const Uuid().v4();

  Case copyWith({
    String? caseID,
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
    return Case(
      caseID: caseID ?? this.caseID,
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

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'caseID': caseID});
    result.addAll({'caseNumber': caseNumber});
    result.addAll({'clientName': clientName});
    result.addAll({'clientContactNumber': clientContactNumber});
    result.addAll({'caseDescription': caseDescription});
    result.addAll({'respondentName': respondentName});
    result.addAll({'respondentContactNumber': respondentContactNumber});
    result
        .addAll({'respondentSeniorAdvocateName': respondentSeniorAdvocateName});
    result.addAll(
        {'respondentJuniorAdvocateOneName': respondentJuniorAdvocateOneName});
    result.addAll(
        {'respondentJuniorAdvocateTwoName': respondentJuniorAdvocateTwoName});
    result.addAll({'comments': comments});
    result.addAll({'caseStatus': caseStatus.name});
    result.addAll({'caseType': caseType});
    result.addAll({'caseSubtype': caseSubtype});
    result.addAll({'actNumber': actNumber});
    result.addAll({'filingNumber': filingNumber});
    result.addAll({'filingDate': filingDate.millisecondsSinceEpoch});
    result.addAll({'caseStage': caseStage.name});
    result.addAll({'caseSeverity': caseSeverity.name});
    result
        .addAll({'firstHearingDate': firstHearingDate.millisecondsSinceEpoch});
    result.addAll({'nextHearingDate': nextHearingDate.millisecondsSinceEpoch});
    result.addAll({'policeStation': policeStation});
    result.addAll({'FIRnumber': FIRnumber});
    result.addAll({'FIRdate': FIRdate.millisecondsSinceEpoch});
    result.addAll({'courtNumber': courtNumber});
    result.addAll({'courtType': courtType.name});
    result.addAll({'courtName': courtName});
    result.addAll({'judgePost': judgePost});
    result.addAll({'judgeName': judgeName});
    result.addAll({'fileList': fileList});
    return result;
  }

  factory Case.fromMap(Map<String, dynamic> map) {
    return Case(
        caseID: map['caseID'] ?? '',
        caseNumber: map['caseNumber'] ?? '',
        clientName: map['clientName'] ?? '',
        clientContactNumber: map['clientContactNumber'] ?? '',
        caseDescription: map['caseDescription'] ?? '',
        respondentName: map['respondentName'] ?? '',
        respondentContactNumber: map['respondentContactNumber'] ?? '',
        respondentSeniorAdvocateName: map['respondentSeniorAdvocateName'] ?? '',
        respondentJuniorAdvocateOneName:
            map['respondentJuniorAdvocateOneName'] ?? '',
        respondentJuniorAdvocateTwoName:
            map['respondentJuniorAdvocateTwoName'] ?? '',
        comments: List<String>.from(map['comments']),
        caseStatus: CaseStatus.values.firstWhere(
          (e) => e.name == map['caseStatus'],
        ),
        caseType: map['caseType'] ?? '',
        caseSubtype: map['caseSubtype'] ?? '',
        actNumber: map['actNumber'] ?? '',
        filingNumber: map['filingNumber'] ?? '',
        filingDate: DateTime.fromMillisecondsSinceEpoch(map['filingDate']),
        caseStage: CaseStage.values.firstWhere(
          (e) => e.name == map['caseStage'],
        ),
        caseSeverity: CaseSeverity.values.firstWhere(
          (e) => e.name == map['caseSeverity'],
        ),
        firstHearingDate:
            DateTime.fromMillisecondsSinceEpoch(map['firstHearingDate']),
        nextHearingDate:
            DateTime.fromMillisecondsSinceEpoch(map['nextHearingDate']),
        policeStation: map['policeStation'] ?? '',
        FIRnumber: map['FIRnumber'] ?? '',
        FIRdate: DateTime.fromMillisecondsSinceEpoch(map['FIRdate']),
        courtNumber: map['courtNumber'] ?? '',
        courtType: CourtType.values.firstWhere(
          (e) => e.name == map['courtType'],
        ),
        courtName: map['courtName'] ?? '',
        judgePost: map['judgePost'] ?? '',
        judgeName: map['judgeName'] ?? '',
        fileList: map['fileList'] != null
            ? (map['fileList'] as List)
                .map((e) => e as Map<String, dynamic>)
                .toList()
            : []);
  }

  String toJson() => json.encode(toMap());

  factory Case.fromJson(String source) => Case.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Case(caseID: $caseID, caseNumber: $caseNumber, clientName: $clientName, clientContactNumber: $clientContactNumber, caseDescription: $caseDescription, respondentName: $respondentName, respondentContactNumber: $respondentContactNumber, respondentSeniorAdvocateName: $respondentSeniorAdvocateName, respondentJuniorAdvocateOneName: $respondentJuniorAdvocateOneName, respondentJuniorAdvocateTwoName: $respondentJuniorAdvocateTwoName, comments: $comments, caseStatus: $caseStatus, caseType: $caseType, caseSubtype: $caseSubtype, actNumber: $actNumber, filingNumber: $filingNumber, filingDate: $filingDate, caseStage: $caseStage, caseSeverity: $caseSeverity, firstHearingDate: $firstHearingDate, nextHearingDate: $nextHearingDate, policeStation: $policeStation, FIRnumber: $FIRnumber, FIRdate: $FIRdate, courtNumber: $courtNumber, courtType: $courtType, courtName: $courtName, judgePost: $judgePost, judgeName: $judgeName, fileList: $fileList)';
  }

  @override
  List<Object> get props {
    return [
      caseID!,
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
