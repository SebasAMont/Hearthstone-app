import 'package:firebase_core/firebase_core.dart';
import 'package:first_app/src/domain/usecase/implementation/fetch_data_usecase.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'src/core/util/constants_strings.dart';
import 'src/data/datasource/local/DAOs/card_database.dart';
import 'src/data/datasource/remote/card_api_provider.dart';
import 'src/domain/repository/repository_card.dart';
import 'src/presentation/bloc/card_bloc.dart';
import 'src/presentation/view/card_list.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const HearthstoneCardApp());
}

class HearthstoneCardApp extends StatefulWidget {
  const HearthstoneCardApp({super.key});

  @override
  State<HearthstoneCardApp> createState() => _HearthstoneCardAppState();
}

class _HearthstoneCardAppState extends State<HearthstoneCardApp> {
  static final CardDatabase cardDatabase = CardDatabase();

  static final Client client = Client();

  static final CardApiProvider cardApi = CardApiProvider(
    client: client,
  );

  static final RepositoryCard repositoryCard = RepositoryCard(
    client: client,
    cardsApi: cardApi,
    cardDatabase: cardDatabase,
  );
  static final FetchDataUseCase fetchDataUseCase =
      FetchDataUseCase(repositoryCard: repositoryCard);

  static CardBloc cardBloc = CardBloc(
    repositoryCard: repositoryCard,
    fetchDataUseCase: fetchDataUseCase,
  );

  @override
  void initState() {
    super.initState();

    cardBloc.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: materialAppTitle,
      home: CardList(
        cardBloc: cardBloc,
      ),
    );
  }
}
