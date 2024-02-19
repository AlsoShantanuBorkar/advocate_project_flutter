import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class TeamMember extends Equatable {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String password;
  final String address;
  final String role;

  const TeamMember(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.phoneNumber,
      required this.password,
      required this.address,
      required this.role});

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        email,
        phoneNumber,
        password,
        address,
        role,
      ];

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'firstName': firstName});
    result.addAll({'lastName': lastName});
    result.addAll({'email': email});
    result.addAll({'phoneNumber': phoneNumber});
    result.addAll({'password': password});
    result.addAll({'address': address});
    result.addAll({'role': role});

    return result;
  }

  factory TeamMember.fromMap(Map<String, dynamic> map) {
    return TeamMember(
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      password: map['password'] ?? '',
      address: map['address'] ?? '',
      role: map['role'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TeamMember.fromJson(String source) =>
      TeamMember.fromMap(json.decode(source));

  TeamMember copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? password,
    String? address,
    String? role,
  }) {
    return TeamMember(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      address: address ?? this.address,
      role: role ?? this.role,
    );
  }
}
