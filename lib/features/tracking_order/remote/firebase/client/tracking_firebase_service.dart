import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flower_e_commerce/core/utils/constants/api_end_points.dart';
import 'package:flower_e_commerce/core/utils/constants/constants.dart';
import 'package:flower_e_commerce/core/utils/constants/firebase_constants.dart';
import 'package:flower_e_commerce/features/tracking_order/remote/models/remote_data_model.dart';
import 'package:injectable/injectable.dart';




@injectable
class TrackingFirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final CollectionReference<RemoteDataModel> _collectionReference;

  TrackingFirebaseService() {
    _collectionReference = _firestore
        .collection(Constants.orderRef)
        .withConverter<RemoteDataModel>(
          fromFirestore: (snap, _) => RemoteDataModel.fromJson(snap.data()!),
          toFirestore: (remoteData, _) => remoteData.toJson(),
        );
  }



  Stream<RemoteDataModel> getDataFromRemote(String orderId) {
    return _collectionReference
        .doc(orderId)
        .snapshots()
        .map((snapshot) => snapshot.data()!);
  }

  

}