import 'package:hive/hive.dart';

part 'token.g.dart';

@HiveType(typeId: 8)
class Token {
  @HiveField(0)
  String token;

  @HiveField(2)
  String? expiresIn;

  @HiveField(3)
  String refreshToken;

  Token({
    required this.token,
    this.expiresIn,
    required this.refreshToken,
  });

  factory Token.fromJson(Map<String, dynamic> data) {
    final pcToken = data['pc_token'];
    final expiresIn = data['expires_in'];
    final refreshToken = data['refresh_token'];
    return Token(
      token: pcToken,
      expiresIn: expiresIn,
      refreshToken: refreshToken,
    );
  }

  @override
  String toString() {
    return 'token---$token---$refreshToken---$expiresIn';
  }
}
