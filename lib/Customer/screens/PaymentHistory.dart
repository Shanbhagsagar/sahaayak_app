import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:sahaayak_app/constants.dart';


class PaymentHistory extends StatefulWidget {

  const PaymentHistory(this.muid, {Key? key}) : super(key: key);
  final String? muid;
  @override
  _PaymentHistoryState createState() => _PaymentHistoryState();
}

class _PaymentHistoryState extends State<PaymentHistory> {

   @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: new EdgeInsets.all(5.0),
        // height: MediaQuery
        //     .of(context)
        //     .size
        //     .height,
        decoration: kBackgroundBoxDecoration,
        child: StreamBuilder<QuerySnapshot<Map<String,dynamic>>>(
            stream:  FirebaseFirestore.instance.collection('Payments').where('customerID',isEqualTo: widget.muid).snapshots(),
            builder: (context,snapshot){

              if(snapshot.connectionState== ConnectionState.active){

                if(snapshot.data!.size > 0){

                  Map<String,dynamic> activePMap={};
                  snapshot.data!.docs.forEach((element) { activePMap.putIfAbsent(element.id.toString(), () => element.data());});
                  List<String> payMapKeys = activePMap.keys.toList();

                  print(activePMap);
                  return ListView.builder(
                     scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: activePMap.length,
                    itemBuilder: (context, index) {
                      print(index);
                      return PaymentCards(activePMap[payMapKeys[index]]);
                    },
                  );

                }
                else{
                  return Center(child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'images/sad.png',
                        height: 100.0,
                        width: 100.0,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        'No Data Found',
                        style: TextStyle(
                          fontFamily: kFontFamily1,
                          fontSize: 22.0,
                            color: HexColor("#01274a")
                        ),
                      )
                    ],
                  ),);
                }
              }
             return Text("Service Down");
            }),
      ),
    );
  }
}

class PaymentCards extends StatelessWidget {
  const PaymentCards(this.activePMap,{Key? key}) : super(key: key);
  final Map<String,dynamic> activePMap;
  @override
  Widget build(BuildContext context) {

     bool isRefunded = true;

     String? paid;

     if(activePMap['paid'] == true){
       paid = 'Paid';
     }

     if(activePMap['paid'] == false){
       paid = 'Refunded';
       isRefunded = false;
     }

     DateTime bkDt = (activePMap['bookingDate'] as Timestamp).toDate();
     DateFormat formatter = DateFormat.yMd().add_jm();
     return  Padding(
     padding: const EdgeInsets.only(top: 15.0),
     child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Colors.white,
          elevation: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, left: 8.0),
                child: ListTile(
                  leading: Icon(
                    isRefunded == false ? Icons.arrow_circle_down_rounded:Icons.arrow_circle_up_rounded,
                    color:  isRefunded == false ? Colors.red.shade900:Colors.green.shade900,
                  ),
                  title: Text(
                    "Transaction No: ${activePMap['transID']}",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: kFontFamily1,
                        fontWeight: FontWeight.bold),
                  ),
                  trailing: Text(
                    "${NumberFormat.simpleCurrency(name: 'INR', decimalDigits: 0).format(activePMap['amount'])}",
                    style: TextStyle(
                        fontSize: 25.0,
                        color:  isRefunded == false ? Colors.red.shade900:Colors.green.shade900,
                        fontFamily: kFontFamily1,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 80.0),
                child: Text(
                  "Service ID: ${activePMap['serviceID']}",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: kFontFamily1,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 80.0, top: 5.0),
                child: Text(
                  "Sahayaak Name: \n${activePMap['housekeeperName']}",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: kFontFamily1,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 80.0, top: 5.0),
                child: Text(
                  "Status: $paid",
                  style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: kFontFamily1,
                      color: isRefunded == false ? Colors.red.shade900:Colors.green.shade900,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 80.0, top: 5.0, bottom: 20.0),
                child: Text(
                  "Date:  ${formatter.format(bkDt)}",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: kFontFamily1,
                  ),
                ),
              ),
            ],
          )),
   );
  }
}
