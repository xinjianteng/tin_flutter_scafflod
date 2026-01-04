import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tin_flutter_scafflod/init_app.dart';
import 'package:tin_flutter_scafflod/main.dart';
import 'package:tin_flutter_scafflod/values/values.dart';

void main() {
  testWidgets('应用启动渲染欢迎页', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    await initApp();
    await tester.pumpWidget(const MyApp());
    await tester.pump();

    expect(find.text(AppStrings.appName), findsWidgets);
    expect(find.text(AppStrings.appTagline), findsOneWidget);
  });
}
