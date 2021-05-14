import 'dart:html' as html;
import 'dart:js' as js;
import 'dart:typed_data';

import 'package:flutter/foundation.dart';

Future<void> share({
  @required Uint8List bytes,
  @required String filename,
  @required String mimetype,
}) async {
  if (!kIsWeb) {
    throw UnimplementedError('Share is only implemented on Web');
  }

  final blob = html.Blob(
    <Uint8List>[bytes],
    mimetype,
  );
  final url = html.Url.createObjectUrl(blob);
  final html.HtmlDocument doc = js.context['document'];
  // ignore: avoid_as
  final link = doc.createElement('a') as html.AnchorElement;
  link.href = url;
  link.download = filename;
  link.click();
}
