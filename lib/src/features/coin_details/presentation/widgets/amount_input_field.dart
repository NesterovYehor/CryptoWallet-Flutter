import 'package:crypto_track/src/core/extensions/buildcontext.dart';
import 'package:crypto_track/src/core/theme/app_font.dart';
import 'package:flutter/material.dart';

class AmountInputField extends StatelessWidget {
  final Function(String)? onChanged;

  const AmountInputField({
    super.key,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.2,
      child: TextField(
        keyboardType: TextInputType.number,
        style: AppFont.bold.s14,
        decoration: InputDecoration(
          hintText: context.loc.exampleValueFormat,
          hintStyle: Theme.of(context).textTheme.bodySmall,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.transparent,
              width: 0,
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.transparent,
              width: 0,
            ),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
