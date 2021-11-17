import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:sahaayak_app/constants.dart';
import 'package:sahaayak_app/Housekeeper/components/RequestCard.dart';

class ActiveServiceCard extends StatelessWidget {
  const ActiveServiceCard(
    this.muid, {
    Key? key,
  }) : super(key: key);
  final String? muid;

  @override
  Widget build(BuildContext context) {
    int today = int.parse('${DateTime.now().month}'+'${DateTime.now().day}');
    print(today);

    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('Services')
            .where('toDateInt', isGreaterThanOrEqualTo: today)
            .where('customerID', isEqualTo: muid)
            .snapshots(),

        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data!.size > 0) {
              Map<String, dynamic> activeSMap = {};
              snapshot.data!.docs.forEach((element) {
                activeSMap.putIfAbsent(
                    element.id.toString(), () => element.data());
              });
              List<String> serviceMapKeys = activeSMap.keys.toList();

              print(activeSMap);
              return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: activeSMap.length,
                itemBuilder: (context, index) {
                  print(index);
                  return ServiceCard(activeSMap[serviceMapKeys[index]]);
                },
              );
            } else {
              return Text('Has No Data ');
            }
          }
          return Text('Default');
        });
  }
}

class ServiceCard extends StatelessWidget {
  const ServiceCard(this.activeSMap);
  final Map<String, dynamic> activeSMap;

  @override
  Widget build(BuildContext context) {
    List<String> serviceChips =
        activeSMap['services'].toString().trim().split(',');
    DateTime todayInBuild = DateTime.now();
    DateFormat formatter = DateFormat('MMMd');

    DateTime fromDt = (activeSMap['fromDate'] as Timestamp).toDate();
    DateTime toDt = (activeSMap['toDate'] as Timestamp).toDate();

    String svExpiry = '${toDt.difference(todayInBuild).inDays+1} Days';
    if ((toDt.difference(todayInBuild).inDays)==0)
      svExpiry = '${toDt.difference(todayInBuild).inHours+24} Hours';

    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.white,
        elevation: 10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 8.0),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 34.0,
                  backgroundColor: Colors.black,
                  child: CircleAvatar(
                    radius: 30.0,
                    backgroundImage: Image.asset('images/defimg.jpg').image,
                    foregroundColor: Colors.white,
                  ),
                ),
                title: Text(
                  "Service No: ${activeSMap['serviceId']}",
                  style: TextStyle(
                      fontSize: 26.0,
                      fontFamily: kFontFamily1,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Divider(
              indent: 20,
              endIndent: 20,
              thickness: .5,
              color: HexColor("#01274a"),
            ),
            ServiceTextField(icon: Icons.person, text: activeSMap['housekeeperName']),
            ServiceTextField(icon: Icons.house, text: '${activeSMap['customerAddress']}, ${activeSMap['city']}'),
            formatter.format(fromDt)!=formatter.format(toDt)?
            ServiceTextField(icon: Icons.date_range, text: 'From ${formatter.format(fromDt)} To ${formatter.format(toDt)}'):
            ServiceTextField(icon: Icons.date_range, text: 'On ${formatter.format(fromDt)}'),
            ServiceTextField(icon: Icons.schedule, text: '${activeSMap['days']} Days, At ${activeSMap['time']}'),
            ServiceTextField(icon: Icons.work, text: 'Serviced ${activeSMap['attendance']} Days'),
            // ServiceTextField(
            //     value: activeSMap['customerAddress'], text: 'Address'),
            // ServiceTextField(value: activeSMap['city'], text: 'City'),
            // ServiceTextField(value: activeSMap['time'], text: 'Time'),
            // ServiceTextField(value: activeSMap['days'], text: 'Days'),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Icon(
                    Icons.info,
                    color: HexColor("#01274a"),
                    size: 30.0,
                  ),
                  SizedBox(
                    width: 10,
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

            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Center(
                child: Text(
                  "Your service expires in $svExpiry",
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.red.shade900,
                      fontFamily: kFontFamily1,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints.tightFor(width: 130, height: 40),
                  child: ElevatedButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.call,
                            size: 30.0,
                          ),
                          Text("Call".toUpperCase(),
                              style: TextStyle(
                                  fontSize: 20.0, fontFamily: kFontFamily1)),
                        ],
                      ),
                      style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              HexColor("#01274a")),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(
                                          color: HexColor("#01274a"))))),
                      onPressed: () => null),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints.tightForFinite(
                      height: 40.0, width: double.maxFinite),
                  child: ElevatedButton(
                      child: Text("Attendance".toUpperCase(),
                          style: TextStyle(
                              fontSize: 20.0, fontFamily: kFontFamily1)),
                      style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.green.shade900),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero,
                                      side: BorderSide(
                                          color: Colors.green.shade900)))),
                      onPressed: () => null),
                ),
              ),
            ),
            Center(
              child: ConstrainedBox(
                constraints: BoxConstraints.tightForFinite(
                    height: 40.0, width: double.maxFinite),
                child: ElevatedButton(
                    child: Text("Cancel Service".toUpperCase(),
                        style: TextStyle(
                            fontSize: 20.0, fontFamily: kFontFamily1)),
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.red.shade900),
                        shape: MaterialStateProperty
                            .all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(18.0),
                                    bottomRight: Radius.circular(18.0)),
                                side: BorderSide(color: Colors.red.shade900)))),
                    onPressed: () => null),
              ),
            ),
          ],
        ));
  }
}

class ServiceTextField extends StatelessWidget {
  const ServiceTextField({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: HexColor("#01274a"),
            size: 30.0,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 20.0,
              fontFamily: kFontFamily1,
            ),
          ),
        ],
      ),
    );
  }
}
