import 'package:flutter/material.dart';

class SelectDialog<T> extends StatefulWidget {
  final T value;
  final String title;
  final List<dynamic> values;
  const SelectDialog({
    super.key,
    required this.value,
    required this.values,
    required this.title,
  });

  @override
  State<SelectDialog<T>> createState() => _SelectDialogState<T>();
}

class _SelectDialogState<T> extends State<SelectDialog<T>> {
  late T _tempValue;

  @override
  void initState() {
    super.initState();
    _tempValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = Theme.of(context).textTheme.titleMedium!;

    return AlertDialog(
      clipBehavior: Clip.hardEdge,
      title: Text(
        widget.title,
        style: TextStyle(fontSize: 18),
      ),
      contentPadding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
      content: StatefulBuilder(builder: (context, StateSetter setState) {
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var i in widget.values) ...[
                RadioListTile(
                  dense: true,
                  value: i['value'],
                  title: Text(i['title'], style: titleStyle),
                  groupValue: _tempValue,
                  onChanged: (value) {
                    setState(() {
                      _tempValue = value as T;
                    });
                    Navigator.pop(context, _tempValue);
                  },
                ),
              ]
            ],
          ),
        );
      }),
    );
  }
}
