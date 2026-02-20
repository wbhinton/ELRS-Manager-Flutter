// Copyright (C) 2026  Weston Hinton [wbhinton@gmail.com]
// 
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.

import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'connection_repository.dart';

part 'device_dio.g.dart';

@riverpod
Dio deviceDio(Ref ref) {
  // Watch centralized target IP provider
  final ip = ref.watch(targetIpProvider);
  final baseUrl = ip != null ? 'http://$ip' : '';

  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      headers: {
        'User-Agent': 'ELRSMobile/1.0',
      },
      // Ensure we don't follow redirects automatically if that causes issues with captive portals,
      // though typically ELRS devices don't redirect.
    ),
  );
  return dio;
}
