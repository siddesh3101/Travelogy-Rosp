import 'package:flutter/material.dart';

class DescribePrompt extends StatefulWidget {
  const DescribePrompt(
      {super.key,
      required this.onSubmit,
      required this.onTextChanged,
      required this.isIntro});

  final VoidCallback onSubmit;
  final VoidCallback onTextChanged;

  final bool isIntro;

  @override
  State<DescribePrompt> createState() => DescribePromptState();
}

class DescribePromptState extends State<DescribePrompt> {
  final border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
  );

  final errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(color: Colors.red),
  );

  final qrTitleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Describe your prompt',
          style: TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        TextFormField(
          onFieldSubmitted: (text) {
            if (text.isNotEmpty) widget.onSubmit();
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: qrTitleController,
          decoration: InputDecoration(
            enabledBorder: border,
            border: border,
            focusedBorder: border,
            errorBorder: errorBorder,
            focusedErrorBorder: errorBorder,
          ),
        ),
      ],
    );
  }
}
