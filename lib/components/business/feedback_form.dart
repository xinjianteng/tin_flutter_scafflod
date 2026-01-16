/// 使用方法：FeedbackForm(state: state, onSubmit: submit);
import 'package:flutter/material.dart';
import 'package:tin_flutter_scafflod/components/atoms/app_button.dart';
import 'package:tin_flutter_scafflod/components/atoms/app_input.dart';
import 'package:tin_flutter_scafflod/utils/validate_util.dart';

/// 业务组件：反馈表单。
class FeedbackForm extends StatelessWidget {
  const FeedbackForm({
    super.key,
    required this.formKey,
    required this.contentController,
    required this.contactController,
    required this.categories,
    required this.selectedCategory,
    required this.onCategoryChanged,
    required this.onSubmit,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController contentController;
  final TextEditingController contactController;
  final List<String> categories;
  final String selectedCategory;
  final ValueChanged<String?> onCategoryChanged;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButtonFormField<String>(
            value: selectedCategory,
            items: categories
                .map(
                  (item) => DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  ),
                )
                .toList(),
            onChanged: onCategoryChanged,
            decoration: const InputDecoration(
              labelText: '反馈类型',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          AppInput(
            controller: contentController,
            label: '问题描述',
            hintText: '请描述遇到的问题或建议',
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.newline,
            minLines: 4,
            maxLines: 6,
            validator: (value) => ValidateUtil.validateNotEmpty(
              value ?? '',
              message: '请输入反馈内容',
            ),
          ),
          const SizedBox(height: 12),
          AppInput(
            controller: contactController,
            label: '联系方式（选填）',
            hintText: '手机号或邮箱',
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            validator: (value) {
              final text = value?.trim() ?? '';
              if (text.isEmpty) return null;
              return ValidateUtil.validateAccount(text);
            },
          ),
          const SizedBox(height: 16),
          const Text('截图（可选）'),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(3, (index) {
              return Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.add_a_photo_outlined),
              );
            }),
          ),
          const SizedBox(height: 20),
          AppButton(label: '提交反馈', onPressed: onSubmit),
        ],
      ),
    );
  }
}
