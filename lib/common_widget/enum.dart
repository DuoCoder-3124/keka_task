enum BottomNavigationOption { home, leave, inbox, profile }

enum ApprovalStatus {
  Approved(0),
  Rejected(1),
  Pending(2);

  final int value;

  const ApprovalStatus(this.value);
}

enum ArrivalStatus {
  // OnTime(0),
  // Late(1);
  // final int value;
  // const ArrivalStatus(this.value);
  OnTime,
  Late
}
