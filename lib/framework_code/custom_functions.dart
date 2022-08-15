String count(List<dynamic> itemJson) {
  // Add your function code here!
  double totalprice = 0.0;
  for (int i = 0; i < itemJson.length; i++) {
    totalprice = totalprice + itemJson[i]['eatInPrice'];
    totalprice.ceil();
  }
  return totalprice.toString();
}
