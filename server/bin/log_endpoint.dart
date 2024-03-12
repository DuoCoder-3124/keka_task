part of 'server.dart';

///Login API endpoint.
Future<Response> _loginEmployee(Request request) async {
  String body = await request.readAsString();
  Map<String, dynamic> data = jsonDecode(body);
  Map<String, dynamic> rawBody = {
    "email": data["email"],
    "password": data["password"],
    'fcmToken': data['fcmToken'],
  };
  List nullFields = [];
  rawBody.forEach((key, value) {
    if (value == null) nullFields.add(key);
  });

  if (nullFields.isEmpty) {
    DbCollection? collection = db?.collection("user");
    Map<String, dynamic>? userData = await collection?.findOne(
      where.eq(
        'email',
        rawBody["email"],
      ),
    );
    if (userData != null) {
      rawBody.update('password', (value) => _encryptPassword(rawBody['password']));
      if (userData['password'] == rawBody['password']) {
        await collection?.updateOne(await collection.findOne(where.eq('email', rawBody['email'])), {
          '\$set': {
            'fcmToken': rawBody['fcmToken'],
          }
        });
        return Response.ok(
          jsonEncode(
            {
              "message": "Success",
              "userId": userData['_id'],
            },
          ),
        );
      }
      return Response.notFound(
        jsonEncode(
          {"message": "Wrong Password"},
        ),
      );
    }
    return Response.notFound(
      jsonEncode(
        {"message": "Not found"},
      ),
    );
  }
  return Response.forbidden(
    jsonEncode({"null fields": nullFields}),
  );
}

///Logout API endpoint.
Future<Response> _logoutEmployee(Request request) async {
  String body = await request.readAsString();
  Map<String, dynamic> data = jsonDecode(body);
  Map<String, dynamic> rawBody = {
    "email": data["email"],
    // 'fcmToken': data['fcmToken'],
  };
  List nullFields = [];
  rawBody.forEach((key, value) {
    if (value == null) nullFields.add(key);
  });

  if (nullFields.isEmpty) {
    DbCollection? collection = db?.collection("user");
    Map<String, dynamic>? userData = await collection?.findOne(
      where.eq(
        'email',
        rawBody["email"],
      ),
    );
    if (userData != null) {
      await collection?.updateOne(await collection.findOne(where.eq('email', rawBody['email'])), {
        '\$set': {
          'fcmToken': null,
        }
      });
      return Response.ok(
        jsonEncode(
          {"message": "Success"},
        ),
      );
    }
    return Response.notFound(
      jsonEncode(
        {"message": "Not found"},
      ),
    );
  }
  return Response.forbidden(
    jsonEncode({"null fields": nullFields}),
  );
}

Future<Response> _getEmployee(Request request) async {
  DbCollection? collection = db?.collection("user");
  var docs = await collection?.find().toList();
  return Response.ok(
    jsonEncode(docs),
  );
}
