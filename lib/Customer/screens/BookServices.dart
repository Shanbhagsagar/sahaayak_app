import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:nanoid/nanoid.dart';
import 'package:sahaayak_app/Customer/components/Payment.dart';
import 'package:sahaayak_app/Shared/components/validation.dart';
import 'package:sahaayak_app/authentication_service.dart';
import 'package:sahaayak_app/constants.dart';

class BookServices extends StatefulWidget {
  const BookServices(this.custUID, this.displayName);

  final String? custUID;
  final String? displayName;

  @override
  _BookServicesState createState() => _BookServicesState();
}

class _BookServicesState extends State<BookServices> {
  final _formKey = GlobalKey<FormState>();
  static TextEditingController _addressController = TextEditingController();
  static String? cityDropDownVal;
  static int? _payPrice = _servicePrice[_serviceNameList[0]];
  static int _payDays = 1;
  static late int selectedRadioTile = 1;
  static int _currentMonth = DateTime.now().month;
  static int _currentYear = DateTime.now().year;
  static int _currentDay = DateTime.now().day;

  findLastDate() {
    return DateTime(_currentYear, _currentMonth == 12 ? 1 : _currentMonth, 0)
        .day;
  }

  findStartDate() {
    if (_currentDay + 1 >
        DateTime(_currentYear, _currentMonth == 12 ? 1 : _currentMonth, 0).day)
      return 1;
    else
      return _currentDay + 1;
  }

  static Map<String, bool> _serviceList = {
    "Standard Cleaning": true,
    "Premium Cleaning": false,
    "Elderly Care": false,
    "Child Care": false,
    "Cooking": false
  };

  static final Map<String, int> _servicePrice = {
    "Standard Cleaning": 30,
    "Premium Cleaning": 55,
    "Elderly Care": 1000,
    "Child Care": 100,
    "Cooking": 80
  };

  static List<String> _serviceNameList = [
    "Standard Cleaning",
    "Premium Cleaning",
    "Elderly Care",
    "Child Care",
    "Cooking"
  ];

  late DateTimeRange _date = DateTimeRange(
    start: DateTime(_currentYear, _currentMonth, findStartDate()),
    end: DateTime(
        _currentYear, _currentMonth == 12 ? 1 : _currentMonth + 1, _currentDay),
  );

  late TimeOfDay _time = TimeOfDay(
      hour: TimeOfDay.now().hour == 12 ? 01 : TimeOfDay.now().hour + 1,
      minute: TimeOfDay.now().minute >= 59 ? 00 : TimeOfDay.now().minute + 1);

