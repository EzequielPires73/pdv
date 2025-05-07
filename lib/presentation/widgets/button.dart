import 'package:flutter/material.dart';

enum ButtonVariant { outlined, filled, text, danger, secondary, success }

class Button extends StatelessWidget {
  final String label;
  final Function()? onPressed;
  final Widget? icon;
  final ButtonVariant variant;
  final bool isLoading;
  final bool full;

  const Button({
    super.key,
    this.onPressed,
    required this.label,
    this.icon,
    this.variant = ButtonVariant.filled,
    this.isLoading = false,
    this.full = true,
  });

  Widget getWidget() {
    final bool isDisabled = isLoading || onPressed == null;

    Widget buttonContent =
        isLoading
            ? const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 2.0,
            )
            : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[icon!, const SizedBox(width: 8)],
                Text(
                  label,
                  style: TextStyle(
                    color:
                        variant == ButtonVariant.secondary
                            ? Colors.blue.shade700
                            : null,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            );

    switch (variant) {
      case ButtonVariant.filled:
      case ButtonVariant.danger:
        return SizedBox(
          width: full ? double.infinity : null,
          height: 48,
          child: FilledButton(
            onPressed: isDisabled ? null : onPressed,
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(
                variant == ButtonVariant.danger
                    ? Colors.redAccent
                    : Colors.orange,
              ),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            child: buttonContent,
          ),
        );
      case ButtonVariant.secondary:
        return SizedBox(
          width: full ? double.infinity : null,
          height: 48,
          child: FilledButton(
            onPressed: isDisabled ? null : onPressed,
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.blue.shade50),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            child: buttonContent,
          ),
        );
      case ButtonVariant.success:
        return SizedBox(
          width: full ? double.infinity : null,
          height: 48,
          child: FilledButton(
            onPressed: isDisabled ? null : onPressed,
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.green),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            child: buttonContent,
          ),
        );
      case ButtonVariant.outlined:
        return SizedBox(
          width: full ? double.infinity : null,
          height: 48,
          child: OutlinedButton(
            onPressed: isDisabled ? null : onPressed,
            style: ButtonStyle(
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            child: buttonContent,
          ),
        );
      case ButtonVariant.text:
        return SizedBox(
          width: full ? double.infinity : null,
          height: 48,
          child: TextButton(
            onPressed: isDisabled ? null : onPressed,
            style: ButtonStyle(
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            child: buttonContent,
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return getWidget();
  }
}
