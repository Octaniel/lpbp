import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

final String url1 = "http://192.168.0.142:8080/";
final String url11 = "http://192.168.42.131:8080/";
final String url2 = "https://lpbp.herokuapp.com/";
final String url = url2;

String decoder(String body) {
  body = body.replaceAll('Ã§', 'ç');
  body = body.replaceAll('Ãµ', 'õ');
  body = body.replaceAll('Ã', 'Ç');
  body = body.replaceAll('Ã©', 'é');
  body = body.replaceAll('Ã£', 'ã');
  body = body.replaceAll('Ã³', 'ó');
  body = body.replaceAll('Ã', 'Á');
  return body;
}

Future<String> saveArquivo(String nome, String path) async {
  StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(nome);
  StorageUploadTask uploadTask = firebaseStorageRef.putFile(File(path));
  await uploadTask.onComplete;
  return await firebaseStorageRef.getDownloadURL();
}
