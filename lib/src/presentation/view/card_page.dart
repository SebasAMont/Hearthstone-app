import 'package:flutter/material.dart';

import '../../core/util/constants_assets.dart';
import '../../core/util/constants_dimensions.dart';
import '../../core/util/constants_logic.dart';
import '../../core/util/constants_strings.dart';
import '../../data/model/card.dart';
import '../widget/image_box.dart';
import '../widget/visibility_text.dart';

class CardPage extends StatefulWidget {
  final HearthstoneCard hearthstoneCard;

  const CardPage({
    required this.hearthstoneCard,
    super.key,
  });

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
            appBarCardPageTitle,
            style: TextStyle(
              fontSize: appBarCardPageTitleFontSize,
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
                    Padding(
                      padding: const EdgeInsets.only(
                        left: cardTextPaddingLeftTopRight,
                        top: cardTextPaddingLeftTopRight,
                        right: cardTextPaddingLeftTopRight,
                        bottom: cardTextPaddingBottom,
                      ),
                      child: Column(
                        children: <Widget>[
                          VisibilityText(
                            cardAttribute:
                                '$cardName  ${widget.hearthstoneCard.name}',
                            isVisible: true,
                          ),
                          VisibilityText(
                            cardAttribute:
                                '$cardText ${widget.hearthstoneCard.text}',
                            isVisible: widget.hearthstoneCard.text != null,
                          ),
                          VisibilityText(
                            cardAttribute:
                                '$cardHealth ${widget.hearthstoneCard.health}',
                            isVisible: widget.hearthstoneCard.health !=
                                defaultCardHealth,
                          ),
                          VisibilityText(
                            cardAttribute:
                                '$cardType ${widget.hearthstoneCard.type}',
                            isVisible: widget.hearthstoneCard.type != null,
                          ),
                          VisibilityText(
                            cardAttribute:
                                '$cardLocale ${widget.hearthstoneCard.locale}',
                            isVisible: true,
                          ),
                          VisibilityText(
                            cardAttribute:
                                '$cardSet ${widget.hearthstoneCard.cardSet}',
                            isVisible: true,
                          ),
                          VisibilityText(
                            cardAttribute:
                                '$cardPlayerClass ${widget.hearthstoneCard.playerClass}',
                            isVisible:
                                widget.hearthstoneCard.playerClass != null,
                          ),
                          Visibility(
                            visible:
                                widget.hearthstoneCard.mechanics!.isNotEmpty,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: cardPageListViewPaddingTop,
                                  ),
                                  child: VisibilityText(
                                    cardAttribute: cardMechanics,
                                    isVisible: widget
                                        .hearthstoneCard.mechanics!.isNotEmpty,
                                  ),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    padding: const EdgeInsets.all(
                                      cardListPaddingListView,
                                    ),
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: widget
                                        .hearthstoneCard.mechanics!.length,
                                    itemBuilder: (
                                      BuildContext context,
                                      index,
                                    ) {
                                      return VisibilityText(
                                        cardAttribute:
                                            ' ${widget.hearthstoneCard.mechanics![index]}',
                                        isVisible: widget.hearthstoneCard
                                            .mechanics!.isNotEmpty,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: cardImageBoxSizeWidth,
                            height: cardImageBoxSizeHeight,
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: ImageBox(
                                widgetImg: widget.hearthstoneCard.img,
                              ),
                            ),
                          )
                        ],
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
                              width: elevatedButtonSideBorderWidthRadiusValue,
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
                        '$cardPageCounterText $_counter',
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
