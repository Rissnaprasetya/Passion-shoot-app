import 'package:flutter/material.dart';
import 'package:proj_passion_shoot/config/theme/app_theme.dart';

class AddButton extends StatelessWidget {
  const AddButton({super.key, required this.onPressed,});

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: const CircleBorder(),
      onPressed: onPressed,
      backgroundColor: primaryColor,
      child: Icon(Icons.add,color: alternativeColor,),
    );
  }
}