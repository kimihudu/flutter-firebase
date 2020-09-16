enum Setting {
  gameName,
  gameNo,
  gameNoLabel,
  gameType,
  gameCol,
  layoutType,
  patternTicket,
  pairNo,
  img
}
enum Routes {
  launchView,
  selectGameView,
  SelectTicketNo,
  viewGameView,
  checkOutView,
  ViewHistoryGame
}

enum GameLabel {
  LuckyMAX,
  LuckySIX,
  LuckyGRAND,
  LuckyDICE,
  LuckyPICK4,
  Lucky123
}
enum OrderStatus { CANCELLED, COMPLETED, PENDING }

enum TabHistory { Tickets, Topup }
enum DotType { square, circle, diamond, icon }
enum AniProps { opacity, translateX }
enum DateFm { MDE }

typedef OnChangeCallBack = Function(dynamic value);
typedef SelecteChangeCallBack = Function(dynamic selected);
typedef OnPressedCallBack = Function(dynamic number);
typedef void OnPickImageCallback(
    double maxWidth, double maxHeight, int quality);
