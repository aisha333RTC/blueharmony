import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:login_uix_firebase/helper/database_service.dart';
import 'package:login_uix_firebase/model/appointment_data.dart';
import 'package:login_uix_firebase/pages/detail_practioner_page.dart';
import 'package:login_uix_firebase/pages/profile_page.dart';
import 'package:login_uix_firebase/route.dart';
import 'package:login_uix_firebase/pages/profile_riverpod_page.dart';

import '../../flutter_flow/flutter_flow_theme.dart';
import '../../model/practioner_data.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../flutter_flow/flutter_flow_widgets.dart';
import '../../model/practioner_data.dart';

class mainPageDesktop extends StatefulWidget {
  static const routeName = '/mainPageDesktop';
  const mainPageDesktop({Key? key}) : super(key: key);

  @override
  _mainPageDesktopState createState() => _mainPageDesktopState();
}

class _mainPageDesktopState extends State<mainPageDesktop> {
  TextEditingController? textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  DataService service = DataService();
  Future<List<PractionerData>>? PractionerList;
  Map<String, dynamic>? currentServicesData;
  List<PractionerData>? retrievedPractionerList;
  List<Map<String, dynamic>>? listofColumn;
  PractionerData? dataU;

  Future<List<AppointmentData>>? AppointmentList;
  List<AppointmentData>? retrievedAppointmentList;

  @override
  void initState() {
    super.initState();
    _initRetrieval();
    _initRetrieval2();
    textController = TextEditingController();
  }

  @override
  void dispose() {
    textController?.dispose();
    super.dispose();
  }

  Future<void> _initRetrieval() async {
    // listofColumn = (await service.retrieveClientType()).cast<Map<String, dynamic>>();
    PractionerList = service.retrievePractionerAll();
    retrievedPractionerList = await service.retrievePractionerAll();
  }

  Future<void> _initRetrieval2() async {
    AppointmentList = service.retrieveApppointment();
    retrievedAppointmentList = await service.retrieveApppointment();
  }

