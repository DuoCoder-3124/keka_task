class ApproveModel{
  String? leaveId;
  String? approverId;
  String? reason;
  int? isApproved;

  ApproveModel({
    this.leaveId,
    this.approverId,
    this.reason,
    this.isApproved,
  });

  Map<String, dynamic> toMap() {
    return {
      'leaveId': leaveId,
      'approverId': approverId,
      'reason': reason,
      'isApproved': isApproved,
    };
  }

  factory ApproveModel.fromMap(Map<String, dynamic> map) {
    return ApproveModel(
      leaveId: map['leaveId'] as String,
      approverId: map['approverId'] as String,
      reason: map['reason'] as String,
      isApproved: map['isApproved'] as int,
    );
  }
}