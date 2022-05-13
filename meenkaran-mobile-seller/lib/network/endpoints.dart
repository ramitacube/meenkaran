class EndPoints {
  static final String baseUrl = "https://meenkaran-api-test.videoshopping.in/";

  //get districts

  static final String getDistricts = "${baseUrl}districts";
  static final String getState = "${baseUrl}states";
  static final String getTaluk = "${baseUrl}taluks";
  static final String getlocation = "${baseUrl}locations";
  static final String register = "${baseUrl}auth/local/register";
  static final String registerSellerData = "${baseUrl}sellers-details";
  static final String login = "${baseUrl}auth/local";
  static final String getFish = "${baseUrl}items";
  static final String addDailyFish = "${baseUrl}daily-items";
  static final String addDailyRoute = "${baseUrl}daily-routes";
  static final String getCustomer = "${baseUrl}seller-customer-maps?";
  static final String getAllData = "${baseUrl}sellers-details/users";
  static final String createCall = "${baseUrl}seller-call-logs";
  static final String getCallLog = "${baseUrl}seller-call-logs?";
  static final String getReceivedCall = "${baseUrl}customer-call-logs?";
  static final String searchCustomer = "${baseUrl}customers?";
  static final String addCustomer = "${baseUrl}seller-customer-maps";
  static final String getSellerItem = "${baseUrl}daily-items?";
  static final String getSellerRoute = "${baseUrl}daily-routes?";
  static final String getDailyReport = "${baseUrl}users-report/";
  static final String updateLocation = "${baseUrl}seller-locations";
  static final String getReminder = "${baseUrl}reminders?";
  static final String getNotification = "${baseUrl}customer-notifications";

}
