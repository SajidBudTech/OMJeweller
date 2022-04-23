class Api {


      //static const baseUrl  = "https://omjewellers.com/public/api";
      //LiVE
      static const baseUrl = "https://omjewellers.com/omjewellers/public/api";
      //TEST
     //static const baseUrl = "https://testbud.in/omjewellers/public/api";

     static const downloadUrlPath = "https://omjewellers.com/public/contentupload/";
     static const ProductdownloadUrlPath = "https://omjewellers.com/public";




  static const login = "/login_with_mobile_password";
  static const loginOTP = "/get_otp";
  static const loginDetail = "/customerloginwithmobile";
  static const registeSendOTP = "/sent_otp";
  static const checkMobile="/check_mobile_number";
  static const register = "/customerregister";



  static const loginSocial = "/login/social";
  static const otp = "/otp";
  static const logout = "/logout";
  static const forgotPassword = "/forgot_password";

  static const changePassword = "/confirm_password";
  static const updateProfile = "/update_user";

  static const scrollingbanners = "/get_scrolling_banner";
  static const advertismentbanners = "/get_adevertisment_banner";
  static const categories = "/get_category";
  static const newcategories = "/get_category_new";
  static const collections = "/get_collection";
  static const newArrival = "/new_arrival";
  static const omLive = "/get_videos";
  static const goldRate = "/get_purity";
  static const getProductByCategory = "/get_product_by_category";
  static const getProductBySubCategory = "/get_product_by_subcategory";
  static const getProductByCollection = "/get_product_by_collection";
  static const getProductByID = "/product_detail";
  static const getProductBySearch = "/search_product";
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
  static const notificationCount = "/unread-notification-count";
  static const wishlistCount = "/wishlist";


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
