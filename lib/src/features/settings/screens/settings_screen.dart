import 'package:crypto_track/src/core/extensions/buildcontext.dart';
import 'package:crypto_track/src/widgets/logo_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.settings,
            style: Theme.of(context).textTheme.titleSmall),
      ),
      body: Column(
        children: [
          CupertinoFormSection(
            children:[ Row(
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LogoWidget(width: MediaQuery.of(context).size.width * 0.25),
                      Text(
                        context.loc.appDescription,
                        style: Theme.of(context).textTheme.bodySmall,
                        overflow: TextOverflow.clip,
                      )
                    ],
                  ),
                ),
              ],
            ),]
          ),
        ],
      ),
    );
  }
}
