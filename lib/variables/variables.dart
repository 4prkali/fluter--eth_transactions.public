
class Global {
  static String _actualPrice = '00000000000';
  static String _actualBalance = '00000000000';
  static String _actualBalanceUSD = '00000000000';
  static String _actualAccountID = '00000000000';
  static String _btc = '00000000000';
  static String _eth = '00000000000';
  static String _ltc = '00000000000';
  static String _ada = '00000000000';
  static String _sol = '00000000000';
  static String _amount = '00000000000';
  static String _AccountID = '00000000000';


  static String get AccountID => _AccountID;

  static set AccountID(String value) {
    _AccountID = value;
  }

  static String get amount => _amount;

  static set amount(String value) {
    _amount = value;
  }

  static String get btc => _btc;

  static set btc(String value) {
    _btc = "${value.toString()} USD";
  }

  static String getterPrice() {
    return _actualPrice;
  }
  static void setterPrice(String string) {
    _actualPrice = string;
  }

  static String getterBalance() {
    return _actualBalance.substring(0,7);
  }

  static void setterBalance(String string) {
    _actualBalance = string;
  }

  static String getterBalanceUSD() {
    return _actualBalanceUSD;
  }

  static void setterBalanceUSD() {
    var aux1 =  double.parse(_actualPrice);
    var aux2 =  double.parse(_actualBalance);
    var aux3 = aux1 * aux2;
    _actualBalanceUSD = aux3.toString();
  }

  static String getterAccountID() {
    return '${_actualAccountID.substring(0,7)}...${_actualAccountID.substring(_actualAccountID.length - 4, _actualAccountID.length)}';
  }
  static String getterFullAccountID() {
    return _actualAccountID;
  }
  static void setterAccountID(String string) {
    _actualAccountID = string;
  }

  static String get eth => _eth;

  static set eth(String value) {
    _eth = "${value.toString()} USD";
  }

  static String get ltc => _ltc;

  static set ltc(String value) {
    _ltc = "${value.toString()} USD";
  }

  static String get ada => _ada;

  static set ada(String value) {
    _ada = "${value.toString()} USD";
  }

  static String get sol => _sol;

  static set sol(String value) {
    _sol = "${value.toString()} USD";
  }
}
