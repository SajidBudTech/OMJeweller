class Api {

  // static const baseUrl = "https://food.thesnaptask.com/api";
  // static const baseUrl = "https://testbud.in/ayurvedaadmin/public/api";

   //static const LIVE URL  = "https://thelifeshaper.com/api";
     static const baseUrl = "https://testbud.in/ayurvedaadmin/public/api";
 // static const baseUrl = "https://173db198c876.ngrok.io/ayurveda_new/public/api";

  static const login = "/login";
  static const loginSocial = "/login/social";
  static const register = "/register";
  static const otp = "/otp";
  static const logout = "/logout";
  static const forgotPassword = "/password/reset/init";

  static const changePassword = "/password/change";
  static const updateProfile = "/user/update";

  static const banners = "/banners";
  static const categories = "/categories";
  static const vendors = "/v2/vendors";
  static const deliveryAddress = "/delivery/addresses";

  static const faq = "/faq";

  static const defaultDeliveryAddress = "/default/delivery/address";

  static const paymentOptions = "/payment/options";

  static const initiateCheckout = "/checkout/initiate";
  static const finalizecheckout = "/checkout/finalize";

  static const orders = "/orders";
  static const orderUpdate = '/order/status/update';

  static const coupons = "/coupons";

  static const notification = "/notifications";


  // Updates .....

  static const phoneValidation = "/phone/verify";
  static const otpLogin = "/phone/login";


  static const fcmServer = 'https://fcm.googleapis.com/fcm/send';

  static const wallet = "/wallet";


  // Docotors Apis........

     static const doctors = "/doctors";
     static const doctorsBanner = "/doctor-banners";

     static const doctorsCategories = "/doctor-categories";
     static const doctorSpecialities = "/doctor-specialities";



}
