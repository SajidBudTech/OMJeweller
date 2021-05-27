class Api {

  // static const baseUrl = "https://food.thesnaptask.com/api";
  // static const baseUrl = "https://testbud.in/ayurvedaadmin/public/api";

   //static const LIVE URL  = "https://thelifeshaper.com/api";
     static const baseUrl = "https://testbud.in/omjewellers/public/api";
 // static const baseUrl = "https://173db198c876.ngrok.io/ayurveda_new/public/api";

     static const downloadUrlPath = "https://testbud.in/omjewellers/public/contentupload/";
     static const ProductdownloadUrlPath = "https://testbud.in/omjewellers/public";

  static const login = "/customerlogin";
  static const loginOTP = "/login_otp";
  static const sendOTP = "/send_otp";
  static const register = "/customerregister";



  static const loginSocial = "/login/social";
  static const otp = "/otp";
  static const logout = "/logout";
  static const forgotPassword = "/password/reset/init";

  static const changePassword = "/password/change";
  static const updateProfile = "/update_user";

  static const scrollingbanners = "/get_scrolling_banner";
  static const advertismentbanners = "/get_adevertisment_banner";
  static const categories = "/get_category";
  static const collections = "/get_collection";
  static const goldRate = "/get_purity";
  static const getProductByCategory = "/get_product_by_category";
  static const getProductBySubCategory = "/get_product_by_subcategory";
  static const getProductByCollection = "/get_product_by_collection";
  static const getProductByID = "/product_detail";
  static const addtowishlist = "/add_to_wishlist";
  static const removeFromWishList = "/remove_from_wishlist";
  static const wishlistProduct = "/wishlist_product";
  static const addAppointmentBook = "/appointment_add";
  static const editAppointmentBook = "/appointment_edit";
  static const myAppointmentBooking = "/appointment_list";
  static const submitFeedBack = "/add_feedback";
  static const checkAvailability = "/check_availablity";


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
