import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:injectable/injectable.dart';
import 'package:pokedex/core/services/api/api_service.dart';
import 'package:pokedex/shared/extensions/connectivity_extension.dart';
import 'package:pokedex/shared/shared.dart';

@Injectable(as: ApiService)
class ApiServiceImpl implements ApiService {
  final Dio _dio = Dio(
    BaseOptions(baseUrl: Constants.baseUrl),
  );

  @override
  Future get(String endpoint, {Map<String, dynamic>? params}) async {
    try {
      if (!await Connectivity().isConnected()) {
        showToast('No internet connection');

        return;
      }

      final request = await _dio.get(
        endpoint,
        queryParameters: params ?? {},
      );
      if (request.statusCode! >= 200 && request.statusCode! < 300) {
        return request.data;
      }
    } on DioError catch (e) {
      if (e.response == null) {
        return e.response;
      }
      return e.response!.statusCode;
    }
  }
}
