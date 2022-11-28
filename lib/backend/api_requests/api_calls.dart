import 'dart:convert';

import '../../flutter_flow/flutter_flow_util.dart';

import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

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
      apiUrl: 'http://52.204.190.168:8080/presenca/idPessoa/${idPessoa}',
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
      apiUrl: 'http://52.204.190.168:8080/presenca/${id}',
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
          'http://52.204.190.168:8080/presenca?urlVideo=${urlVideo}&id=${id}',
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
          'http://52.204.190.168:8080/presenca?codigoPessoa=${codigoPessoa}&urlFoto=${urlFoto}',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      bodyType: BodyType.JSON,
      returnBody: true,
      cache: false,
    );
  }
}

class AdicionarPessoaCall {
  static Future<ApiCallResponse> call({
    String? nomeUs = '',
    String? senha = '',
    String? tipo = '',
    String? nomePes = '',
    String? apelido = '',
    String? email = '',
    String? morada = '',
    String? telemovel = '',
    String? dataNascimento = '',
    String? turno = '',
    String? acessToken = '',
  }) {
    final body = '''
{
  "nome": "${nomeUs}",
  "senha": "${senha}",
  "tipo": "${tipo}",
  "pessoa": {
    "nome": "${nomePes}",
    "apelido": "${apelido}",
    "email": "${email}",
    "morada": "${morada}",
    "telemovel": "${telemovel}",
    "dataNascimento": "${dataNascimento}",
    "turno": "${turno}"
  }
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'adicionarPessoa',
      apiUrl: 'http://52.204.190.168:8080/usuario/add',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${acessToken}',
      },
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
      cache: false,
    );
  }
}

class LoginCall {
  static Future<ApiCallResponse> call({
    String? username = '',
    String? password = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'login',
      apiUrl: 'http://52.204.190.168:8080/oauth/token',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Basic YW5ndWxhcjpAbmd1bEByMA==',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      params: {
        'client': "angular",
        'username': username,
        'password': password,
        'grant_type': "password",
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      cache: false,
    );
  }
}

class CheckTokenCall {
  static Future<ApiCallResponse> call({
    String? acessToken = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'checkToken',
      apiUrl: 'http://52.204.190.168:8080/util/checkConnect',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${acessToken}',
      },
      params: {},
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

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list);
  } catch (_) {
    return '[]';
  }
}
