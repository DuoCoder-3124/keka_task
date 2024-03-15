class ClockInOutModal{

  final String? clockInOutId;
  final String? userId;
  final String? date;
  final String? effectiveHours;
  final String? grossHours;
  final int arrival;
  final int weekDay;
  final String? postClockIn;
  final String? postClockOut;
  final List<dynamic> getClockIn;
  final List<dynamic> getClockOut;

  ClockInOutModal({
    this.clockInOutId = "",
    this.userId = "",
    this.date = "",
    this.effectiveHours = "",
    this.grossHours = "",
    this.arrival = 0,
    this.weekDay = 0,
    this.postClockIn = "",
    this.postClockOut = "",
    this.getClockIn = const <dynamic>[],
    this.getClockOut = const <dynamic>[]
  });

  factory ClockInOutModal.fromJson(Map<String, dynamic> json) => ClockInOutModal(
      clockInOutId: json['_id'],
      userId: json['userId'],
      date: json['date'],
      effectiveHours: json['effective'],
      grossHours: json['gross'],
      arrival: json['arrival'],
      weekDay: json['week'],
      getClockIn: json['in'] ?? [],
      getClockOut: json['out'] ?? [],
  );

  Map<String, dynamic> toJson() => {
    '_id':clockInOutId,
    'userId':userId,
    'date':date,
    'effective':effectiveHours,
    'gross':grossHours,
    'arrival':arrival,
    'week':weekDay,
    'in':postClockIn,
    'out':postClockOut,

  };
}
