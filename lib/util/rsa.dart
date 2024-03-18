import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/asymmetric/api.dart';

/// RSA 签名
class Rsa {
  Rsa._();

  static String sign({required String key, required String data}) {
    final privateKey = RSAKeyParser().parse(key);
    // Dec

    final signer = Signer(RSASigner(RSASignDigest.SHA256,
        privateKey: privateKey as RSAPrivateKey));
    return signer.sign(data).base64;
  }
}
