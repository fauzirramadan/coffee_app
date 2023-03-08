import 'dart:convert';
import 'dart:developer';

import 'package:coffe_app/core/models/coffee.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../helper/either.dart';
import '../helper/failure.dart';
import '../network/api.dart';
import '../network/dio_handler.dart';

class GeneralRepo {
  Future<Either<Failure, List<Coffee>>> dataCoffee() async {
    try {
      Response res = await dio.get(Api.coffeeApi);
      return Either.success(coffeeFromJson(jsonEncode(res.data)));
    } catch (e, st) {
      if (kDebugMode) {
        log(st.toString());
      }
      log(e.toString());
      return Either.error(Failure(e.toString()));
    }
  }
}
