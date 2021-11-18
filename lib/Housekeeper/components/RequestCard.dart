import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sahaayak_app/authentication_service.dart';
import 'package:sahaayak_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RequestCard extends StatelessWidget {
  const RequestCard(this.requestMapKeys, this.requestMap, this.requestIndex, this.huid,this.hname,this.phoneNumber);

  final Map<String, dynamic> requestMap;
  final int requestIndex;
  final List<String> requestMapKeys;
  final String? huid;
  final String? hname;
  final String? phoneNumber;

  @override
  Widget build(BuildContext context) {
    List<String> serviceChips = requestMap[requestMapKeys[requestIndex]]
            ['services']
        .toString()
        .trim()
        .split(',');

    DateFormat formatter = DateFormat('MMMd');
    DateTime fromDt = (requestMap[requestMapKeys[requestIndex]]['fromDate'] as Timestamp).toDate();
    DateTime toDt = (requestMap[requestMapKeys[requestIndex]]['toDate'] as Timestamp).toDate();

    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.white,
        elevation: 10,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 8.0),
              child: ListTile(
                title: Text(
                  "Request ID: ${requestMapKeys[requestIndex]}",
                  style: TextStyle(
                      fontSize: 25.0,
                      fontFamily: kFontFamily1,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            CardServiceDisplay(Icons.person,
                requestMap[requestMapKeys[requestIndex]]['customerName']),
            CardServiceDisplay(Icons.menu_book,
                requestMap[requestMapKeys[requestIndex]]['customerAddress']),
            CardServiceDisplay(Icons.location_city,
                requestMap[requestMapKeys[requestIndex]]['city']),
            requestMap[requestMapKeys[requestIndex]]['days']==1?
            CardServiceDisplay(Icons.today,
                'On ${formatter.format(fromDt)}'):
            CardServiceDisplay(Icons.today,
                'From ${formatter.format(fromDt)} To ${formatter.format(toDt)}'),
            CardServiceDisplay(Icons.schedule,
                requestMap[requestMapKeys[requestIndex]]['time']),
            CardServiceDisplay(Icons.work,
                '${requestMap[requestMapKeys[requestIndex]]['days']} days'),
            Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Row(
                children: [
                  Icon(
                    Icons.info,
                    color: HexColor("#01274a"),
                    size: 30.0,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: serviceChips.length,
                        itemBuilder: (context, chipIndex) {
                          return ServiceChip(serviceChips, chipIndex);
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            Center(
              child: Text(
                "Payment ${NumberFormat.simpleCurrency(name: 'INR', decimalDigits: 0).format(requestMap[requestMapKeys[requestIndex]]['price'])}",
                style: TextStyle(
                    fontSize: 22.0,
                    fontFamily: kFontFamily1,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints.tightForFinite(
                      height: 40.0, width: double.maxFinite),
                  child: ElevatedButton(
                    child: Text("Accept Request".toUpperCase(),
                        style: TextStyle(
                            fontSize: 20.0, fontFamily: kFontFamily1)),
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.green.shade900),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(18.0),
                              bottomRight: Radius.circular(18.0)),
                          side: BorderSide(color: Colors.green.shade900),
                        ),
                      ),
                    ),
                    onPressed: () {
                      print('inside Card');
                      print(requestMap[requestMapKeys[requestIndex]]);
                      print('request acceptance success = ${requestAcceptance(requestMap[requestMapKeys[requestIndex]],huid,hname,phoneNumber)}');
                    },
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

class ServiceChip extends StatelessWidget {
  ServiceChip(this.serviceChips, this.chipIndex);
  int chipIndex;
  List<String> serviceChips;

  @override
  Widget build(BuildContext context) {
    return InputChip(
      label: Text(serviceChips[chipIndex]),
      labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      selected: true,
      selectedColor: Colors.grey,
      checkmarkColor: Colors.black,
    );
  }
}

class CardServiceDisplay extends StatelessWidget {
  CardServiceDisplay(this.icon, this.text);
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.0, top: 8.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: HexColor("#01274a"),
            size: 30.0,
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 20.0,
                fontFamily: kFontFamily1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
