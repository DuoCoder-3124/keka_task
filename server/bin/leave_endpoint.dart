part of 'server.dart';

///Requests leave for user.
Future<Response> _requestLeave(Request request) async {
  String body = await request.readAsString();
  Map<String, dynamic> data = jsonDecode(body);
  Map<String, dynamic> rawBody = {
    "userId": data["userId"],
    "from": data["from"],
    "to": data["to"],
    "approverId": data["approverId"],
    // "reason": null,
    "totalDays": data["totalDays"],
    "leaveType": data["leaveType"],
    "note": data["note"],
    "notify": data["notify"],
    "isApproved": data["isApproved"],
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
Future<Response> _getLeavesByEmployeeId(Request request) async {
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
  String body = await request.readAsString();
  Map<String, dynamic> data = jsonDecode(body);
  Map<String, dynamic> rawBody = {
    "approverId": data["approverId"],
    "reason": data['reason'],
    "isApproved": data["isApproved"],
  };

  List nullFields = [];

  rawBody.forEach((key, value) {
    if (value == null) nullFields.add(key);
  });

  if (nullFields.isEmpty) {
    String leaveId = rawBody['leaveId'];
    String approverId = rawBody['approverId'];

    DbCollection? collection = db?.collection("leave");
    Map<String, dynamic>? leaveData = await collection?.findOne(
      where.eq('_id', leaveId).and(
            where.eq('approverId', approverId),
          ),
    );
    if (leaveData != null) {
      await collection?.updateOne(
        await collection.findOne(
          where.eq('_id', leaveId).and(
                where.eq('approverId', approverId),
              ),
        ),
        {
          '\$set': {
            'isApproved': rawBody['isApproved'],
            'reason': rawBody['reason'],
          },
        },
      );
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
  return Response.forbidden(
    jsonEncode(
      {"nullFields": nullFields},
    ),
  );
}
