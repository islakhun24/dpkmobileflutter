// ignore_for_file: unnecessary_this, non_constant_identifier_names

class Auth {
  String access_token;

  Auth(this.access_token);

  factory Auth.fromJson(dynamic json) {
    return Auth(json['accessToken'] as String);
  }

  @override
  String toString() {
    return this.access_token;
  }
}
