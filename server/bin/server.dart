import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:dart_firebase_admin/messaging.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:dart_firebase_admin/dart_firebase_admin.dart' as firebase_admin;

part 'configurations.dart';

part 'endpoints/register.dart';

part 'endpoints/forgot.dart';

part 'endpoints/employee.dart';

part 'endpoints/log.dart';

part 'endpoints/leave.dart';

part 'endpoints/actions.dart';

part 'endpoints/firebase.dart';

// Configure routes.
final _router = Router()
  ..get(
    '/',
    (req) => Response.ok("Hello Keka!!!"),
  )
  ..get('/getEmployee', _getEmployee)
  ..get('/getEmployeeById', _getEmployeeById)
  ..get('/getClockAction', _getClockAction)
  ..get('/getLeavesByEmployeeId', _getLeavesByEmployeeId)
  ..get('/getLeavesByNotifyId', _getLeavesByNotifyId)
  ..get("/logoutEmployee", _logoutEmployee)
  ..post('/registerEmployee', _registerEmployee)
  ..post("/loginEmployee", _loginEmployee)
  ..post("/forgotPassword", _forgotPassword)
  ..post("/verifyToken", _verifyToken)
  ..post("/requestLeave", _requestLeave)
  ..post("/approveLeave", _approveLeave)
  ..post('/clockAction', _clockAction)
  // ..post('/sendNotification', _sendNotification)
  ..put('/updateEmployee', _updateEmployee);

///Instance for database.
Db? db;

///Instance for FirebaseAdmin.
firebase_admin.FirebaseAdminApp? admin;

void main(List<String> args) async {
  //Connection to Firebase.
  _initFirebase();

  //Connection to Database.
  db = await Db.create("mongodb+srv://ayushmang:PUPzdiw2Y9tLdMPH@keka.cikkk4s.mongodb.net/Keka");
  db?.open();

  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  // Configure a pipeline that logs requests.
  final handler = Pipeline().addMiddleware(logRequests()).addHandler(_router.call);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, 3000);
  print('Server listening on port ${server.port}');
}

///Gets id for every document that needs to be inserted in MongoDB.
String get _docId => ObjectId().$oid;

///Generates a Token for verification.
String get _generateToken => Uuid().v4();

///Generates OTP.
String _generateOtp() {
  final rnd = Random();
  final otp = "${rnd.nextInt(9)}${rnd.nextInt(9)}${rnd.nextInt(9)}${rnd.nextInt(9)}";
  return otp;
}

///For encrypting password.
String _encryptPassword(String password) {
  final bytes = utf8.encode(password);
  final digest = crypto.sha256.convert(bytes);
  return digest.toString();
}

///Initialize Firebase.
void _initFirebase() {
  try {
    final file = File("service-account-file.json");
    print("=================${file.path}");
    admin = firebase_admin.FirebaseAdminApp.initializeApp(
      'keka-task',
      firebase_admin.Credential.fromServiceAccount(
        File("service-account-file.json"),
      ),
    );
    print("Firebase Admin SDK initialized successfully.");
  } catch (e, stackTrace) {
    print("firebaseAdminError ---> $e");
    print("stackTrace ---> $stackTrace");
  }
}
