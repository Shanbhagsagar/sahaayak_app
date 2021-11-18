import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:sahaayak_app/Housekeeper/components/RequestCard.dart';
import 'package:sahaayak_app/constants.dart';

class HiredTransactions extends StatefulWidget {
  const HiredTransactions(this.huid,{Key? key}) : super(key: key);
  final String? huid;

  @override
  _HiredTransactionsState createState() => _HiredTransactionsState();
}

class _HiredTransactionsState extends State<HiredTransactions> {
  int today = int.parse('${DateTime.now().month}' + '${DateTime.now().day}');
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Expanded(
        //height: MediaQuery.of(context).size.height,
        //decoration: kBackgroundBoxDecoration,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              Center(
                  child: Container(
                    width: 500,
                    padding: new EdgeInsets.all(5.0),
                    child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream: FirebaseFirestore.instance
                            .collection('Services')
                            .where('housekeeperID', isEqualTo: widget.huid)
                            .where('toDateInt', isLessThanOrEqualTo: today)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.active) {
                            if (snapshot.data!.size > 0) {
                              Map<String, dynamic> activeHMap = {};
                              snapshot.data!.docs.forEach((element) {
                                activeHMap.putIfAbsent(
                                    element.id.toString(), () => element.data());
                              });
                              List<String> hireMapKeys = activeHMap.keys.toList();

                              print(activeHMap);
                              return ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                itemCount: activeHMap.length,
                                itemBuilder: (context, index) {
                                  print(index);
                                  return HiredCards(activeHMap[hireMapKeys[index]]);
                                },
                              );
                            } else {
                              return Center(
                                child: Column(
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
                                          color: HexColor("#01274a")),
                                    )
                                  ],
                                ),
                              );
                            }
                          }
                          return Text("Service Down");
                        }),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class HiredCards extends StatelessWidget {
  const HiredCards(this.activeHMap, {Key? key}) : super(key: key);
  final Map<String, dynamic> activeHMap;

  @override
  Widget build(BuildContext context) {
    print(activeHMap);

    String? paid;
    if (activeHMap['paid'] == true) {
      paid = 'Paid';
    }

    List<String> serviceChips =
    activeHMap['services'].toString().trim().split(',');
    DateTime todayInBuild = DateTime.now();
    DateFormat formatter = DateFormat('MMMd');

    DateTime fromDt = (activeHMap['fromDate'] as Timestamp).toDate();
    DateTime toDt = (activeHMap['toDate'] as Timestamp).toDate();

    String svExpiry = '${toDt.difference(todayInBuild).inDays + 1} Days';
    if ((toDt.difference(todayInBuild).inDays) == 0)
      svExpiry = '${toDt.difference(todayInBuild).inHours + 24} Hours';

    return Padding(
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
                    "Service No: ${activeHMap['serviceId']}",
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
              ServiceTextField(
                  icon: Icons.person, text: activeHMap['customerName']),
              ServiceTextField(
                  icon: Icons.house,
                  text:
                  '${activeHMap['customerAddress']}, ${activeHMap['city']}'),
              formatter.format(fromDt) != formatter.format(toDt)
                  ? ServiceTextField(
                  icon: Icons.date_range,
                  text:
                  'From ${formatter.format(fromDt)} To ${formatter.format(toDt)}')
                  : ServiceTextField(
                  icon: Icons.date_range,
                  text: 'On ${formatter.format(fromDt)}'),
              ServiceTextField(
                  icon: Icons.schedule,
                  text: '${activeHMap['days']} Days, At ${activeHMap['time']}'),
              ServiceTextField(
                  icon: Icons.work,
                  text: 'Serviced ${activeHMap['attendance']} Days'),
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
              SizedBox(
                height: 10.0,
              )
            ],
          )),
    );
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