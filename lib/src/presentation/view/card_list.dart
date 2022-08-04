import 'package:flutter/material.dart';
import '../../core/util/card_constants.dart';
import '../../data/model/card.dart';
import '../../data/repository/data_handler.dart';
import 'card_page.dart';

class CardList extends StatelessWidget {
  CardList({
    super.key,
  });

  final DataHandler _dataHandler = DataHandler();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              appBarCardListTitle,
              style: TextStyle(
                fontSize: appBarCardListTitleFontSize,
              ),
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
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: cardTextPaddingLeftTopRight,
                        top: cardTextPaddingLeftTopRight,
                        right: cardTextPaddingLeftTopRight,
                        bottom: cardTextPaddingBottom,
                      ),
                      child: FutureBuilder<List<HearthstoneCard>>(
                        future: _dataHandler.readCardJson(),
                        builder: (
                          BuildContext context,
                          AsyncSnapshot<List<HearthstoneCard>> snapshot,
                        ) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          }
                          if (snapshot.hasData) {
                            return ListView.builder(
                              padding: const EdgeInsets.all(
                                cardListPaddingListView,
                              ),
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data?.length,
                              itemBuilder: (
                                BuildContext context,
                                index,
                              ) {
                                return ListTile(
                                  title: Text(
                                    snapshot.data![index].name,
                                    style: const TextStyle(
                                      fontSize: cardTextInfoFontSize,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            CardPage(
                                          hearthstoneCard:
                                              snapshot.data![index],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          } else {
                            return const SizedBox(
                              child: Text(
                                cardListListViewError,
                              ),
                            );
                          }
                        },
                      ),
                    )
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
