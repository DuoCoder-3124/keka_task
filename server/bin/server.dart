import 'dart:convert';
import 'dart:io';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:crypto/crypto.dart' as crypto;

part 'register_endpoints.dart';

// Configure routes.
final _router = Router()
  ..get('/', (req) => Response.ok("Hello Keka!!!"))
  ..post('/registerEmployee', _register);

///Instance for database.
Db? db;

void main(List<String> args) async {
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
String get _docId => ObjectId().oid;


String _encryptPassword(String password) {
  final bytes = utf8.encode(password);
  final digest = crypto.sha256.convert(bytes);
  return digest.toString();
}