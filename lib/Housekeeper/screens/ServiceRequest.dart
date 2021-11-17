import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sahaayak_app/Housekeeper/components/RequestServiceCard.dart';

class ServiceRequest extends StatefulWidget {
  const ServiceRequest(this.huid,this.hname,this.phoneNumber,{Key? key}) : super(key: key);
  final String? huid;
  final String? hname;
  final String? phoneNumber;

  @override
  _ServiceRequestState createState() => _ServiceRequestState();
}

class _ServiceRequestState extends State<ServiceRequest> {

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
        title: Text('Request Services'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: 320,
            child: RequestServiceCard(widget.huid,widget.hname,widget.phoneNumber),
          ),
        ),
      ),
    );
  }
}
