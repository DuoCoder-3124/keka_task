part of '../server.dart';

///Gets user data on the basis of userId.
Future<Response> _getEmployeeById(Request request) async {
  Map<String, dynamic> params = request.url.queryParameters;

  if (params.isNotEmpty) {
    String userId = params['userId'];

    DbCollection? collection = db?.collection("user");
    Map<String, dynamic>? userData = await collection?.findOne(
      where.eq('_id', userId),
    );
    if (userData!.isNotEmpty) {
      return Response.ok(
        jsonEncode(
          {
            "message": "Found user",
            "userData": userData,
          },
        ),
      );
    }
    return Response.notFound(
      jsonEncode(
        {
          "message": "User cannot be found",
        },
      ),
    );
  }
  return Response.badRequest(body: "Parameter userId should not be empty.");
}

///Gets all user data.
Future<Response> _getEmployee(Request request) async {
  DbCollection? collection = db?.collection("user");
  var docs = await collection?.find().toList();
  return Response.ok(
    jsonEncode(docs),
  );
}

///Put API to update Employee.
Future<Response> _updateEmployee(Request request) async {
  String body = await request.readAsString();
  Map<String, dynamic> data = jsonDecode(body);

  Map<String, dynamic> rawBody = {
    '_id': data['_id'],
    'firstName': data['firstName'],
    'secondName': data['secondName'],
    'middleName': data['middleName'],
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
        '_id',
        rawBody["_id"],
      ),
    );
    if (userData != null) {
      collection?.insertOne(rawBody);
      await collection?.updateOne(
        await collection.findOne(
          where.eq('_id', rawBody['_id']),
        ),
        {
          '\$set': {
            'firstName': rawBody['firstName'],
            'secondName': rawBody['secondName'],
            'middleName': rawBody['middleName'],
            'DOB': rawBody['DOB'],
            'gender': rawBody['gender'],
            'department': rawBody['department'],
            'reportedBy': rawBody['reportedBy'],
            'jobTitle': rawBody['jobTitle'],
            'phoneNumber': rawBody['phoneNumber'],
          }
        },
      );
      return Response.ok(
        jsonEncode(
          {"message": "Employee updated Successfully."},
        ),
      );
    }
    return Response.forbidden(
      jsonEncode(
        {"message": "User Not Found"},
      ),
    );
  }
  return Response.forbidden(
    jsonEncode({"null fields": nullFields}),
  );
}
