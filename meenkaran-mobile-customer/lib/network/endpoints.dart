class EndPoints {
  static final String baseUrl = "https://meenkaran-api-test.videoshopping.in/";

  //get districts

  static final String register = "${baseUrl}auth/local/register";
  static final String registerUser = "${baseUrl}customers";
  static final String login = "${baseUrl}auth/local";
  static final String customerDetails = "${baseUrl}customers?";
  static final String sellers = "${baseUrl}seller-customer-maps?";
  static final String getmembers = "${baseUrl}customers?";
  static final String searchSeller = "${baseUrl}users?";
  static final String addSeller = "${baseUrl}seller-customer-maps";
  static final String getReminders = "${baseUrl}reminders";
  static final String getDailyReport = "${baseUrl}users-report/";
  static final String getLocationData = "${baseUrl}seller-locations?";
  static final String addMember = "${baseUrl}customers";
  static final String getInitialReminders = "${baseUrl}reminders/preDefined";
  // static final String locationsList = "${baseUrl}locations";
  // static final String login = "${baseUrl}login";
  // static final String register = "${baseUrl}customer";
  // static final String saveVisit = "${baseUrl}save-visit";
  // static final String createCall = "${baseUrl}call-log";
  // static final String saveFcmToken = "${baseUrl}fcm-token";
  // static final String callLogs = "${baseUrl}user-calls";
  // static final String visitorList = "${baseUrl}list-visit-customer";
}
