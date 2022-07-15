import 'package:flutter/material.dart';
import 'card_constants.dart';

class CardPage extends StatefulWidget {
  const CardPage({Key? key}) : super(key: key);

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  int _counter = counterInitialValue;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            appBarTitle,
            style: TextStyle(
              fontSize: appBarTitleFontSize,
            ),
          ),
          backgroundColor: Colors.black,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Stack(
              children: [
                Container(
                  height: backgroundImageContainerHeight,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        assetPathBackgroundImage,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Column(
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(
                        left: cardTextPaddingLeftTopRight,
                        top: cardTextPaddingLeftTopRight,
                        right: cardTextPaddingLeftTopRight,
                        bottom: cardTextPaddingBottom,
                      ),
                      child: Text(
                        cardTextInfo,
                        style: TextStyle(
                          fontSize: cardTextInfoFontSize,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    //  Expanded( child:
                    SizedBox(
                      width: cardImageBoxSizeWidth,
                      height: cardImageBoxSizeHeight,
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Image.asset(
                          assetPathCardImage,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _incrementCounter,
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.resolveWith(
                          (states) => elevatedButtonElevationValue,
                        ),
                        shape: MaterialStateProperty.resolveWith(
                          (states) => RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              elevatedButtonShapeBorderRadiusValue,
                            ),
                            side: const BorderSide(
                              color: Colors.black,
                              width: elevatedButtonSideBorderWidthRadiusValue,
                              style: BorderStyle.solid,
                            ),
                          ),
                        ),
                        shadowColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.purple,
                        ),
                        backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.deepPurple,
                        ),
                      ),
                      child: Text(
                        "$counterText $_counter",
                        style: const TextStyle(
                          fontSize: counterTextFontSize,
                          color: Colors.cyanAccent,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
