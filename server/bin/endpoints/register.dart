part of '../server.dart';

///Register Api endpoint.
Future<Response> _registerEmployee(Request request) async {
  String body = await request.readAsString();
  Map<String, dynamic> data = jsonDecode(body);

  Map<String, dynamic> rawBody = {
    'firstName': data['firstName'],
    'secondName': data['secondName'],
    'middleName': data['middleName'],
    'email': data['email'],
    'password': data['password'],
    'DOB': data['DOB'],
    'gender': data['gender'],
    'department': data['department'],
    'reportedBy': data['reportedBy'],
    'jobTitle': data['jobTitle'],
    'phoneNumber': data['phoneNumber'],
  };

  List<String> nullFields = [];

  rawBody.forEach((key, value) {
    if (value == null) {
      nullFields.add(key);
    }
  });

  if (nullFields.isEmpty) {
    DbCollection? collection = db?.collection("user");
    Map<String, dynamic>? emp = await collection?.findOne(where.eq('_id', "65f031f6b2e8a037f1d9bf32"));
    int empNumber = emp?['empNumber'] as int;
    Map<String, dynamic>? userData = await collection?.findOne(
      where.eq(
        'email',
        rawBody["email"],
      ),
    );
    if (userData == null) {
      rawBody.addAll({
        '_id': _docId,
        'fcmToken': null,
        "employeeNumber": empNumber + 1,
      });
      rawBody.update(
        'password',
        (value) => _encryptPassword(
          rawBody['password'],
        ),
      );
      collection?.insertOne(rawBody);
      await collection?.updateOne(
        await collection.findOne(
          where.eq('_id', "65f031f6b2e8a037f1d9bf32"),
        ),
        {
          '\$set': {
            'empNumber': empNumber + 1,
          }
        },
      );
      return Response.ok(
        jsonEncode(
          {"message": "Employee inserted Successfully."},
        ),
      );
    }
    return Response.forbidden(
      jsonEncode(
        {"message": "Email already exists"},
      ),
    );
  }
  return Response.forbidden(
    jsonEncode({"null fields": nullFields}),
  );
}
