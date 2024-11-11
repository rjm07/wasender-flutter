class API {
  static String socomKey = const String.fromEnvironment("socomKey");
  static String socomSec = const String.fromEnvironment("socomSec");
  static String hashKey = const String.fromEnvironment("hashKey");

  static String baseUrl = const String.fromEnvironment("baseUrl");
  static String loginUrl = "/api/v1/oauth";

  //DASHBOARD APIS
  static String dashboardUrl = "/v2";

  //PIPELINE APIS
  static String pipelineUrl = "/v2/customer-pipeline";

  //CUSTOMER
  static String customerUrl = "/v2/customer";

  //SALES FUNNEL
  static String salesFunnelUrl = "/v2/sales-funnel";
}
