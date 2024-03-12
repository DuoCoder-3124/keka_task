part of 'server.dart';

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

  // if (nullFields.length <= 1) {
  //   return Response.forbidden(
  //     jsonEncode({"message": "At-least one of $nullFields should be filled."}),
  //   );
  // }
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
    // rawBody.updateAll(
    //   (key, value) {
    //     if(key == "in") value = inList;
    //     if(key == "out") value = outList;
    //   },
    // );
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
