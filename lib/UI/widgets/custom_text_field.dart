import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final FocusNode? focusNode;
  final Widget? icon;
  final Widget? suffixIcon;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final EdgeInsetsGeometry padding;
  final Gradient? focusGradient;
  final bool isPasswordTextField;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.focusNode,
    this.icon,
    this.suffixIcon,
    this.onChanged,
    this.keyboardType,
    this.padding = const EdgeInsets.all(3),
    this.focusGradient,
    this.isPasswordTextField = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late FocusNode _focusNode;
  bool _isFocused = false;
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_handleFocusChange);
    _obscureText = widget.obscureText;
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    } else {
      _focusNode.removeListener(_handleFocusChange);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gradient = widget.focusGradient ??
        const LinearGradient(colors: [
          Color.fromARGB(255, 122, 199, 245),
          Color.fromARGB(255, 54, 92, 242)
        ]);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: widget.padding,
      decoration: BoxDecoration(
        gradient: _isFocused ? gradient : null,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextFormField(
        controller: widget.controller,
        focusNode: _focusNode,
        obscureText:
            widget.isPasswordTextField ? _obscureText : widget.obscureText,
        onChanged: (value) {
          if (widget.isPasswordTextField) {
            setState(() {
              _obscureText = value.isNotEmpty ? _obscureText : true;
            });
          }
          if (widget.onChanged != null) widget.onChanged!(value);
        },
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          prefixIcon: widget.icon,
          suffixIcon: widget.isPasswordTextField
              ? (widget.suffixIcon ??
                  (widget.controller.text.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                          icon: Icon(_obscureText
                              ? Icons.visibility_off
                              : Icons.visibility),
                        )
                      : null))
              : widget.suffixIcon,
          filled: true,
          fillColor: const Color.fromARGB(255, 213, 232, 251),
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: _isFocused
                ? BorderSide.none
                : const BorderSide(color: Colors.grey, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
