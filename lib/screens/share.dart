import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
class Share extends StatefulWidget {
  @override
  _ShareState createState() => _ShareState();
}

class _ShareState extends State<Share> {
  Future<void> share() async {
    await FlutterShare.share(
        title: 'Example share',
        text: 'Example share text',
        linkUrl: 'https://flutter.dev/',
        chooserTitle: 'Example Chooser Title'
    );
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: FlatButton(
            onPressed: share,
          child: Text('Share this app'),
        ),
      ),
    );
  }
}
