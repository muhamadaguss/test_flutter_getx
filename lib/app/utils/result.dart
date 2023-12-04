// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';

enum Status { LOADING, COMPLETED, ERROR }

class Result<T> {
  final Status status;
  String? message = 'Pesan tidak dikenal';
  final T? data;
  final int? statusCode;

  Result.loading(
      [this.data, this.message = 'Pesan tidak dikenal', this.statusCode])
      : status = Status.LOADING;

  Result.completed(this.data,
      [this.message = 'Pesan tidak dikenal', this.statusCode])
      : status = Status.COMPLETED;

  Result.error(this.message, [this.data, this.statusCode])
      : status = Status.ERROR;

  @override
  String toString() {
    final json = jsonEncode({
      'status': status.toString(),
      'message': message,
      'data': data.toString(),
    });

    debugPrint(json);

    return json;
  }
}
