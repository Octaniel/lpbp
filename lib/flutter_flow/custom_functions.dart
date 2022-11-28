import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:lpbp/flutter_flow/upload_media.dart';

import '../backend/api_requests/api_calls.dart';
import '../backend/api_requests/api_manager.dart';
import '../backend/firebase_storage/storage.dart';

Color getColorByPresente(bool? presente) {
  if (presente != null && presente) {
    return Colors.green;
  } else {
    return Colors.red;
  }
}

String presencaBoleanToString(bool? presente) {
  // Add your function code here!
  return presente == true ? 'PRESENTE' : 'AUSENTE';
}

Future<bool> checkInternetConnection() async {
  bool result = await InternetConnectionChecker().hasConnection;
  return result;
}

String formatDate(String? date) {
  if (date != null) {
    return DateFormat('dd/MM/yyyy HH:mm:ss').format(DateTime.parse(date));
  }
  return '';
}

String formatStringToUtf8(String arg) {
  return Uri.decodeFull(arg);
}

Future<void> savePresentcaOffline() async {
  var read = GetStorage().read('presencas');
  List<dynamic> presencas = [];
  if (read != null) {
    await read.forEach((value) async {
      try {
        if (value['presente'] == true) {
          var url = await uploadData(value['urlFoto'], value['bytes'] as Uint8List);
          if (url != null && url.isNotEmpty) {
            ApiCallResponse? apiResultkvw =
                await AicionarPresencaOfflineCall.call(
              codigoPessoa: int.parse(value['codigo']),
              urlFoto: url,
              date: value['data'],
            );
            if (!(apiResultkvw.succeeded)) {
              presencas.add(value);
            }
          }
        } else {
          ApiCallResponse? apiResultkvw =
              await AicionarAusenciaOfflineCall.call(
            codigoPessoa: int.parse(value['codigo']),
            date: value['data'],
          );
          if (!(apiResultkvw.succeeded)) {
            presencas.add(value);
          }
        }
      } catch (e) {
        return;
      }
    });
    read.clear();
    read.addAll(presencas);
    await GetStorage().write('presencas', read);
  }
}

String formatUrlUploadFile(String url) {
  return url.replaceAll('users/uploads/', 'users%2Fuploads%2F');
}

String formatUrlUploadImage(String url) {
  return url.replaceAll('users/uploads/', 'users%2Fuploads%2F');
}

bool podeApresentarVideoJustificando(
  bool presente,
  bool justificado,
  String? urlVideo,
) {
  return !presente && justificado && urlVideo != null;
}

bool podeApresentarFotoPresenca(
  bool presente,
  String? urlFoto,
) {
  return presente == true && urlFoto != null;
}

bool checarCodigoMarcacao(
  String codigo,
  List<String> codigos,
) {
  var cod = codigos.firstWhere((codig) => codig == codigo, orElse: () => '');
  return cod != '';
}
