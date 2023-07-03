import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

String? Name ='';
String? email ='';
String? phone ='';
String? image ='';
String? uid ='';
 List aSlotList =[];
void getUserData(){
  FirebaseFirestore.instance.collection('users').doc( FirebaseAuth.instance.currentUser?.uid).get().then((value) {
    var data = value.data();
    Name = data?['name'];
    uid = data?['uid'];
    image = data?['image'];
    phone = data?['phone'];
    email = data?['email'];

    print('get user data succses $value');
  }).catchError((e){
    print('faild to get user data => $e');
  });

}

void getSlots(){
  FirebaseFirestore.instance.collection('slots').doc('NwHkLeEmjv8tCKRINtCl').get().then((value) {
    var data = value.data();
    print(data?['slot']);
    print(data?['slot'][0]);
    print(data?['slot'][0]['name']);
    aSlotList = data?['slot'];



    print('get slot succses $value');
  }).catchError((e){
    print('faild to get slot data => $e');
  });

}
Future<void> updateDocument(int id) async {
  final documentReference = FirebaseFirestore.instance.collection('slots').doc('NwHkLeEmjv8tCKRINtCl');
  final snapshot = await documentReference.get();

  if (snapshot.exists) {
    final data = snapshot.data() as Map<String, dynamic>?;
    final slotList = data?['slot'] as List<dynamic>?;

    if (slotList != null && slotList.length >= 2) {
      final slotToUpdate = slotList[id] as Map<String, dynamic>?;

      if (slotToUpdate != null) {
        slotToUpdate['AlreadyBooking'] = true;

        await documentReference.update({'slot': slotList});
        print('Document updated successfully.');
      } else {
        print('No second slot found.');
      }
    } else {
      print('No slots found or not enough slots.');
    }
  } else {
    print('Document does not exist.');
  }
}
