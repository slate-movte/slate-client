import 'package:flutter/material.dart';

class TextBoard extends StatelessWidget {
  final String title;
  final String content;
  final bool onTrailing;
  final Widget? trailing;

  const TextBoard({
    super.key,
    required this.title,
    required this.content,
    this.onTrailing = false,
    this.trailing,
  }) : assert(trailing == null || onTrailing,
            'Trailing wideget is only available when onTrailing is true.');

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Row(
            children: [
              Text(title),
              Visibility(
                visible: onTrailing,
                child: trailing ?? SizedBox(),
              ),
            ],
          ),
        ),
        Text(content),
      ],
    );
  }
}
