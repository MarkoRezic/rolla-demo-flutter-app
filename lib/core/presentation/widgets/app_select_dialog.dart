import 'package:flutter/material.dart';
import 'package:rolla_demo_app/core/localization/tr.dart';

/// Reusable selection dialog.
/// - Generic over T (option type)
/// - Shows a list of radio items
/// - Selected item is highlighted using primaryColor with low opacity
/// - Items have material splash (using RadioListTile)
/// - Callbacks: onCancel, onAccept, onSelectionChanged
/// - Options: barrierDismissible (tap outside), closeOnBannerTap (tap title area)
class AppSelectDialog<T> extends StatefulWidget {
  const AppSelectDialog({
    super.key,
    this.title,
    this.subtitle,
    required this.options,
    this.initialSelected,
    required this.optionLabel,
    this.onCancel,
    this.onAccept,
    this.onSelectionChanged,
    this.onCancelText = 'Cancel',
    this.onAcceptText = 'OK',
    this.barrierDismissible = true,
    this.closeOnBannerTap = false,
    this.maxHeight = 360,
  });

  /// Optional title shown in the dialog header
  final String? title;

  /// Optional subtitle shown under the title
  final String? subtitle;

  /// The list of options to display
  final List<T> options;

  /// Initially selected option (may be null)
  final T? initialSelected;

  /// Function that produces display label for each option
  final String Function(T option) optionLabel;

  /// Called when user cancels (via cancel button, barrier close, or banner tap)
  final VoidCallback? onCancel;

  /// Called when user accepts the current selection. Will be passed the selected item (may be null).
  final void Function(T? selected)? onAccept;

  /// Called whenever the selection changes (user taps an option)
  final void Function(T? selected)? onSelectionChanged;

  /// Cancel label override
  final String onCancelText;

  /// Accept label override
  final String onAcceptText;

  /// Whether tapping outside the dialog closes it
  final bool barrierDismissible;

  /// Whether tapping the title/banner closes the dialog (invokes onCancel)
  final bool closeOnBannerTap;

  /// Max height of the options area (so dialog doesn't grow too big)
  final double maxHeight;

  /// Helper: show the dialog and return the selected value if accepted, else null.
  static Future<T?> show<T>({
    required BuildContext context,
    String? title,
    String? subtitle,
    required List<T> options,
    T? initialSelected,
    required String Function(T) optionLabel,
    VoidCallback? onCancel,
    void Function(T?)? onAccept,
    void Function(T?)? onSelectionChanged,
    String? onCancelText,
    String? onAcceptText,
    bool barrierDismissible = true,
    bool closeOnBannerTap = false,
    double maxHeight = 360,
  }) async {
    onCancelText = onCancelText ?? tr.cancel;
    onAcceptText = onAcceptText ?? tr.ok;

    final T? result = await showDialog<T?>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext ctx) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 24.0,
          ),
          child: AppSelectDialog<T>(
            title: title,
            subtitle: subtitle,
            options: options,
            initialSelected: initialSelected,
            optionLabel: optionLabel,
            onCancel: onCancel,
            onAccept: onAccept,
            onSelectionChanged: onSelectionChanged,
            onCancelText: onCancelText!,
            onAcceptText: onAcceptText!,
            barrierDismissible: barrierDismissible,
            closeOnBannerTap: closeOnBannerTap,
            maxHeight: maxHeight,
          ),
        );
      },
    );

    return result;
  }

  @override
  State<AppSelectDialog<T>> createState() => _AppSelectDialogState<T>();
}

class _AppSelectDialogState<T> extends State<AppSelectDialog<T>> {
  T? _selected;

  @override
  void initState() {
    _selected = widget.initialSelected;
    super.initState();
  }

  void _handleCancel() {
    widget.onCancel?.call();
    Navigator.of(context).pop();
  }

  void _handleAccept() {
    widget.onAccept?.call(_selected);
    Navigator.of(context).pop(_selected);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color tileSelectedColor = theme.colorScheme.primary.withValues(
      alpha: 0.06,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        // Header / Banner
        Material(
          color: Colors.transparent,
          child: InkWell(
            // if closeOnBannerTap, tapping the banner cancels
            onTap: widget.closeOnBannerTap ? _handleCancel : null,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
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

        // Divider
        const Divider(height: 0),

        // Options list (constrained)
        Flexible(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: widget.maxHeight),
            child: RadioGroup<T>(
              groupValue: _selected,
              onChanged: (T? v) {
                setState(() {
                  _selected = v;
                });
                widget.onSelectionChanged?.call(_selected);
              },
              child: ListView.separated(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: widget.options.length,
                separatorBuilder: (_, _) => const Divider(height: 0),
                itemBuilder: (BuildContext context, int index) {
                  final T option = widget.options[index];
                  final String label = widget.optionLabel(option);
                  final bool isSelected = _selected == option;

                  return RadioListTile<T>(
                    value: option,
                    title: Text(label),
                    selected: isSelected,
                    selectedTileColor: tileSelectedColor,
                    controlAffinity: ListTileControlAffinity.trailing,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                    ),
                  );
                },
              ),
            ),
          ),
        ),

        // Buttons
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                onPressed: _handleCancel,
                child: Text(widget.onCancelText),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: _selected == null ? null : _handleAccept,
                child: Text(widget.onAcceptText),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
