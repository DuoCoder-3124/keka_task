part of 'server.dart';

Future<Response> _forgotPassword(Request request) async {
  String body = await request.readAsString();
  Map<String, dynamic> data = jsonDecode(body);
  Map<String, dynamic> rawBody = {
    "email": data["email"],
  };
  List nullFields = [];
  rawBody.forEach((key, value) {
    if (value == null) nullFields.add(key);
  });

  if (nullFields.isEmpty) {
    DbCollection userCollection = db!.collection('user');
    DbCollection forgotPasswordCollection = db!.collection('forgot_password');

    var res = await userCollection.findOne(
      where.eq('email', rawBody['email']),
    );

    final token = _generateToken;
    final otp = _generateOtp();

    Map<String, dynamic> verify = {
      'otp': otp,
      'token': token,
    };
    if (res != null) {
      var document = {
        '_id': _docId,
        'userId': res['_id'],
        'token': token,
        'otp': otp,
      };
      forgotPasswordCollection.insertOne(document);
      return Response.ok(
        jsonEncode(verify),
      );
    }
    return Response.notFound(
      jsonEncode({"message": "Not Found"}),
    );
  }
  return Response.forbidden(
    jsonEncode(
      {"nullFields": nullFields},
    ),
  );
}

Future<Response> _verifyToken(Request request) async {
  String body = await request.readAsString();
  Map<String, dynamic> data = jsonDecode(body);
  Map<String, dynamic> rawBody = {
    "token": data["token"],
    "otp": data["otp"],
    "password": data["password"],
  };
  List nullFields = [];
  rawBody.forEach((key, value) {
    if (value == null) nullFields.add(key);
  });

  if (nullFields.isEmpty) {
    DbCollection userCollection = db!.collection('user');
    DbCollection forgotPasswordCollection = db!.collection('forgot_password');
    var verify = await forgotPasswordCollection.findOne(
      where.eq('token', rawBody['token']),
    );
    if (verify != null) {
      if (verify['otp'] == rawBody['otp']) {
        var document = await userCollection.findOne(
          where.eq('_id', verify['userId']),
        );
        if (document != null) {
          rawBody.update(
            'password',
            (value) => _encryptPassword(rawBody['password']),
          );
          await userCollection.updateOne(
            await userCollection.findOne(
              where.eq('_id', verify['userId']),
            ),
            {
              '\$set': {
                'password': rawBody['password'],
              }
            },
          );
          forgotPasswordCollection.deleteMany(
            where.eq('userId', verify['userId']),
          );
          return Response.ok(
            jsonEncode({"message": "Success"}),
          );
        }
        Response.notFound(
          jsonEncode({"message": "User Not Found"}),
        );
      }
      return Response.forbidden(
        jsonEncode(
          {"message": "Otp Mismatch"},
        ),
      );
    }
    Response.notFound(
      jsonEncode({"message": "Not Found"}),
    );
  }
  return Response.forbidden(
    jsonEncode(
      {"nullFields": nullFields},
    ),
  );
}
