// this chatbot has been made in dialogflow over the implemented nlp techniques
//and is trained to answer general questions about environment
import 'dart:html';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class IframeScreen extends StatefulWidget {
  const IframeScreen({Key? key}) : super(key: key);

  @override
  State<IframeScreen> createState() => _IframeScreenState();
}

class _IframeScreenState extends State<IframeScreen> {
  final IFrameElement _iFrameElement = IFrameElement();

  @override
  void initState() {
    super.initState();

    _iFrameElement.style.height = '98%';
    _iFrameElement.style.width = '100%';
    _iFrameElement.src = 'https://console.dialogflow.com/api-client/demo/embedded/ede26041-3e77-4aaa-b93b-aebb815206f8';
    _iFrameElement.style.border = 'none';

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'iframeElement',
          (int viewId) => _iFrameElement,
    );
  }

  final Widget _iframeWidget = HtmlElementView(
    viewType: 'iframeElement',
    key: UniqueKey(),
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
          children: [
            Expanded(
              child: _iframeWidget,
            ),
          ],
        ),
    );
  }
}


