import 'package:flutter/cupertino.dart';

class ActionButton extends StatelessWidget {
  final Function() onTap;
  final bool isCreateMode;
  const ActionButton({
    super.key,
    required this.isCreateMode,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onTap,
      child: isCreateMode ? const Text('Create') : const Text('Solve'),
    );
  }
}
