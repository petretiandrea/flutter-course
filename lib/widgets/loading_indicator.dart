import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final String _loadingMessage;

  LoadingIndicator(this._loadingMessage);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(
            height: 8,
          ),
          Text(this._loadingMessage),
        ],
      ),
    );
  }
}
