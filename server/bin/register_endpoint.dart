part of 'server.dart';

Future<Response> _register(Request request) async {
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
    Map<String, dynamic>? userData = await collection?.findOne(
      where.eq(
        'email',
        rawBody["email"],
      ),
    );
    if (userData == null) {
      rawBody.addAll({'_id': _docId});
      rawBody.update(
        'password',
        (value) => _encryptPassword(
          rawBody['password'],
        ),
      );
      collection?.insertOne(rawBody);
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
  return Response.badRequest(body: "Body should not be empty.");
}
