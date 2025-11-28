class ExampleUser {
  /// 示例用户名。
  String? username;

  ExampleUser({
    this.username,
  });

  factory ExampleUser.fromJson(Map<String, dynamic> json) => ExampleUser(
        username: json['username'],
      );

  Map<String, dynamic> toJson() => {
        'username': username,
      };

  @override
  String toString() {
    return 'User{username: $username}';
  }
}
