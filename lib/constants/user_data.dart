import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
///user
String? Name ='';
String? email ='';
String? phone ='';
String? image ='';
String? uid ='';
List? ongoingList =[];
 List aSlotList =[];
///bokked
 String? name='Smart village parking';
 String? description='smart village , giza alex road ,cairo';
 int? price=0;
double? rate =3.5;
 String? slot='';
 String? image_booked='https://pps.whatsapp.net/v/t61.24694-24/308458920_199456039171955_1472090132316113708_n.jpg?ccb=11-4&oh=01_AdQtNf686-Ox6V8QRwWJuPMhnDYbnoDqxau78jOYXAkYmg&oe=64B04DFD';
 String? start_time='';
 String? end_time='';
 String? duration='';
 String? date='';




void getUserData(){
  FirebaseFirestore.instance.collection('users').doc( FirebaseAuth.instance.currentUser?.uid).get().then((value) {
    var data = value.data();
    Name = data?['name'];
    uid = data?['uid'];
    image = data?['image'];
    phone = data?['phone'];
    email = data?['email'];
   ongoingList = data?['booked'];


    print('${data?['booked'].length}');
    print('${data?['booked'][0]['total_price']}');
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
Future<void> reservation() async {

  var docRef = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid);

  docRef.update({
    'booked': FieldValue.arrayUnion([
      {
        'act_price': '20',
        'date': date,
        'total_price': price,
        'start_time': start_time,
        'slot': slot,
        'rate': rate,
        'name': name,
        'image': image_booked,
        'end_time': end_time,
        'duration': duration,
        'description': description,


      },
    ])
  }).then((_) {
    getUserData();
    print('Item added to the array successfully');
  }).catchError((error) {
    print('Error adding item to the array: $error');
  });
}
Future<void> deleteBooking(index) async {
  var docRef = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid);



  docRef.get().then((docSnapshot) {
    if (docSnapshot.exists) {
      var docData = docSnapshot.data() as Map<String, dynamic>;
      var arrayField = docData['booked'] as List<dynamic>;

      if (arrayField.length > 1) {
        arrayField.removeAt(index); // Remove item at index 2

        docRef.update({'booked': arrayField}).then((_) {
          getUserData();
          print('Item at index 2 deleted successfully');
        }).catchError((error) {
          print('Error deleting item at index 2: $error');
        });
      } else {
        print('Index 2 is out of range');
      }
    } else {
      print('Document does not exist');
    }
  }).catchError((error) {
    print('Error retrieving document: $error');
  });

}
