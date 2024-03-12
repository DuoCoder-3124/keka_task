part of 'server.dart';

///Requests leave for user.
Future<Response> _requestLeave(Request request) async {
  String body = await request.readAsString();
  Map<String, dynamic> data = jsonDecode(body);
  Map<String, dynamic> rawBody = {
    "userId": data["userId"],
    "from": data["from"],
    "to": data["to"],
    "leaveType": data["leaveType"],
    "note": data["note"],
    "notify": data["notify"],
    "isApproved": 0,
  };

  List nullFields = [];

  rawBody.forEach((key, value) {
    if (value == null) nullFields.add(key);
  });
  if (nullFields.isEmpty) {
    rawBody.addAll({'_id': _docId});
    DbCollection? collection = db?.collection("leave");
    collection?.insertOne(rawBody);
    return Response.ok(
      jsonEncode(
        {"message": "Leave Requested"},
      ),
    );
  }
  return Response.forbidden(
    jsonEncode({"null fields": nullFields}),
  );
}

///Gets leave for user.
Future<Response> _getLeavesByUserId(Request request) async {
  Map<String, dynamic> params = request.url.queryParameters;

  if (params.isNotEmpty) {
    String userId = params['userId'];

    DbCollection? collection = db?.collection("leave");
    var leaveData = await collection
        ?.find(
          where.eq('userId', userId),
        )
        .toList();
    if (leaveData!.isNotEmpty) {
      return Response.ok(
        jsonEncode(
          {
            "message": "Found user",
            "leaveData": leaveData,
          },
        ),
      );
    }
    return Response.notFound(
      jsonEncode(
        {
          "message": "User leave cannot be found",
        },
      ),
    );
  }
  return Response.badRequest(body: "Parameter userId should not be empty.");
}

///Gets leave for user.
Future<Response> _getLeavesByNotifyId(Request request) async {
  Map<String, dynamic> params = request.url.queryParameters;

  if (params.isNotEmpty) {
    String userId = params['userId'];

    DbCollection? collection = db?.collection("leave");
    var leaveData = await collection
        ?.find(
          where.eq('notify', userId),
        )
        .toList();
    if (leaveData!.isNotEmpty) {
      return Response.ok(
        jsonEncode(
          {
            "message": "Found user",
            "leaveData": leaveData,
          },
        ),
      );
    }
    return Response.notFound(
      jsonEncode(
        {
          "message": "User leave cannot be found",
        },
      ),
    );
  }
  return Response.badRequest(body: "Parameter userId should not be empty.");
}

///Approves leave for user.
Future<Response> _approveLeave(Request request) async {
  Map<String, dynamic> params = request.url.queryParameters;

  if (params.isNotEmpty) {
    String leaveId = params['leaveId'];
    String approverId = params['approverId'];

    DbCollection? collection = db?.collection("leave");
    var leaveData = await collection
        ?.find(
          where.eq('_id', leaveId).and(
                where.eq('notify', approverId),
              ),
        )
        .toList();
    if (leaveData!.isNotEmpty) {
      return Response.ok(
        jsonEncode(
          {
            "message": "Leave Approved",
          },
        ),
      );
    }
    return Response.notFound(
      jsonEncode(
        {
          "message": "Leave cannot be found",
        },
      ),
    );
  }
  return Response.badRequest(body: "Parameter userId should not be empty.");
}
