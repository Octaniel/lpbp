import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import '../../auth/auth_util.dart';

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

String formatDate(String? date) {
  if (date != null) {
    return DateFormat('dd/MM/yyyy HH:mm:ss').format(DateTime.parse(date));
  }
  return '';
}

String formatDateParaBack(String? date) {
  if (date != null) {
    return DateFormat('yyyy-MM-dd').format(DateTime.parse(date));
  }
  return '';
}

String formatStringToUtf8(String arg) {
  return Uri.decodeFull(arg);
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
