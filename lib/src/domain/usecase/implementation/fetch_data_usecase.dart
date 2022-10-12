import 'package:first_app/src/data/model/card.dart';
import '../../../core/usecases/i_usecase.dart';
import '../../repository/repository_card.dart';

class FetchDataUseCase implements IUseCase<List<HearthstoneCard>, String> {
  FetchDataUseCase({required this.repositoryCard});

  final RepositoryCard repositoryCard;

  @override
  Future<List<HearthstoneCard>> fetchData({
    required String endpoint,
  }) async {
    return repositoryCard.addCardList(endpoint);
  }
}
