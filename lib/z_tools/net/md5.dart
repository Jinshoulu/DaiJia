
import 'package:crypto/crypto.dart';
// md5 加密
import 'dart:convert';

String generateMd5(String data) {
  var content = new Utf8Encoder().convert(data);
  var digest = md5.convert(content);
  // 这里其实就是 digest.toString()
  return digest.toString();
}

