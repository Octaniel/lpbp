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
