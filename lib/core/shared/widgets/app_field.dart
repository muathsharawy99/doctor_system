import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../extensions/unified_extensions.dart';

/// Outlined field (radius 10).
/// - [TextInputType.visiblePassword] → obscured with an eye toggle
/// - [clearable] → red ✕ that clears the text
/// - [onTap] + [readOnly] → picker fields (dates)
class AppField extends StatefulWidget {
  const AppField({
    super.key,
    required this.controller,
    this.label,
    this.keyboardType = TextInputType.text,
    this.textInputAction,
    this.validator,
    this.clearable = false,
    this.readOnly = false,
    this.obscure = false,
    this.onTap,
  });

  final TextEditingController controller;
  final String? label;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final bool clearable;
  final bool readOnly;

  /// Always obscured, without a toggle (profile password).
  final bool obscure;
  final VoidCallback? onTap;

  @override
  State<AppField> createState() => _AppFieldState();
}

class _AppFieldState extends State<AppField> {
  bool _hidden = true;

  bool get _isPassword => widget.keyboardType == TextInputType.visiblePassword;

  Widget? _suffix(BuildContext context) {
    if (_isPassword) {
      return IconButton(
        onPressed: () => setState(() => _hidden = !_hidden),
        icon: Icon(
          _hidden ? Icons.visibility_outlined : Icons.visibility_off_outlined,
        ),
      );
    }
    if (widget.clearable) {
      return IconButton(
        onPressed: widget.controller.clear,
        icon: Icon(Icons.close_rounded, color: context.errorColor),
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      readOnly: widget.readOnly,
      onTap: widget.onTap,
      obscureText: widget.obscure || (_isPassword && _hidden),
      validator: widget.validator,
      style: context.regular,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      decoration: InputDecoration(
        label: widget.label == null ? null : Text(widget.label!),
        suffixIcon: _suffix(context),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.radiusField.r),
        ),
      ),
    );
  }
}
