import '../../data/model/card.dart';

abstract class IUseCase<T, P> {
  Future<List<HearthstoneCard>> fetchData({
    required String endpoint,
  });
}
