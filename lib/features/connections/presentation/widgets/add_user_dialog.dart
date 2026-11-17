import 'package:flutter/material.dart';

/// Pop-up that lets the user find someone by email or phone number.
class AddUserDialog extends StatefulWidget {
  const AddUserDialog({required this.onSearch, super.key});

  /// Called with the trimmed email/phone the user entered.
  final ValueChanged<String> onSearch;

  /// Shows the dialog and returns when it is dismissed.
  static Future<void> show(
    BuildContext context, {
    required ValueChanged<String> onSearch,
  }) {
    return showDialog<void>(
      context: context,
      builder: (_) => AddUserDialog(onSearch: onSearch),
    );
  }

  @override
  State<AddUserDialog> createState() => _AddUserDialogState();
}

class _AddUserDialogState extends State<AddUserDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final query = _controller.text.trim();
    if (query.isEmpty) return;

    widget.onSearch(query);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add a user'),
      content: TextField(
        controller: _controller,
        autofocus: true,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.search,
        onSubmitted: (_) => _submit(),
        decoration: const InputDecoration(
          labelText: 'Email or phone number',
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(onPressed: _submit, child: const Text('Search')),
      ],
    );
  }
}
