import 'package:flutter/cupertino.dart';

class ActionSheetDemo extends StatelessWidget {
  const ActionSheetDemo({super.key});

  void _showActionSheet(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(context),
            isDefaultAction: true,
            child: const Text("Do something"),
          ),
          CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(context),
            isDestructiveAction: true,
            child: const Text("Delete"),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("ActionSheetDemo"),
      ),
      child: Center(
        child: CupertinoButton.filled(
          onPressed: () => _showActionSheet(context),
          child: const Text("Show Action Sheet"),
        ),
      ),
    );
  }
}
