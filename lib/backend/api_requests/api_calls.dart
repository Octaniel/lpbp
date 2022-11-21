import 'dart:convert';

import '../../flutter_flow/flutter_flow_util.dart';

import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

class GetFuncionarioCall {
  static Future<ApiCallResponse> call() {
    return ApiManager.instance.makeApiCall(
      callName: 'getFuncionario',
      apiUrl: 'http://52.204.190.168:8080/pessoa',
      callType: ApiCallType.GET,
      headers: {
        'Accept': 'application/json; charset = UTF-8',
      },
      params: {},
      returnBody: true,
      cache: false,
    );
  }

  static dynamic funcionario(dynamic response) => getJsonField(
        response,
        r'''$''',
        true,
      );
  static dynamic codigo(dynamic response) => getJsonField(
        response,
        r'''$[:].codigo''',
        true,
      );
}

class GetPresencaPorIdFuncionarioCall {
  static Future<ApiCallResponse> call({
    int? idPessoa = 1,
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'getPresencaPorIdFuncionario',
      apiUrl: 'http://52.204.190.168:8080/presenca/idPessoa/$idPessoa',
      callType: ApiCallType.GET,
      headers: {
        'Accept': 'application/json; charset = UTF-8',
      },
      params: {},
      returnBody: true,
      cache: false,
    );
  }
}

class GetPresencaPorIdCall {
  static Future<ApiCallResponse> call({
    int? id = 1,
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'getPresencaPorId',
      apiUrl: 'http://52.204.190.168:8080/presenca/$id',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      cache: false,
    );
  }
}

class AtualizarPresencaCall {
  static Future<ApiCallResponse> call({
    String? urlVideo = '',
    int? id,
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'atualizarPresenca',
      apiUrl:
          'http://52.204.190.168:8080/presenca?urlVideo=$urlVideo&id=$id',
      callType: ApiCallType.PATCH,
      headers: {},
      params: {},
      bodyType: BodyType.NONE,
      returnBody: true,
      cache: false,
    );
  }
}

class AicionarPresencaCall {
  static Future<ApiCallResponse> call({
    int? codigoPessoa,
    String? urlFoto = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'aicionarPresenca',
      apiUrl:
          'http://52.204.190.168:8080/presenca?codigoPessoa=$codigoPessoa&urlFoto=$urlFoto',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      bodyType: BodyType.JSON,
      returnBody: true,
      cache: false,
    );
  }
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

