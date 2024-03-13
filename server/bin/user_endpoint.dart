part of 'server.dart';

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


Future<Response> _getEmployee(Request request) async {
  DbCollection? collection = db?.collection("user");
  var docs = await collection?.find().toList();
  return Response.ok(
    jsonEncode(docs),
  );
}
