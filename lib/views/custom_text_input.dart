import 'package:flutter/material.dart';
import 'package:sms/constantes/theme.dart';

class CustomTextInput extends StatefulWidget {
  final String text;
  final IconData? icon;
  final TextInputType? keyBoardType;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  const CustomTextInput(
      {Key? key,
      required this.text,
      this.icon,
      this.keyBoardType,
      this.validator,
      this.controller})
      : super(key: key);

  @override
  State<CustomTextInput> createState() => _CustomTextInputState();
}

class _CustomTextInputState extends State<CustomTextInput>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 3))..repeat(reverse: true);
  late final Animation<Offset> _animation =
      Tween(begin: const Offset(1, 0), end: Offset.zero).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  FocusNode focusNode = FocusNode();
  bool isPassword = false;
  bool isVisible = true;
  @override
  void initState() {
    setState(() {
      isPassword = widget().keyBoardType == TextInputType.visiblePassword;
    });
    focusNode.addListener(_onFocusChange);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    focusNode.removeListener(_onFocusChange);
    focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          focusNode.hasFocus
              ? const BoxShadow(
                  color: MyColor.secondaryGray,
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                )
              : const BoxShadow(),
        ]),
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: isPassword
            ? TextFormField(
                keyboardType: widget().keyBoardType,
                obscureText: isVisible,
                focusNode: focusNode,
                validator: widget().validator,
                controller: widget().controller,
                decoration: InputDecoration(
                    errorStyle: const TextStyle(height: 0, fontSize: 0),
                    labelText: widget().text,
                    icon: const Icon(Icons.https),
                    fillColor: Colors.black,
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isVisible = !isVisible;
                        });
                      },
                      icon: isVisible
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                    )),
              )
            : TextFormField(
                keyboardType: widget().keyBoardType,
                focusNode: focusNode,
                validator: widget().validator,
                controller: widget().controller,
                decoration: InputDecoration(
                  errorStyle: const TextStyle(height: 0, fontSize: 0),
                  labelText: widget().text,
                  icon: Icon(widget().icon),
                  fillColor: MyColor.primaryGray,
                  focusColor: MyColor.primaryGray,
                  border: InputBorder.none,
                ),
              ),
      ),
    );
  }
}

// class TextInput extends TextFormField {
//   final FocusNode focusNode = FocusNode();
//   final String? text;
//   final IconData? icon;
//   TextInput({Key? key, String? Function(String?)? validator, this.text, this.icon,})
//       : super(
//           key: key,
//           validator: ,
//           decoration: InputDecoration(
//             labelText: text,
//             icon: Icon(icon),
//             fillColor: MyColor.primaryGray,
//             focusColor: MyColor.primaryGray,
//             border: InputBorder.none,
//           ),
//         );
// }
