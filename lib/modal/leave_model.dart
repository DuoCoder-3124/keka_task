class LeaveModel{
  String? leaveId;
  String? userId;
  String? approverId;
  String? from;
  String? to;
  String? leaveType;
  String? note;
  String? notify;
  int? isApproved;
  int? totalDays;

  LeaveModel({
    this.userId,
    this.leaveId,
    this.approverId,
    this.from,
    this.to,
    this.leaveType,
    this.note,
    this.notify,
    this.isApproved,
    this.totalDays,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id':leaveId,
      'userId': userId,
      'approverId':approverId,
      'from': from,
      'to': to,
      'leaveType': leaveType,
      'note': note,
      'notify': notify,
      'isApproved': isApproved,
      'totalDays':totalDays,
    };
  }

  factory LeaveModel.fromMap(Map<String, dynamic> map) {
    return LeaveModel(
      leaveId: map['_id'] as String,
      userId: map['userId'] as String,
      approverId: map['approverId'] as String,
      from: map['from'] as String,
      to: map['to'] as String,
      leaveType: map['leaveType'] as String,
      note: map['note'] as String,
      notify: map['notify'] as String,
      isApproved: map['isApproved'] as int,
      totalDays: map['totalDays'] as int,
    );
  }
}