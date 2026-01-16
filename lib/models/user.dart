class ExampleUser {
  /// 示例用户名。
  String? username;
  /// 示例用户ID。

  String? user_id;


  ExampleUser({
    this.username,
    this.user_id,
  });

  factory ExampleUser.fromJson(Map<String, dynamic> json) => ExampleUser(
        username: json['username'],
        user_id: json['user_id'],
      );

  Map<String, dynamic> toJson() => {
        'username': username,
        'user_id': user_id,
      };

  @override
  String toString() {
    return 'User{username: $username user_id: $user_id}';
  }
}
