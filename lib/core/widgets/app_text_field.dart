import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myfinanceapp/core/theme/app_colors.dart';
import 'package:myfinanceapp/core/theme/app_radius.dart';
import 'package:myfinanceapp/core/theme/app_text_styles.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.hint,
    this.label,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.enabled = true,
    this.autofocus = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.focusNode,
  });

  const AppTextField.password({
    super.key,
    this.controller,
    this.hint = 'Password',
    this.label,
    this.textInputAction,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.enabled = true,
    this.autofocus = false,
    this.prefixIcon,
    this.focusNode,
  })  : obscureText = true,
        keyboardType = TextInputType.visiblePassword,
        inputFormatters = null,
        suffixIcon = null,
        maxLines = 1,
        minLines = null,
        maxLength = null;

  final TextEditingController? controller;
  final String? hint;
  final String? label;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final String? Function(String?)? validator;
  final bool enabled;
  final bool autofocus;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final FocusNode? focusNode;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _obscured;

  @override
  void initState() {
    super.initState();
    _obscured = widget.obscureText;
  }

  OutlineInputBorder _border(Color color) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        borderSide: BorderSide(width: 0.5, color: color),
      );

  @override
  Widget build(BuildContext context) {
    final isPassword = widget.obscureText;

    var suffix = widget.suffixIcon;
    if (isPassword) {
      suffix = IconButton(
        icon: Icon(
          _obscured ? Icons.visibility_off_outlined : Icons.visibility_outlined,
          color: AppColors.textMuted,
          size: 20,
        ),
        onPressed: () => setState(() => _obscured = !_obscured),
      );
    }

    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      obscureText: _obscured,
      enabled: widget.enabled,
      autofocus: widget.autofocus,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      inputFormatters: widget.inputFormatters,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onSubmitted,
      validator: widget.validator,
      maxLines: isPassword ? 1 : widget.maxLines,
      minLines: widget.minLines,
      maxLength: widget.maxLength,
      style: AppTextStyles.bodyMedium,
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      decoration: InputDecoration(
        filled: true,
        isDense: true,
        fillColor: AppColors.bgCard,
        labelText: widget.label,
        hintText: widget.hint,
        hintStyle:
            AppTextStyles.bodyMedium.copyWith(color: AppColors.textMuted),
        prefixIcon: widget.prefixIcon,
        suffixIcon: suffix,
        border: _border(AppColors.borderCard),
        enabledBorder: _border(AppColors.borderCard),
        focusedBorder: _border(AppColors.accentBlue),
        disabledBorder: _border(AppColors.borderCard),
        errorBorder: _border(AppColors.accentRed),
        focusedErrorBorder: _border(AppColors.accentRed),
      ),
    );
  }
}