  @override
  Widget build(BuildContext context) {
    // final Stream<QuerySnapshot> _streamOngoing = FirebaseFirestore.instance
    //     .collection('appointment')
    //     // .where('statusAppointment', isEqualTo: 'ongoing')
    //     .snapshots(includeMetadataChanges: true);
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: double.infinity,
                  constraints: BoxConstraints(
                    maxHeight: double.infinity,
                  ),
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryColor,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(-0.95, 0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    100, 40, 0, 100),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  decoration: BoxDecoration(),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Align(
                                        alignment: AlignmentDirectional(-1, 0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20, 20, 20, 20),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushNamed(context,
                                                  mainPageDesktop.routeName);
                                            },
                                            child: Text(
                                              'Home',
                                              textAlign: TextAlign.justify,
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyText1,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            20, 20, 20, 20),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(context,
                                                RouteName.viewProfilePage);
                                          },
                                          child: Text(
                                            'Profile',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            20, 20, 20, 20),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(context,
                                                RouteName.HistoryBooking);
                                          },
                                          child: Text(
                                            'Booking History',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: TextFormField(
                                          controller: textController,
                                          autofocus: true,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            hintText: 'Search Something here..',
                                            hintStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyText2,
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            prefixIcon: Icon(
                                              Icons.search,
                                            ),
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0, 40, 100, 100),
                              child: Image.asset(
                                'lib/images/Logo-Slogan-BL-H400-W1080.png',
                                width: MediaQuery.of(context).size.width * 0.12,
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                        SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 40),
                                child: Text(
                                  'Begin your 1st Session!',
                                  style: FlutterFlowTheme.of(context)
                                      .title1
                                      .override(
                                        fontFamily: 'Poppins',
                                        fontSize: 40,
                                      ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20, 20, 20, 20),
                                child: Text(
                                  'We believe anyone can attain true happiness, whether adults, children, youth, male and female.',
                                  textAlign: TextAlign.justify,
                                  style: FlutterFlowTheme.of(context)
                                      .subtitle1
                                      .override(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20, 20, 20, 20),
                                child: Image.asset(
                                  'lib/images/Adjustment-Icon-7.png',
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20, 20, 20, 20),
                                child: Image.asset(
                                  'lib/images/7.png',
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20, 20, 20, 20),
                                child: Image.asset(
                                  'lib/images/9.png',
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20, 20, 20, 20),
                                child: Image.asset(
                                  'lib/images/10.png',
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        ),
                        FutureBuilder(
                            future: PractionerList,
                            builder: (context,
                                AsyncSnapshot<List<PractionerData>> snapshot) {
                              if (snapshot.hasData &&
                                  snapshot.data!.isNotEmpty) {
                                return Container(
                                  width: double.infinity,
                                  height:
                                      MediaQuery.of(context).size.height * 0.8,
                                  child: Stack(
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 12,
                                              color: Color(0x33000000),
                                              offset: Offset(0, 2),
                                            )
                                          ],
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(0),
                                            bottomRight: Radius.circular(0),
                                            topLeft: Radius.circular(60),
                                            topRight: Radius.circular(60),
                                          ),
                                          shape: BoxShape.rectangle,
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  60, 60, 60, 60),
                                          child: GridView.builder(
                                            padding: EdgeInsets.zero,
                                            itemCount:
                                                retrievedPractionerList!.length,
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                              crossAxisSpacing: 10,
                                              mainAxisSpacing: 8,
                                              childAspectRatio: 1,
                                            ),
                                            itemBuilder: (context, index) {
                                              return tableDepanPractioner(
                                                  context,
                                                  retrievedPractionerList![
                                                      index],
                                                  retrievedPractionerList,
                                                  index);
                                            },

                                            primary: true,
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,

                                            // Padding(
                                            //   padding: EdgeInsetsDirectional
                                            //       .fromSTEB(20, 20, 20, 20),
                                            //   child: Container(
                                            //     decoration: BoxDecoration(
                                            //       color: FlutterFlowTheme.of(
                                            //               context)
                                            //           .lineColor,
                                            //       boxShadow: [
                                            //         BoxShadow(
                                            //           blurRadius: 12,
                                            //           color:
                                            //               Color(0x33000000),
                                            //           offset: Offset(0, 2),
                                            //         )
                                            //       ],
                                            //       borderRadius:
                                            //           BorderRadius.circular(
                                            //               20),
                                            //       shape: BoxShape.rectangle,
                                            //     ),
                                            //     child: Column(
                                            //       mainAxisSize:
                                            //           MainAxisSize.max,
                                            //       children: [
                                            //         Padding(
                                            //           padding:
                                            //               EdgeInsetsDirectional
                                            //                   .fromSTEB(20,
                                            //                       20, 20, 20),
                                            //           child: Text(
                                            //             'Test',
                                            //             style: FlutterFlowTheme
                                            //                     .of(context)
                                            //                 .title1,
                                            //           ),
                                            //         ),
                                            //         Padding(
                                            //           padding:
                                            //               EdgeInsetsDirectional
                                            //                   .fromSTEB(20, 0,
                                            //                       20, 0),
                                            //           child: ClipRRect(
                                            //             borderRadius:
                                            //                 BorderRadius
                                            //                     .circular(20),
                                            //             child: Image.asset(
                                            //               'lib/images/doctor.png',
                                            //               width: MediaQuery.of(
                                            //                           context)
                                            //                       .size
                                            //                       .width *
                                            //                   0.2,
                                            //               height: MediaQuery.of(
                                            //                           context)
                                            //                       .size
                                            //                       .height *
                                            //                   0.2,
                                            //               fit: BoxFit.cover,
                                            //             ),
                                            //           ),
                                            //         ),
                                            //         Padding(
                                            //           padding:
                                            //               EdgeInsetsDirectional
                                            //                   .fromSTEB(0, 10,
                                            //                       0, 0),
                                            //           child: Text(
                                            //             '\"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\"',
                                            //             textAlign:
                                            //                 TextAlign.center,
                                            //             style: FlutterFlowTheme
                                            //                     .of(context)
                                            //                 .bodyText1
                                            //                 .override(
                                            //                   fontFamily:
                                            //                       'Poppins',
                                            //                   fontStyle:
                                            //                       FontStyle
                                            //                           .italic,
                                            //                 ),
                                            //           ),
                                            //         ),
                                            //       ],
                                            //     ),
                                            //   ),
                                            // ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: AlignmentDirectional(-1, -1),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20, 20, 20, 20),
                                          child: Text(
                                            'Practioner',
                                            textAlign: TextAlign.justify,
                                            style: FlutterFlowTheme.of(context)
                                                .title1,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              } else if (snapshot.connectionState ==
                                      ConnectionState.done &&
                                  retrievedPractionerList!.isEmpty) {
                                return Center(
                                  child: ListView(
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    children: const <Widget>[
                                      Align(
                                        alignment: AlignmentDirectional.center,
                                        child: Text('No Data Availble'),
                                      )
                                    ],
                                  ),
                                );
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            }),
                      ],
                    ),
                  ),
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('appointment')
                      .where('clientId',
                          isEqualTo: FirebaseAuth.instance.currentUser?.uid)
                      .where('statusAppointment', isEqualTo: 'ongoing')
                      .snapshots(includeMetadataChanges: true),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                      print("ada appointment");
                      return Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.7,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          26, 20, 20, 20),
                                      child: Text(
                                        'On going appointment',
                                        style:
                                            FlutterFlowTheme.of(context).title1,
                                      ),
                                    ),
                                  ],
                                ),
                                FutureBuilder(
                                    future: AppointmentList,
                                    builder: (context,
                                        AsyncSnapshot<List<AppointmentData>>
                                            snapshot) {
                                      if (snapshot.hasData &&
                                          snapshot.data!.isNotEmpty) {
                                        return Expanded(
                                          child: GridView.builder(
                                            padding: EdgeInsets.zero,
                                            itemCount: retrievedAppointmentList!
                                                .length,
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 4,
                                              crossAxisSpacing: 10,
                                              mainAxisSpacing: 10,
                                              childAspectRatio: 1,
                                            ),
                                            itemBuilder: (context, index) {
                                              return tableDepanAppointment(
                                                  context,
                                                  retrievedAppointmentList![
                                                      index],
                                                  retrievedAppointmentList,
                                                  index);
                                            },
                                            primary: false,
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                          ),
                                        );
                                      } else if (snapshot.connectionState ==
                                              ConnectionState.done &&
                                          retrievedPractionerList!.isEmpty) {
                                        return Center(
                                          child: ListView(
                                            physics:
                                                const AlwaysScrollableScrollPhysics(),
                                            children: const <Widget>[
                                              Align(
                                                alignment:
                                                    AlignmentDirectional.center,
                                                child: Text('No Data Availble'),
                                              )
                                            ],
                                          ),
                                        );
                                      } else {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    }),
                              ],
                            ),
                          ),
                        ],
                      );
                    } else {
                      print("gaada appointment");
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.7,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(-0.95, 0),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 60, 0, 0),
                                child: Text(
                                  'On going appointment',
                                  style: FlutterFlowTheme.of(context).title1,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  20, 20, 20, 20),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                height:
                                    MediaQuery.of(context).size.height * 0.4,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          20, 30, 20, 0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.asset(
                                          'lib/images/noappointment.png',
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.3,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.3,
                                          fit: BoxFit.scaleDown,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 20, 0, 0),
                                      child: Text(
                                        'No Appointment',
                                        style:
                                            FlutterFlowTheme.of(context).title1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
                Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.5,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'footer here',
                            style: FlutterFlowTheme.of(context).title1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget tableDepanPractioner(BuildContext context, PractionerData snapshot,
      List<PractionerData>? user, int indexs) {
    // print(snapshot.firstName);
    // print(indexs);
    // print(user);
    // print(_isChecked);
    // int idx = int.parse(dropDownItemValue2[indexs]);
    // return Text(snapshot.firstName as String);
    final _myBox = Hive.box('myBox');
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
      child: InkWell(
        onTap: () {
          _myBox.put(
              'name',
              snapshot.firstName.toString() +
                  " " +
                  snapshot.lastName.toString());
          // _myBox.put('id', snapshot.id);
          print(_myBox.get('name'));
          // print(_myBox.get('id'));
          Navigator.pushNamed(context, DetailPagePractioner.routeName,
              arguments: snapshot);
        },
        child: Container(
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).lineColor,
            boxShadow: [
              BoxShadow(
                blurRadius: 12,
                color: Color(0x33000000),
                offset: Offset(0, 2),
              )
            ],
            borderRadius: BorderRadius.circular(20),
            shape: BoxShape.rectangle,
          ),
          child: SingleChildScrollView(
            child: Column(
              // mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                  child: Text(
                    snapshot.firstName.toString() +
                        ' ' +
                        snapshot.lastName.toString(),
                    style: FlutterFlowTheme.of(context).title1,
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'lib/images/doctor.png',
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.height * 0.2,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: Text(
                    "Speciality: " + snapshot.mySpecialty.toString(),
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Poppins',
                          fontStyle: FontStyle.italic,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget tableDepanAppointment(BuildContext context, AppointmentData snapshot,
      List<AppointmentData>? user, int indexs) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.2,
        height: MediaQuery.of(context).size.height * 0.2,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).lineColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              snapshot.practionerName.toString(),
              style: FlutterFlowTheme.of(context).title1.override(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                  ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'lib/images/doctor.png',
                width: MediaQuery.of(context).size.width * 0.2,
                height: MediaQuery.of(context).size.height * 0.2,
                fit: BoxFit.scaleDown,
              ),
            ),
            Text(
              snapshot.services.toString(),
              style: FlutterFlowTheme.of(context).bodyText1,
            ),
            Text(
              "Booking Date: " + snapshot.dateandtime.toString(),
              style: FlutterFlowTheme.of(context).bodyText1,
            ),
          ],
        ),
      ),
    );
  }

  ///test
}
