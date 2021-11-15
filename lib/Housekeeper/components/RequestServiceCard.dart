import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sahaayak_app/Housekeeper/components/RequestCard.dart';

class RequestServiceCard extends StatelessWidget {
  const RequestServiceCard(this.huid, {
    Key? key,
  }) : super(key: key);
  final String? huid;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: new EdgeInsets.all(5.0),
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance.collection('Requests').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              Map<String, dynamic> requestMap = {};
              snapshot.data!.docs.forEach((element) {
                requestMap.putIfAbsent(
                    element.id.toString(), () => element.data());
              });
              List<String> requestMapKeys = requestMap.keys.toList();

              print('//CLEAR');
              try {
                print(requestMap[requestMapKeys[0]]);
              } catch (e, s) {
                return Center(child: Text('- - No service request found - -'));
              }


              return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: requestMap.length,
                itemBuilder: (context, index) {
                    print(index);
                    if(requestMap[requestMapKeys[index]]['accepted']==false)
                    return RequestCard(requestMapKeys, requestMap, index,huid);
                    else
                    return SizedBox(height: 0,);
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
