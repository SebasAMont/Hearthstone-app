import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/util/constants_strings.dart';
// ignore_for_file: avoid_dynamic_calls

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class CardDatabase {
  Future<void> addItem({
    required List<dynamic> cardList,
    required String subCollectionDoc,
  }) async {
    final CollectionReference firebaseCollection =
        _firestore.collection(subCollectionDoc);
    for (final card in cardList) {
      final DocumentReference documentReferencer = firebaseCollection.doc(
        card![docRefCardId] as String,
      );

      documentReferencer.set(
        card,
        SetOptions(
          merge: true,
        ),
      );
    }
  }

  Future<QuerySnapshot> readItems({
    required String subCollectionDoc,
  }) async {
    final CollectionReference firebaseCollection =
        _firestore.collection(subCollectionDoc);
    _firestore.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    );
    final CollectionReference cardItemCollection = firebaseCollection;
    final cardResponse = await cardItemCollection.get();
    return cardResponse;
  }

  Future<void> updateItem({
    required List<dynamic> cardList,
    required String docId,
    required String subCollectionDoc,
  }) async {
    final CollectionReference firebaseCollection =
        _firestore.collection(subCollectionDoc);
    final DocumentReference documentReferencer = firebaseCollection.doc(docId);

    final List<dynamic> data = cardList;

    await documentReferencer.update(
      {docId: data},
    );
  }

  Future<void> deleteItem({
    required String docId,
    required String subCollectionDoc,
  }) async {
    final CollectionReference firebaseCollection =
        _firestore.collection(subCollectionDoc);
    final DocumentReference documentReferencer = firebaseCollection.doc(docId);

    await documentReferencer.delete();
  }
}
