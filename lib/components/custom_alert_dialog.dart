import 'package:flutter/cupertino.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    Key? key,
    required this.title,
    this.message,
  }) : super(key: key);

  final String title;
  final String? message;

  static Future<void> show(BuildContext context,String title){
    return showCupertinoDialog(
        context: context,
        builder: (_)=>CustomAlertDialog(
            title: title,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(message ?? ''),
      actions: [
        CupertinoDialogAction(
            child: const Text(
              'okay',
            ),
          onPressed: ()=>Navigator.pop(context),
        )
      ],
    );
  }
}
