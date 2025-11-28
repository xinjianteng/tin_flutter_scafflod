/// 模拟的 OAuth 数据模型。
class ExampleOauth {
  String? accessToken;
  String? userId;
  String? userName;

  ExampleOauth({
    this.accessToken,
    this.userId,
    this.userName,
  });

  factory ExampleOauth.fromJson(Map<String, dynamic> json) => ExampleOauth(
        accessToken: json['access_token'],
        userId: json['user_id'] ?? json['example_user_id'],
        userName: json['user_name'] ?? json['example_user_name'],
      );

  Map<String, dynamic> toJson() => {
        'access_token': accessToken,
        'user_id': userId,
        'user_name': userName,
      };
}