  customDivider() {
    return Divider(
      thickness: .5,
      color: HexColor("#01274a"),
    );
  }

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
      priceCalcLogic();
    });
  }

  priceCalcLogic() async {
    dynamic tempPrice = 0;
    _serviceList.forEach((key, value) {
      if (value) tempPrice += _servicePrice[key];
    });
    _payPrice = tempPrice * _payDays;
  }

  setSelectedCheckboxTile(bool val, String s) {
    setState(() {
      _serviceList.update(s, (value) => !_serviceList[s]!);
      priceCalcLogic();
    });
  }

  void _selectDate() async {
    final DateTimeRange? newDate = await showDateRangePicker(
      context: context,
      initialDateRange: _date,
      firstDate: DateTime(_currentYear, _currentMonth, findStartDate()),
      lastDate: DateTime(_currentYear,
          _currentMonth == 12 ? 1 : _currentMonth + 1, _currentDay),
      helpText: 'Select days to hire Sahaayak',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            primaryColor: HexColor("#01274a"),
            colorScheme: ColorScheme.light(
              primary: HexColor("#01274a"), // body text color
            ),
          ),
          child: child!,
        );
      },
    );
    if (newDate != null) {
      DateTimeRange tdr = newDate;
      setState(() {
        _payDays = tdr.duration.inDays + 1;
        _date = newDate;
        priceCalcLogic();
      });
    }
  }

  void _selectTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            primaryColor: HexColor("#01274a"),
            colorScheme: ColorScheme.light(
                primary: HexColor("#01274a"),
                secondary: Colors.white // body text color
                ),
          ),
          child: child!,
        );
      },
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
        priceCalcLogic();
      });
    }
  }

  setPersistentCheck() {
    setState(() {
      _serviceList.update("Standard Cleaning", (value) => true);
      priceCalcLogic();
    });
    return true;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor("#01274a"),
        centerTitle: true,
        title: Text('Book Services'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: 320,
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 10.0,
                  ),
                  customDivider(),
                  Text(
                    "Location and Gender",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: kFontFamily1,
                    ),
                  ),
                  customDivider(),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.person,
                        color: Colors.blueGrey,
                        size: 30.0,
                      ),
                      Expanded(
                        child: Container(
                          child: RadioListTile(
                            value: 1,
                            groupValue: selectedRadioTile,
                            title: Text("Male"),
                            onChanged: (dynamic val) {
                              setSelectedRadioTile(val);
                            },
                            activeColor: HexColor("#01274a"),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: RadioListTile(
                            value: 2,
                            groupValue: selectedRadioTile,
                            title: Text("Female"),
                            onChanged: (dynamic val) {
                              setSelectedRadioTile(val);
                            },
                            activeColor: HexColor("#01274a"),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  DropdownButtonFormField(
                    validator: (value) {
                      return Validation.locCityValidation(cityDropDownVal);
                    },
                    value: cityDropDownVal,
                    elevation: 10,
                    onChanged: (newValue) {
                      setState(() {
                        cityDropDownVal = newValue.toString();
                        priceCalcLogic();
                      });
                    },
                    decoration: InputDecoration(
                      labelStyle: TextStyle(
                        fontFamily: kFontFamily1,
                        color: HexColor("#01274a"),
                        fontWeight: FontWeight.bold,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                      labelText: 'City',
                    ),
                    items: <String>[
                      'Thane',
                      'Dombivli',
                      'Kalyan',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                    controller: _addressController,
                    validator: (value) {
                      return Validation.locAddressValidation(
                          _addressController.text);
                    },
                    style: TextStyle(
                      fontFamily: kFontFamily1,
                      color: HexColor("#01274a"),
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Address',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                    ),
                    keyboardType: TextInputType.streetAddress,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  customDivider(),
                  Text(
                    "Services",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: kFontFamily1,
                    ),
                  ),
                  customDivider(),
                  CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    secondary: Tooltip(
                      waitDuration: Duration(milliseconds: 20),
                      showDuration: Duration(seconds: 5),
                      message:
                          'This package includes house floor cleaning, dish & clothes washing',
                      child: Icon(
                        Icons.info,
                        size: 30.0,
                        color: HexColor("#01274a"),
                      ),
                    ),
                    value: _serviceList[_serviceNameList[0]]! ||
                            _serviceList[_serviceNameList[1]]! ||
                            _serviceList[_serviceNameList[2]]! ||
                            _serviceList[_serviceNameList[3]]! ||
                            _serviceList[_serviceNameList[4]]!
                        ? _serviceList[_serviceNameList[0]]
                        : setPersistentCheck(),
                    title: Text(_serviceNameList[0]),
                    subtitle: Text("\u{20B9}" +
                        _servicePrice[_serviceNameList[0]].toString() +
                        " per day"),
                    onChanged: (dynamic val) {
                      setSelectedCheckboxTile(val, _serviceNameList[0]);
                    },
                  ),
                  CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    value: _serviceList[_serviceNameList[1]],
                    subtitle: Text("\u{20B9}" +
                        _servicePrice[_serviceNameList[1]].toString() +
                        " per day"),
                    secondary: Tooltip(
                      waitDuration: Duration(milliseconds: 20),
                      showDuration: Duration(seconds: 5),
                      message:
                          'This package contains premium cleaning services, lavatory, fan & furniture cleaning',
                      child: Icon(
                        Icons.info,
                        size: 30.0,
                        color: HexColor("#01274a"),
                      ),
                    ),
                    title: Text(_serviceNameList[1]),
                    onChanged: (dynamic val) {
                      setSelectedCheckboxTile(val, _serviceNameList[1]);
                    },
                  ),
                  CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    value: _serviceList[_serviceNameList[2]],
                    subtitle: Text("\u{20B9}" +
                        _servicePrice[_serviceNameList[2]].toString() +
                        " per day"),
                    title: Text(_serviceNameList[2]),
                    onChanged: (dynamic val) {
                      setSelectedCheckboxTile(val, _serviceNameList[2]);
                    },
                  ),
                  CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    value: _serviceList[_serviceNameList[3]],
                    title: Text(_serviceNameList[3]),
                    subtitle: Text("\u{20B9}" +
                        _servicePrice[_serviceNameList[3]].toString() +
                        " per day"),
                    onChanged: (dynamic val) {
                      setSelectedCheckboxTile(val, _serviceNameList[3]);
                    },
                  ),
                  CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    value: _serviceList[_serviceNameList[4]],
                    subtitle: Text("\u{20B9}" +
                        _servicePrice[_serviceNameList[4]].toString() +
                        " per day"),
                    title: Text(_serviceNameList[4]),
                    onChanged: (dynamic val) {
                      setSelectedCheckboxTile(val, _serviceNameList[4]);
                    },
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  customDivider(),
                  Text(
                    "Date and Time",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: kFontFamily1,
                    ),
                  ),
                  customDivider(),
                  SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.calendar_today_outlined,
                        color: Colors.blueGrey,
                        size: 23.0,
                      ),
                      Expanded(
                        child: Text(
                          _payDays == 1
                              ? " Needed for 1 Day"
                              : _payDays > 1
                                  ? "Needed for $_payDays Days"
                                  : " Select Days",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: kFontFamily1,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: ElevatedButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  HexColor("#01274a")),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  side: BorderSide(
                                    color: HexColor("#01274a"),
                                  ),
                                ),
                              ),
                            ),
                            onPressed: () {
                              _selectDate();
                            },
                            child: const Text('Select Date'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.access_time,
                        color: Colors.blueGrey,
                        size: 23.0,
                      ),
                      Expanded(
                        child: Text(
                          "Time ${_time.format(context)}",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: kFontFamily1,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: ElevatedButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  HexColor("#01274a")),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  side: BorderSide(
                                    color: HexColor("#01274a"),
                                  ),
                                ),
                              ),
                            ),
                            onPressed: () {
                              _selectTime();
                            },
                            child: const Text('Select Time'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 35.0,
                  ),
                  Text(
                    "Total : ${_payPrice == null ? 'Calculating' : NumberFormat.simpleCurrency(name: 'INR', decimalDigits: 0).format(_payPrice)}",
                    style: TextStyle(
                        fontSize: 22.0,
                        fontFamily: kFontFamily1,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints.tightForFinite(
                            height: 40.0, width: double.maxFinite),
                        child: ElevatedButton(
                            child: Text("Request".toUpperCase(),
                                style: TextStyle(
                                    fontSize: 20.0, fontFamily: kFontFamily1)),
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  HexColor("#01274a")),
                            ),
                            onPressed: () async {
                              try {
                                if (_formKey.currentState!.validate()) {
                                  String serviceArray = "";
                                  String gender = selectedRadioTile.isOdd
                                      ? "Male"
                                      : "Female";
                                  String id = customAlphabet('1234567890', 7);
                                  _serviceList.forEach((key, value) {
                                    if (value == true) serviceArray += ",$key";
                                  });

                                  Map<String, dynamic> requestData = {
                                    "requestID": id,
                                    "customerID": widget.custUID,
                                    "customerName": widget.displayName,
                                    "customerAddress": _addressController.text,
                                    "housekeeperID": null,
                                    "gender": gender,
                                    "city": cityDropDownVal!,
                                    "services": serviceArray.substring(1),
                                    "days": _payDays,
                                    "fromDate":
                                        '${_date.start.year}-${_date.start.month}-${_date.start.day}',
                                    "toDate": _payDays == 1
                                        ? '${_date.start.year}-${_date.start.month}-${_date.start.day}'
                                        : '${_date.end.year}-${_date.end.month}-${_date.end.day}',
                                    "time": "${_time.hour}:${_time.minute}",
                                    "price": _payPrice,
                                    "accepted": false,
                                  };

                                  print(requestData);

                                  requestSetup(id, requestData)
                                      .whenComplete(() {
                                    print('//RequestSetup Done');
                                  });

                                  Stream<DocumentSnapshot<Map<String, dynamic>>>
                                      reqDocStream = FirebaseFirestore.instance
                                          .collection('Requests')
                                          .doc(id)
                                          .snapshots();

                                  showModalBottomSheet<void>(
                                    isDismissible: false,
                                    enableDrag: false,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return StreamBuilder<
                                              DocumentSnapshot<
                                                  Map<String, dynamic>>>(
                                          stream: reqDocStream,
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.active) {
                                              Map<String, dynamic>? requestMap =
                                                  snapshot.data!.data();
                                              bool accepted =
                                                  requestMap!['accepted'];

                                              print(
                                                  '$requestMap inside StreamBuilder');

                                              print('//CLEAR');
                                              try {
                                                if(accepted==true){
                                                  Future.delayed(const Duration(milliseconds: 2000), () {
                                                    Navigator.of(context).pop();
                                                    Navigator.of(context).pop();
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute<void>(
                                                          builder: (BuildContext context) => PaymentScreen(widget.displayName,requestMap),
                                                          fullscreenDialog: true,
                                                        ));
                                                  });
                                                }
                                                return accepted == false
                                                    ? Container(
                                                        height: 300,
                                                        child: Column(
                                                          children: [
                                                            Align(
                                                              alignment: Alignment
                                                                  .bottomRight,
                                                              child: IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  icon: Icon(Icons
                                                                      .close)),
                                                            ),
                                                            Container(
                                                              height: 200,
                                                              child: Center(
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: <
                                                                      Widget>[
                                                                    const Center(
                                                                      child:
                                                                          CircularProgressIndicator(),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          15,
                                                                    ),
                                                                    const Text(
                                                                      'Waiting for a Saahayak to accept the request',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            18.0,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontFamily:
                                                                            kFontFamily1,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    : Container(
                                                        height: 300,
                                                        child: Column(
                                                          children: [
                                                            Align(
                                                              alignment: Alignment
                                                                  .bottomRight,
                                                              child: IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  icon: Icon(Icons
                                                                      .close),color: Colors.white,splashColor: Colors.white,),
                                                            ),
                                                            Container(
                                                              height: 200,
                                                              child: Center(
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: <
                                                                      Widget>[
                                                                    Center(child: Icon(Icons.thumb_up,color: Colors.green.shade900,)),
                                                                    SizedBox(
                                                                      height:
                                                                          15,
                                                                    ),
                                                                    const Text(
                                                                      'A Saahayak has accepted your request',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            18.0,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontFamily:
                                                                            kFontFamily1,
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                      15,
                                                                    ),
                                                                    Center(
                                                                      child: const Text(
                                                                        'Redirecting',
                                                                        style:
                                                                        TextStyle(
                                                                          fontSize:
                                                                          18.0,
                                                                          fontWeight:
                                                                          FontWeight.bold,
                                                                          fontFamily:
                                                                          kFontFamily1,
                                                                        ),
                                                                      ),
                                                                    ),

                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                              } on Exception catch (e) {
                                                print(e);
                                                return MyProgressIndicator();
                                              }
                                            }
                                            return MyProgressIndicator();
                                          });
                                    },
                                  );

                                  // requestSetup(id, requestData)
                                  //     .whenComplete(() =>SnackBar(
                                  //   behavior: SnackBarBehavior.floating,
                                  //   content: Text('Request has been successfully posted'),
                                  // ),
                                  // );
                                }
                              } catch (Ex) {
                                print("##########BookService#########");
                                print(Ex);
                              }
                            }),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Center MyProgressIndicator() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
