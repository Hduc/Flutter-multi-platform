import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    Key? key,
    this.textController,
    this.icon,
    this.label,
    this.requiredMessage,
    this.errorText,
    this.isRequired = false,
    this.hasPassword = false,
    this.inputType = TextInputType.text,
    this.action = TextInputAction.done,
    this.onChange,
  }) : super(key: key);

  final TextEditingController? textController;
  final Icon? icon;
  final String? label;
  final String? requiredMessage;
  final String? errorText;
  final bool isRequired;
  final bool hasPassword;
  final TextInputType inputType;
  final TextInputAction action;
  final ValueChanged<String>? onChange;

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late TextEditingController _textController;

  bool _isVisiblePassword = false;

  final FocusNode _customFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _textController = widget.textController ?? TextEditingController();
    _isVisiblePassword = widget.hasPassword;
  }

  @override
  void dispose() {
    _customFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
        children: <Widget>[
          TextFormField(
            controller: _textController,
            keyboardType: widget.inputType,
            onChanged: widget.onChange,
            textInputAction: widget.action,
            obscureText: _isVisiblePassword,
            decoration: InputDecoration(
              icon: widget.icon,
              labelText: widget.label,
              border: const OutlineInputBorder(),
              fillColor: Colors.white,
              errorText: widget.errorText,
              suffixIcon: widget.hasPassword
                  ? IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(
                        Icons.remove_red_eye,
                        size: 24,
                      ),
                      onPressed: _visiblePassword,
                    )
                  : widget.errorText != null
                      ? const Icon(Icons.error)
                      : const Icon(Icons.check_circle),
            ),
          ),
        ],
      );

  void _visiblePassword() {
    setState(() {
      _isVisiblePassword = !_isVisiblePassword;
    });
  }
}
