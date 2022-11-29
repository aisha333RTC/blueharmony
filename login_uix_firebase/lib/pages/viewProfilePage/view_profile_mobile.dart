// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables
import 'dart:html' as html;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cross_file/cross_file.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_uix_firebase/flutter_flow/flutter_flow_theme.dart';
import 'package:login_uix_firebase/flutter_flow/flutter_flow_util.dart';
import 'package:login_uix_firebase/flutter_flow/flutter_flow_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_uix_firebase/route.dart';

import '../../helper/database_service.dart';
import '../../model/user_data.dart';

class ProfilePageMobileWidget extends StatefulWidget {
  const ProfilePageMobileWidget({Key? key}) : super(key: key);

  @override
  _ProfilePageMobileWidgetState createState() =>
      _ProfilePageMobileWidgetState();
}

class _ProfilePageMobileWidgetState extends State<ProfilePageMobileWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  DataService service = DataService();

  final nameController = TextEditingController();
  final lastsNameController = TextEditingController();
  final emailController = TextEditingController();
  // final ageController = TextEditingController();
  final dateofbirthController = TextEditingController();
  final phonenumberController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser!;
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;
  Future<Map<String, dynamic>>? currentUserData;
  Map<String, dynamic>? retrievedUserData;

  var uid;
  var fName,
      lName,
      age,
      uEmail,
      img,
      role,
      dob,
      phNumb,
      clientCode,
      clientTypes;
  bool imgExist = false;

  String? url;

  html.File? fImage;

  XFile? imgXFile;

  Uint8List webImage = Uint8List(10);

  Future<void> getDataFromDb() async {
    if (auth.currentUser != null) {
      uid = auth.currentUser?.uid;

      // var a = await db.collection("users").doc(uid).get();
      // return a.data();
      // then((DocumentSnapshot doc) {
      // final data = doc.data() as Map<String, dynamic>;
      // String fName = data['first name'];
      // print(uid + 'UID');
      // return data;
      // showDialog(
      //   context: context,
      //   builder: (context) {
      //     return AlertDialog(
      //       content: Text('halo: $fName'),
      //     );
      //   },
      // );
      await db.collection("users").doc(uid).get().then((DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        fName = data["firstName"];
        lName = data["lastName"];
        age = data["age"];
        img = data["imageUrl"];
        role = data["roles"];
        dob = data["dateofbirth"];
        phNumb = data["phoneNumber"];
        clientCode = data["clientcode"];
        clientTypes = data["clientType"];
      });
      setState(() {
        // if (img != null) {}
        emailController.text = user.email.toString();
        nameController.text = fName;
        lastsNameController.text = lName;
        dateofbirthController.text = dob;
        phonenumberController.text = phNumb;
        // ageController.text = age.toString();
      });
    }
    ;
  }

  @override
  void initState() {
    _initRetrieval();
    // getDataFromDb();
    super.initState();
  }

  Future<void> _initRetrieval() async {
    currentUserData = service.currentUsers(user.uid);
    retrievedUserData = await service.currentUsers(user.uid);
    // print(retrievedUserData!['id']);
    fName = retrievedUserData!["firstName"];
    lName = retrievedUserData!["lastName"];
    age = retrievedUserData!["age"];
    img = retrievedUserData!["imageUrl"];
    role = retrievedUserData!["roles"];
    dob = retrievedUserData!["dateofbirth"];
    phNumb = retrievedUserData!["phoneNumber"];
    clientCode = retrievedUserData!["clientcode"];
    clientTypes = retrievedUserData!["clientType"];

    emailController.text = user.email.toString();
    nameController.text = fName;
    lastsNameController.text = lName;
    dateofbirthController.text = dob;
    phonenumberController.text = phNumb;
  }

  Future editUserDetails(String uid, String firstName, String lastName,
      String email, String dateofbirth, String phNumb) async {
    if (imgExist) {
      final ref = storage.ref().child('usersImage').child('$uid.jpg');
      // html.File file = ios.File(imgXFile.path);

      await ref.putData(webImage);

      url = await ref.getDownloadURL();

      await auth.currentUser?.updateEmail(email);
      UserData userData = UserData(
        firstName: firstName,
        lastName: lastName,
        emailUser: email,
        doBirth: dateofbirth,
        phoneNumber: phNumb,
        // imgUrl: url
      );

      await service.updateUser(userData).onError(
            (error, stackTrace) => print("Error writing document: $error"),
          );
    } else {
      UserData userData = UserData(
        firstName: firstName,
        lastName: lastName,
        emailUser: email,
        doBirth: dateofbirth,
        phoneNumber: phNumb,
        // imgUrl: ""
      );

      await auth.currentUser?.updateEmail(email).then((value) async {
        await service.updateUser(userData).onError(
            (error, stackTrace) => print("Error writing document: $error"));
      });
    }
  }

  Future editUserData() async {
    auth.authStateChanges().listen((User? user) {
      if (user == null) {
        SnackBar(
          content: const Text('There is no User Login'),
        );
      } else {
        uid = auth.currentUser?.uid;
        editUserDetails(
          uid,
          nameController.text.trim(),
          lastsNameController.text.trim(),
          emailController.text.trim(),
          dateofbirthController.text.trim(),
          phonenumberController.text.trim(),
          // int.parse(ageController.text.trim()),
        );
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text("Your personal details has been updated"),
              );
            });
        print("aku");
      }
    });
  }

  Future<String?> pickImageCamera() async {
    final ImagePicker picker = ImagePicker();
    XFile? pickedImage = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
        maxHeight: 100,
        maxWidth: 100);

    var f = await pickedImage!.readAsBytes();

    setState(() {
      imgXFile = pickedImage;
      webImage = f;
      imgExist = true;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFF1F4F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'Profile',
          style: FlutterFlowTheme.of(context).title1.override(
                fontFamily: 'Urbanist',
                color: Color(0xFF101213),
                fontSize: 32,
                fontWeight: FontWeight.w600,
              ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 1,
                      color: Color(0xFFF1F4F8),
                      offset: Offset(0, 0),
                    )
                  ],
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24, 12, 24, 12),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Color(0xFFF1F4F8),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(2, 2, 2, 2),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: CachedNetworkImage(
                              imageUrl:
                                  'https://images.unsplash.com/photo-1592520113018-180c8bc831c9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTI3fHxwcm9maWxlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=900&q=60',
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      // Generated code for this Column Widget...
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                fName.toString(),
                                style: FlutterFlowTheme.of(context)
                                    .title3
                                    .override(
                                      fontFamily: 'Urbanist',
                                      color: Color(0xFF101213),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                                child: Text(
                                  user.email.toString(),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText2
                                      .override(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF897DEE),
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 4, 0, 0),
                                    child: Text(
                                      role.toString(),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText2
                                          .override(
                                            fontFamily: 'Outfit',
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 4, 0, 0),
                                    child: Text(
                                      clientTypes.toString(),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText2
                                          .override(
                                            fontFamily: 'Outfit',
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 4, 0, 0),
                                    child: Text(
                                      clientCode.toString(),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText2
                                          .override(
                                            fontFamily: 'Outfit',
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(24, 12, 0, 12),
                    child: Text(
                      'Account Settings',
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Urbanist',
                            color: Color(0xFF101213),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5,
                        color: Color(0x3416202A),
                        offset: Offset(0, 2),
                      )
                    ],
                    borderRadius: BorderRadius.circular(12),
                    shape: BoxShape.rectangle,
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                          child: Text(
                            'Change Password',
                            style:
                                FlutterFlowTheme.of(context).bodyText2.override(
                                      fontFamily: 'Outfit',
                                      color: Color(0xFF57636C),
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: AlignmentDirectional(0.9, 0),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Color(0xFF57636C),
                              size: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 12, 20, 0),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RouteName.editProfilePage);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 5,
                          color: Color(0x3416202A),
                          offset: Offset(0, 2),
                        )
                      ],
                      borderRadius: BorderRadius.circular(12),
                      shape: BoxShape.rectangle,
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                            child: Text(
                              'Edit Profile',
                              style: FlutterFlowTheme.of(context)
                                  .bodyText2
                                  .override(
                                    fontFamily: 'Urbanist',
                                    color: Color(0xFF57636C),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: AlignmentDirectional(0.9, 0),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: Color(0xFF57636C),
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FFButtonWidget(
                      onPressed: () async {
                        // GoRouter.of(context).prepareAuthEvent();
                        // await signOut();

                        // context.goNamedAuth('', mounted);
                      },
                      text: 'Log Out',
                      options: FFButtonOptions(
                        height: 40,
                        color: Colors.white,
                        textStyle:
                            FlutterFlowTheme.of(context).bodyText2.override(
                                  fontFamily: 'Lexend Deca',
                                  color: Color(0xFF101213),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                        elevation: 1,
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
