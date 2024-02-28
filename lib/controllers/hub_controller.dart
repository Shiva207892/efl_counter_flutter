import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HubsController extends GetxController {
  final List<String> hubIds;
  HubsController({required this.hubIds});

  RxString selectedHub = ''.obs;
  RxString selectedCustomer = ''.obs;
  List<String> customers = <String>[].obs;

  // Rx variables to hold the hubs data
  RxList<QueryDocumentSnapshot<Object?>> hubs =
      RxList<QueryDocumentSnapshot<Object?>>();

  final CollectionReference _hubsCollection =
      FirebaseFirestore.instance.collection('Hubs');

  var _customersCollection = FirebaseFirestore.instance.collection('Customers');

  // Rx variables to hold the hubs data
  RxList<QueryDocumentSnapshot<Object?>> customersList =
  RxList<QueryDocumentSnapshot<Object?>>();

  @override
  void onInit() {
    super.onInit();

    _customersCollection.snapshots().listen((QuerySnapshot customer) {
      customersList.addAll(customer.docs);
    });

    // Listen for changes in the 'hubs' collection where the document ID is in the provided list
    _hubsCollection
        .where(FieldPath.documentId, whereIn: hubIds)
        .snapshots()
        .listen((QuerySnapshot hub) {
      // Specify the correct generic type for QuerySnapshot
      // Update the hubs data with the new snapshot
      hubs.addAll(hub.docs);
      if (kDebugMode) {
        print('Your $hubIds $hubIds total hubs: ${hubs.length}');
      }
    });
  }

  // Getter to access the hubs data from other screens
  List<Object> get hubsData => hubs.map((doc) => doc.data()!).toList();

  void updateSelectedHub(String hubId) {
    print('updated hub id is: $hubId ${hubId.isEmpty} hubs: $hubs');
    selectedHub.value = hubId;
    selectedCustomer.value = '';
    customers = [];
    if (hubId.isNotEmpty) {
      // Find the hub with the matching ID
      QueryDocumentSnapshot<Object?>? selectedHubData =
          hubs.firstWhere((hub) => hub.id == hubId);
      // Update the customers value if the hub is found
      if (selectedHubData.data() != null) {
        var customersList =
            (selectedHubData.data() as Map<String, dynamic>?)?['customers'];
        if (customersList != null && customersList is List) {
          customers = customersList.map((e) => e.toString()).toList();
        }
      }
    }
  }
}
