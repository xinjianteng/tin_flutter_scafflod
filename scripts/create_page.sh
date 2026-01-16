#!/bin/bash

# Flutter 页面生成脚本
# 用法: ./scripts/create_page.sh PageName

if [ -z "$1" ]; then
  echo "错误: 请提供页面名称"
  echo "用法: ./scripts/create_page.sh PageName"
  exit 1
fi

PAGE_NAME=$1
PAGE_NAME_LOWER=$(echo "$PAGE_NAME" | tr '[:upper:]' '[:lower:]' | sed 's/page$//')
PAGE_DIR="lib/pages/${PAGE_NAME_LOWER}"

echo "正在创建页面: $PAGE_NAME"
echo "目录: $PAGE_DIR"

# 创建目录
mkdir -p "$PAGE_DIR"

# 创建 State 文件
cat > "${PAGE_DIR}/${PAGE_NAME_LOWER}_state.dart" << EOF
library;

/// 使用方法：final state = ${PAGE_NAME}State();
import 'package:get/get.dart';

class ${PAGE_NAME}State {
  final RxBool isLoading = false.obs;
}
EOF

# 创建 Logic 文件
cat > "${PAGE_DIR}/${PAGE_NAME_LOWER}_logic.dart" << EOF
library;

/// 使用方法：Get.put(${PAGE_NAME}Logic());
import 'package:get/get.dart';
import '${PAGE_NAME_LOWER}_state.dart';

class ${PAGE_NAME}Logic extends GetxController {
  final ${PAGE_NAME}State state = ${PAGE_NAME}State();

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    state.isLoading.value = true;
    try {
      // TODO: 加载数据
      await Future.delayed(const Duration(seconds: 1));
    } catch (e) {
      Get.snackbar('错误', e.toString());
    } finally {
      state.isLoading.value = false;
    }
  }
}
EOF

# 创建 View 文件
cat > "${PAGE_DIR}/${PAGE_NAME_LOWER}_view.dart" << EOF
library;

/// 使用方法：Get.toNamed(AppRoutes.${PAGE_NAME_LOWER});
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '${PAGE_NAME_LOWER}_logic.dart';

class ${PAGE_NAME}Page extends StatelessWidget {
  const ${PAGE_NAME}Page({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(${PAGE_NAME}Logic());
    final state = logic.state;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('${PAGE_NAME}'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (state.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Center(
          child: Text(
            '${PAGE_NAME} 页面',
            style: theme.textTheme.headlineMedium,
          ),
        );
      }),
    );
  }
}
EOF

echo "✅ 页面文件创建成功！"
echo ""
echo "下一步："
echo "1. 在 lib/routers/names.dart 添加路由常量:"
echo "   static const ${PAGE_NAME_LOWER} = '/${PAGE_NAME_LOWER}';"
echo ""
echo "2. 在 lib/routers/pages.dart 注册路由:"
echo "   GetPage("
echo "     name: AppRoutes.${PAGE_NAME_LOWER},"
echo "     page: () => const ${PAGE_NAME}Page(),"
echo "   ),"
echo ""
echo "3. 在 lib/pages/pages.dart 导出页面:"
echo "   export '${PAGE_NAME_LOWER}/${PAGE_NAME_LOWER}_view.dart';"
echo ""
echo "4. 使用路由跳转:"
echo "   Get.toNamed(AppRoutes.${PAGE_NAME_LOWER});"
