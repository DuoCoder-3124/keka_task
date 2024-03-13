part of 'server.dart';

///Clock In & Out Actions are done using this endpoint.
Future<Response> _clockAction(Request request) async {
  String body = await request.readAsString();
  Map<String, dynamic> data = jsonDecode(body);
  Map<String, dynamic> rawBody = {
    "userId": data["userId"],
    "date": data["date"],
    "effective": data["effective"],
    "gross": data["gross"],
    "arrival": data["arrival"],
  };

  List nullFields = [];

  rawBody.forEach((key, value) {
    if (value == null) nullFields.add(key);
  });

  DbCollection? collection = db?.collection("actions");
  Map<String, dynamic>? userData = await collection?.findOne(
    where.eq('userId', rawBody['userId']).and(
          where.eq('date', rawBody['date']),
        ),
  );

  List inList = [];
  List outList = [];

  rawBody.addAll({'_id': _docId});
  if (userData == null) {
    if (data['in'] != null) inList.add(data['in']);
    if (data['out'] != null) outList.add(data['out']);

    rawBody.addAll({'in': inList, 'out': outList});

    collection?.insertOne(rawBody);
    return Response.ok(
      jsonEncode({"message": "Success created."}),
    );
  }
  inList = userData['in'];
  outList = userData['out'];

  if (data['in'] != null) inList.add(data['in']);
  if (data['out'] != null) outList.add(data['out']);

  rawBody.addAll({'in': inList, 'out': outList});

  collection?.updateOne(
    await collection.findOne(
      where.eq('userId', rawBody['userId']).and(
            where.eq('date', rawBody['date']),
          ),
    ),
    {
      '\$set': {
        'in': inList,
        'out': outList,
        'effective': rawBody['effective'],
        'gross': rawBody['gross'],
      }
    },
  );
  return Response.ok(
    jsonEncode({"message": "Success updated."}),
  );
}

///Gets user data on the basis of userId.
Future<Response> _getClockAction(Request request) async {
  Map<String, dynamic> params = request.url.queryParameters;

  DbCollection? collection = db?.collection("actions");
  if (params.isNotEmpty) {
    String userId = params['userId'];

    List<Map<String, dynamic>>? userData = await collection
        ?.find(
          where.eq('userId', userId),
        )
        .toList();
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
  var docs = await collection?.find().toList();
  return Response.ok(jsonEncode(
    {
      "message": "Found data",
      "userData": docs,
    },
  ),);
}
