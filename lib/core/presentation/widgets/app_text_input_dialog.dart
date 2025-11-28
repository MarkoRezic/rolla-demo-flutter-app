import 'package:flutter/material.dart';
import 'package:rolla_demo_app/core/localization/tr.dart';

/// Reusable text input dialog.
/// - Single text field (single-line by default)
/// - Optional validator returning an error string (or null)
/// - Accept button disabled while text invalid (or empty if allowEmpty == false)
/// - Callbacks: onCancel, onAccept, onChanged
/// - Options: barrierDismissible (tap outside), closeOnBannerTap (tap title area)
class AppTextInputDialog extends StatefulWidget {
  const AppTextInputDialog({
    Key? key,
    this.title,
    this.subtitle,
    this.initialValue,
    this.hintText,
    this.labelText,
    this.maxLength,
    this.allowEmpty = false,
    this.validator,
    this.keyboardType,
    this.onCancel,
    this.onAccept,
    this.onChanged,
    this.onCancelText = 'Cancel',
    this.onAcceptText = 'OK',
    this.barrierDismissible = true,
    this.closeOnBannerTap = false,
  }) : super(key: key);

  /// Optional title shown in the dialog header
  final String? title;

  /// Optional subtitle shown under the title
  final String? subtitle;

  /// Initial text in the input field
  final String? initialValue;

  /// Input hint text (inside the field)
  final String? hintText;

  /// Input label text (above/inside the field depending on theme)
  final String? labelText;

  /// Optional max length for the input
  final int? maxLength;

  /// Whether empty value is considered valid (default false)
  final bool allowEmpty;

  /// Validator: returns an error message string when invalid, or null when valid.
  final String? Function(String value)? validator;

  /// Keyboard type for the input
  final TextInputType? keyboardType;

  /// Called when user cancels (via cancel button, barrier close, or banner tap)
  final VoidCallback? onCancel;

  /// Called when user accepts the value. Will be passed the entered string (may be empty if allowed).
  final void Function(String value)? onAccept;

  /// Called whenever the text changes
  final void Function(String value)? onChanged;

  /// Cancel label override
  final String onCancelText;

  /// Accept label override
  final String onAcceptText;

  /// Whether tapping outside the dialog closes it
  final bool barrierDismissible;

  /// Whether tapping the title/banner closes the dialog (invokes onCancel)
  final bool closeOnBannerTap;

  /// Helper: show the dialog and return the entered value if accepted, else null.
  static Future<String?> show({
    required BuildContext context,
    String? title,
    String? subtitle,
    String? initialValue,
    String? hintText,
    String? labelText,
    int? maxLength,
    bool allowEmpty = false,
    String? Function(String value)? validator,
    TextInputType? keyboardType,
    VoidCallback? onCancel,
    void Function(String value)? onAccept,
    void Function(String value)? onChanged,
    String? onCancelText,
    String? onAcceptText,
    bool barrierDismissible = true,
    bool closeOnBannerTap = false,
  }) async {
    onCancelText = onCancelText ?? tr.cancel;
    onAcceptText = onAcceptText ?? tr.ok;

    final result = await showDialog<String?>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (ctx) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 24.0,
          ),
          child: AppTextInputDialog(
            title: title,
            subtitle: subtitle,
            initialValue: initialValue,
            hintText: hintText,
            labelText: labelText,
            maxLength: maxLength,
            allowEmpty: allowEmpty,
            validator: validator,
            keyboardType: keyboardType,
            onCancel: onCancel,
            onAccept: onAccept,
            onChanged: onChanged,
            onCancelText: onCancelText!,
            onAcceptText: onAcceptText!,
            barrierDismissible: barrierDismissible,
            closeOnBannerTap: closeOnBannerTap,
          ),
        );
      },
    );

    return result;
  }

  @override
  State<AppTextInputDialog> createState() => _AppTextInputDialogState();
}

class _AppTextInputDialogState extends State<AppTextInputDialog> {
  late final TextEditingController _controller;
  String? _errorText;
  bool _touched =
      false; // whether user interacted (so we show validation after first change)

  @override
  void initState() {
    _controller = TextEditingController(text: widget.initialValue ?? '');
    // initial validation
    _errorText = _validate(_controller.text);
    _controller.addListener(_onTextChanged);
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    super.dispose();
  }

  String? _validate(String value) {
    // If a custom validator is provided, use it.
    final custom = widget.validator?.call(value);
    if (custom != null) return custom;

    // Default: non-empty required unless allowEmpty == true
    if (!widget.allowEmpty && value.trim().isEmpty) {
      return 'Please enter a value';
    }
    // Otherwise valid
    return null;
  }

  void _onTextChanged() {
    final text = _controller.text;
    final newError = _validate(text);
    final changed = newError != _errorText;
    if (changed || !_touched) {
      setState(() {
        _errorText = newError;
        _touched = true;
      });
    } else {
      // If nothing changed visually, still trigger onChanged callback
      // but avoid unnecessary setState.
    }
    widget.onChanged?.call(text);
  }

  void _handleCancel() {
    widget.onCancel?.call();
    Navigator.of(context).pop(null);
  }

  void _handleAccept() {
    final value = _controller.text;
    // Final validation check
    final err = _validate(value);
    if (err != null) {
      setState(() {
        _errorText = err;
        _touched = true;
      });
      return;
    }

    widget.onAccept?.call(value);
    Navigator.of(context).pop(value);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Header / Banner
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.closeOnBannerTap ? _handleCancel : null,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.title != null)
                    Text(
                      widget.title!,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  if (widget.subtitle != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        widget.subtitle!,
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),

        const Divider(height: 0),

        // Input area
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: TextField(
            controller: _controller,
            autofocus: true,
            keyboardType: widget.keyboardType,
            maxLength: widget.maxLength,
            decoration: InputDecoration(
              hintText: widget.hintText,
              labelText: widget.labelText,
              errorText: _touched ? _errorText : null,
              counterText: widget.maxLength != null
                  ? null
                  : '', // show default counter only when maxLength set
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 12.0,
              ),
            ),
            onSubmitted: (_) {
              // Try to accept on submit (Enter)
              if (_errorText == null) _handleAccept();
            },
          ),
        ),

        // Buttons
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: _handleCancel,
                child: Text(widget.onCancelText),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: _errorText != null ? null : _handleAccept,
                child: Text(widget.onAcceptText),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
