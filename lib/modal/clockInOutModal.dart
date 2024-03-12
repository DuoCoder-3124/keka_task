class ClockInOutModal{

  final String clockInOutId;
  final String userId;
  final String date;
  final String effectiveHours;
  final String grossHours;
  final String arrival;
  final List<dynamic> clockIn;
  final List<dynamic> clockOut;

  ClockInOutModal({
    this.clockInOutId = "",
    this.userId = "",
    this.date = "",
    this.effectiveHours = "",
    this.grossHours = "",
    this.arrival = "",
    this.clockIn = const[],
    this.clockOut = const[]
  });


  factory ClockInOutModal.fromJson(Map<String, dynamic> json) => ClockInOutModal(
      clockInOutId: json['_id'],
      userId: json['userId'],
      date: json['date'],
      effectiveHours: json['effectiveHours'],
      grossHours: json['grossHours'],
      arrival: json['arrival'],
      clockIn: json['clockIn'],
      clockOut: json['clockOut']
  );

  Map<String, dynamic> toJson() => {
    '_id':clockInOutId,
    'userId':userId,
    'date':date,
    'effectiveHours':effectiveHours,
    'grossHours':grossHours,
    'arrival':arrival,
    'clockIn':clockIn,
    'clockOut':clockOut
  };

}
