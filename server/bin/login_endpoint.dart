part of 'server.dart';

Future<Response> _login(Request request) async {
  String body = await request.readAsString();
  Map<String, dynamic> data = jsonDecode(body);
  Map<String, dynamic> rawBody = {
    "email": data["email"],
    "password": data["password"],
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
        return Response.ok(
          jsonEncode(
            {"message": "Success"},
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
