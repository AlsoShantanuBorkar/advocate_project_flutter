import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class User extends Equatable {
  String? name;
  final String email;
  String? phone;
  String? street;
  String? city;
  String? state;
  String? postalCode;
  String? country;
  String? token;
  User({
    this.name,
    required this.email,
    this.phone,
    this.street,
    this.city,
    this.state,
    this.postalCode,
    this.country,
    this.token,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'email': email});
    result.addAll({
      'phone': {"country_isd_code": "+91", "number": phone}
    });
    if (result["address"] != null) {
      result["address"]['street'] = street;
      result["address"]['city'] = city;
      result["address"]['state'] = state;
      result["address"]['postalCode'] = postalCode;
      result["address"]['country'] = country;
    }

    if (token != null) {
      result["token"] = token;
    }

    return result;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone']["number"] ?? '',
      street: map["address"]['street'] ?? '',
      city: map["address"]['city'] ?? '',
      state: map["address"]['state'] ?? '',
      postalCode: map["address"]['postalCode'] ?? '',
      country: map["address"]['country'] ?? '',
      token: map["token"],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  List<Object?> get props => [
        name,
        email,
        phone,
        street,
        city,
        state,
        postalCode,
        country,
      ];
}
