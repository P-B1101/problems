import 'package:flutter/cupertino.dart';

class ActionButton extends StatelessWidget {
  final Function() onTap;
  final bool isCreateMode;
  final String text;
  final bool isText;
  const ActionButton._({
    required this.isCreateMode,
    required this.onTap,
    required this.text,
    required this.isText,
  });

  factory ActionButton.text({
    required String text,
    required Function() onTap,
  }) =>
      ActionButton._(
        isCreateMode: false,
        isText: true,
        onTap: onTap,
        text: text,
      );

  factory ActionButton.mode({
    required bool isCreateMode,
    required Function() onTap,
  }) =>
      ActionButton._(
        isText: false,
        isCreateMode: isCreateMode,
        onTap: onTap,
        text: '',
      );

  @override
  Widget build(BuildContext context) {
    return CupertinoButton.filled(
      onPressed: onTap,
      child: isText
          ? Text(text)
          : isCreateMode
              ? const Text('Create')
              : const Text('Solve'),
    );
  }
}
