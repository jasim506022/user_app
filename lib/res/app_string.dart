class AppString {
  /*
   🏠 General App Strings
  */
  static String appName = "JasiMart";

// 📌 Button Labels
  static const String btnYes = "Yes";
  static const String btnNo = "No";
  static const String btnaddProductImage = "Add Product Image";
  static const String btnCancel = "Cancel";
  static const String btnPickImage = "Pick Image";
  static const String btnUpdate = "Update";
  static const String btnDelete = "Delete";
  static const String btnReset = "Reset";
  static const String btnClose = "Close";
  static const String btnSave = 'Save';
  static const String btnSkip = "Skip";
  static const String btnNext = "Next";
  static const String btnFacebook = "Facebook";
  static const String btnGmail = "Gmail";
  static const String btnOkay = "Okay";

  // 📌 Firebase Collections & Shared Preferences Keys
  static const String collectionUsers = "users";
  static const String collectionProducts = "products";
  static const String collectionOrders = "orders";
  static const String prefUserId = "userId";
  static const String prefUserEmail = "userEmail";
  static const String prefUserName = "userName";
  static const String prefUserPhone = "userPhone";
  static const String prefUserProfilePic = "userProfilePic";
  static const String prefUserEarnings = "userEarnings";
  static const String prefOnboarding = 'onBoarding';

  // 📌 Authentication Titles & Messages
  static const String userLoginTitle = "Welcome! Please Log In";
  static const String signInTitle = "Sign In";
  static const String signUpTitle = "Sign Up";
  static String resetPasswordTitle = "Reset Password";
  static const String authPageDescription =
      "Check our fresh veggies from Jasim Grocery";
  static const String forgetPasswordTitle = "Forgot Password?";
  static String withOr = "with Or";
  static String forgetPasswordDescription =
      "Please Enter your mail address to reset you password";
  static String registrationTitle = "JasiMart Registration";
  static const String createAccount = "Create Account";
  static const String alreadyHaveAccount = "Already have an account?";
  static const String dontHaveAccount = "Don't have an account?";
  static String youdontWantToReset = "If you don't want to reset Password? ";
  static const String passwordMatch = "Passwords do not match.";

  // 📌 Form Field Labels
  static const productNameLabel = 'Product Name';
  static const String priceLabel = 'Price';
  static const String discountLabel = 'Discount';
  static const String ratingLabel = 'Rating';
  static const String descriptionLabel = 'Description';
  static const String emailLabel = "Email";
  static const String passwordLabel = "Password";
  static const String nameLabel = "Name";
  static const String passwordConfirmLabel = "Confirm Password";
  static const String phoneLabel = "Phone";

  // 📌 Hint Texts (For Input Fields)
  static const String productNameHint = "Enter product name (e.g., Nike Shoes)";
  static const String productPriceHint = "Enter price (e.g., 99.99)";
  static const String productDiscountHint = "Enter discount (e.g., 10 for 10%)";
  static const String productRatingHint = "Enter rating (1 to 5)";
  static const String productDescriptionHint =
      "Write a short product description...";
  static const String emailHint = "Enter your email address";
  static const String passwordHint = "Enter your password";
  static const String confirmPasswordHint = "Re-enter your password";
  static const String nameHint = "Enter your full name";
  static const String addressHint = "Enter your address (Street, City, ZIP)";
  static const String phoneHint = "Phone Number";
  static const String searchHint = "Search...........";

  // 📌 Validation Messages
  // Product
  static const String emptyProductName = "Please enter a product name.";
  static const String productNameTooShort =
      "Product name must be at least 3 characters long.";
  static const String productNameTooLong =
      "Product name cannot exceed 100 characters.";
  static const String productNameInvalid =
      "Product name can only contain letters, numbers, and spaces.";
// Price
  static const String emptyPrice = "Please enter a product price.";
  static const String invalidPrice =
      "Invalid price! Please enter a valid numeric value.";
  static const String priceOutOfRange =
      "Price must be between 0.01 and 1,000,000.";
  static const String invalidPriceFormat =
      "Please enter a valid price with up to two decimal places.";
  // Ratting
  static const String emptyRating = "Please enter a rating before submitting.";
  static const String invalidRating =
      "Invalid rating! Please enter a numeric value between 1 and 5.";
  static const String ratingOutOfRange = "Rating must be between 1 and 5.";
  // Discount
  static const String emptyDiscount = "Please enter a discount value.";
  static const String invalidDiscount =
      "Invalid discount! Please enter a valid numeric value.";
  static const String discountNegative = "Discount cannot be negative.";
  static const String discountTooHigh =
      "Discount cannot be greater than the product price.";
  static const String discountOverLimit = "Discount cannot exceed 100%.";
  static const String invalidDiscountFormat =
      "Please enter a valid discount with up to two decimal places.";
  //Description
  static const String emptyDescription = "Please enter a product description.";
  static const String descriptionTooShort =
      "Product description must be at least 10 characters long.";
  static const String descriptionTooLong =
      "Product description cannot exceed 1000 characters.";
  // Email
  static const String emptyEmail = "Please enter your email address.";
  static const String invalidEmailFormat =
      "Invalid email format! Please enter a valid email.";
  static const String emailTooLong =
      "Email address is too long. Please enter a valid email.";
  // Password
  static const String emptyPassword = "Please enter your password.";
  static const String passwordTooShort =
      "Password must be at least 6 characters long.";
  static const String passwordTooLong = "Password cannot exceed 20 characters.";
  static const String passwordUppercase =
      "Password must contain at least one uppercase letter.";
  static const String passwordLowercase =
      "Password must contain at least one lowercase letter.";
  static const String passwordNumber =
      "Password must contain at least one number.";
  // Confirm Password
  static const String confirmPasswordRequired = "Please confirm your password.";
  static const String passwordMismatch =
      "Passwords do not match. Please re-enter.";
  // Name
  static const String emptyName = "Please enter your name.";
  static const String nameTooShort = "Name must be at least 2 characters long.";
  static const String nameTooLong = "Name cannot exceed 50 characters.";
  static const String nameInvalid = "Name can only contain letters and spaces.";
  // Address
  static const String emptyAddress = "Please enter your address.";
  static const String addressTooShort =
      "Address must be at least 5 characters long.";
  static const String addressTooLong = "Address cannot exceed 200 characters.";

// 📌 Dialog title & Messages
  static const String exitDialogTitle = "Exit Application";
  static const String selectPhotoTitle = "Select Photo";
  static const String takePhotoCameraTitle = "Take a Photo";
  static const String chooseFromGalleryTitle = "Choose from Gallery";
  static const String saveChangesTitle = "Save Changes?";
  static const String areYouWantDeleteTitle = "Do you want to delete?";

  static const String confirmExitMessage = "Are you sure  want to exit?";
  static const String saveMessage = "Do you want to save your changes?";
  static const String deleteMessage =
      "Do you want to delete the product? If you delete the product, it cannot be undone.";

  // Defauld Value:
  static const String defaultName = "Name Not Found";
  static const String defaultEmail = "email@example.com";
  static const String defaultPhone = "No phone number";
  static const String defaultImage =
      "https://www.example.com/default-profile.png";

  // Dialog
  static const okay = "Okay";
  static String exitConent = 'Are you sure you want to Exit this Apps?';
  static const String exit = "Exit App?";

  // sharepare
  static const String onBoardingShareKey = 'onBoarding';

  // On Boarding Item
  static const String welcome = "Welcome";
  static const String firstOnboardingDescription =
      "Welcome to best online grocery store. Here you will find all the groceries at one place.";
  static const String fresshFruits = "Fresh Fruits & Vegetables";
  static const String secondOnboardingDescription =
      "Buy farm fresh fruits & vegetables online at the best & affordable prices.";

  static const String quickDelivery = "Quick & Fast Delivery";
  static const String thirdOnboardingDescription =
      "We offers speedy delivery of your groceries, bathroom supplies, baby care products, pet care items, stationary, etc within 30minutes at your doorstep.";

// 📌 Success & Toast Messages
  static const String successSignUpMessage = "Sign up successful!";
  static const String successSignInMessage = "Sign in successful!";
  static const String errorUserNotFoundToast = "User not found.";
  static const String toastWaitForUploadMessage =
      "Please wait until upload completes.";
  static const String loginProcessOngoingToast =
      "Login process is in progress. Please wait...";
  static const String processOngoingToast = "Please wait.   progressing.";
  static const String pleaseSelectPhotoToast = "Please Select a Photo";
  static const String validPhoneNumberToast =
      'Please enter a valid phone number';
  static const String imageUploadFailToast =
      "Image upload failed. Please try again.";
  static const String selectOneImageToast = "Please Select at least One Image";
  static const updateProductToastMessage = "Succesfully update a New Product";
  static const uploadProductToastMessage = "Succesfully Upload a New Product";

  // Auth Page
  static String adminLogin = "Welcome Admin Login";
  static String logInPageSubjectTitle =
      'Check our fresh viggies from Jasim Grocery';
  static String forgetPassword = "Forget Password";
  static String facebook = "Facebook";
  static String gmail = "Gmail";
  static String pleaseSelectPhoto = "Please Select a Photo";
  static String adminRegistration = "Admin Registration";
  static String alreadyCreateAccount = "Already Create An Account? ";
  static String signup = 'Sign Up';
  static String selectPhoto = "Select Photo";

  static String entreEmailAddressForResetPassword =
      "Please Enter your mail address to reset you password";
  static String resetPassword = "Reset Password";
  static const userDoesntExit = "User Doesn't Exit";
  static String signupSuccessfull = "Sign up Successfully";

  // All
  static const profile = "Profile";
  static const search = "Search";
  static const products = "Products";
  static const String popularProduct = "Popular Product";
  static const home = "Home";
  static const approved = "approved";

  static const finish = "Finish";

  // static const searchHint = "Search...........";

  static String signInSuccessfully = "Sign in Successfully";
  // Home Page
  static const hi = "Hi!";
  static const coldProcess = "Cold Process";
  static const shopNow = "Shop Now";

  // Firebase Error
  static const errorOccure = "Error Occure:";
  static const noDataAvailable = "No Data Available";
  static const productCollection = "products";
  static const productRating = "productrating";
  static const productCategory = "productcategory";
  static const publishDate = "publishDate";
  static const productId = "productId";
  static const firebaseSellerCollection = "seller";
  static const firebaseUserCollection = "users";
  static const firebaseOrderCollection = "orders";
  static const firebaseuid = "uid";
  static const firebaseProductColltion = "products";

  // toName argumane
  static const productModel = "productModel";
  static const isCartBack = "isCartBack";

  // proudduct details
  static const currencyIcon = "৳.";
  static const percentIcon = "%.";
  static const discount = "Discount";

  // Dialog
  static const no = "No";
  static const yes = "Yes";

  // Select
  static const gallery = "Gallery";
  static const camera = "Camera";

  //
  static const pleaseWait = "Pleasing Waiting........";
  static const searchMinPrice = "0.00";
  static const searchMaxPrice = "10000.00";

  // app  Title
  static const searchProduct = "Search Products";

  static const searchProductHere = "Search Product Here";
  static const maxiMumHintText = "Maximum";
  static const minimumHintText = "Minium";

  static const productPrice = 'Product Price';
  static const save = 'Save';
  static const close = 'Close';
  static const reset = "Reset";

  static const pCategory = "Product Category";
  static const filterSearch = "Filter Search";
  static const shipAndBill = "Ship & Bill To";

  // signout
  static const doYouWantSignount = 'Do you want to sign out?';
  static const signOut = "Sign Out";
  static const dark = "Dark";
  static const light = "Light";
  static const myOrder = 'My Orders';
  static const history = 'History';
  static const about = 'About';

  // share Preference
  static const String imageSharedPreference = "imageurl";
  static const String nameSharedPreference = "name";
  static const String emailSharedPreference = "email";
  static const String phoneSharedPreference = "phone";
  static const String cartListSharedPreference = "cartlist";
  static const String uidSharedPreference = "uid";

  // no internet
  static const String noInternet = 'No Internet';
  static const String noInternetMessage =
      'Please check your internet settings and try again.';

  static const String addToCart = "Add To Cart";
  static const String itemAlreadyInCart = "Item Already in Cart";
  static const String theQuantityCannotBeLessThen1 =
      "The Quantity cannot be less then 1";

  static const String someThingWentWrong = "Something went wrong";
  static const String itemAddSuccessfully = "Item Add Successfully";
  static const String noCartAvailabe = "No Cart Available";
  static const String sellerName = "Seller Name";
  static const String cart = "Cart";
  static const String add = "add";
  static const String continueText = "Continue";
  static const String subTotal = "Sub Total (BDT)";
  static const String totalAmount = "Total Amount";
  static const String delliveryCharge = "Delivery Charge";
  static const String priceDelliveryCharge = "50.00";
  static const String carryBagCharge = "Carry Bag Charge";
  static const String priceCarryBagCharge = "0.00";
  static const String itemRemoveSuccessfully = "Item remove Successfully";
  static const String itemNotFoundInCart = "Item not found in cart";
  static const String payBill = "Pay Bill";
  static const String paymentCard = "Payment By Card";
  static const String paymentBkash = "Payment By Bkask";
  static const String delivaryAddress = "Delivery Address";
  static const String alreadyFourAddressAdded =
      "No Addressed because you Already 4 Address Added";
  static const String noAddressAvaiblabe = 'No Address Available';
  static const String paymentCencle = "Payment Cencle";

  static const String cardBaseUrl = 'https://api.stripe.com/v1/payment_intents';
  static const String athorization =
      'Bearer sk_test_51NxWNQAVUbXW3f6RxbSobZOWNsS7ZQvYMmWEGYEayvWWdsNEO8EKh12Ehlnezl6iXr8N7KA6gP2taLHDN2dTwesu002uaYJMYf';
  static const String contentType = 'application/x-www-form-urlencoded';

  // address
  static const String nameHintText = 'Enter your Name';
  static const String editProfile = "Edit Profile";
  static const String phoneHintText = 'Enter Phone';
  static const String flatHintText = 'Flat/House Number';
  static const String streetHintText = 'Street Number or Name';
  static const String villageHintText = 'Village Name';
  static const String cityNameHintText = 'City Name';

  static String yourName = 'Your Name';
  static String enterName = 'Please enter your name';
  static String nameValid = 'Name must be longer than 2 characters';

  static String enterConfirmPassword = 'Please enter your Confirm Password';
  static String validConfirmPassword =
      'Confirm Password Must be geather then 6 Characteris';
  static String passwordConfirm = "Confirm Password";

  static String phoneNumber = "Phone Number";
  static String enterPhone = 'Please enter your phone number';
  static String validPhoneNumber = 'Please Give Valid Phone number';
  static String sendingMail = "Sending a mail. Please Check ur Email";
  static String name = "Name";
  static String all = "All";
  static String removieAllCartSuccessfully = "Remove All Cart Successfully";
  static String phone = "Phone";
  static String paymentMethod = "Payment Method";

  static String confirmDeletion = "Confirm Deletion?";
  static String pleaseEnterAddress = "Please enter your Address";
  static const String pleaseEnterPrefix = "Please enter";
  static const String updateAddress = "Update Address";
  static const String addAddress = "Add Address";
  static const String isUpdate = "isUpdate";
  static const String addressModel = "addressModel";
  static const String update = "Update";
  static const String congratulationOrder =
      "Congratulations, Order has been placed Successfully";
  static const String homePage = "Home Page";
  static const String saveChaned = "Save Changed?";
  static const String countryName = "Country Name";
  static const String uploadNewAddress = "Upload a New Address";
  static const String doYouWantSave = 'do you want to save change?';
  static const String successfullyUpdate = "Sucessfully Update";
  static const String yourOrderIsConfirm = "Your order is confirmed";
  static const String orderPage = "Order Page";
  static const String thankyouforshopping =
      "Thank you for shopping with JU Grocery";

  static const String succesffulyUploadNewAddress =
      "Successfully Upload a New Address";
  static const String succwssulyDelete = "Address deleted successfully";
  static const String phoneNumberMustbeExactly11 =
      "Phone number must be exactly 11 digits";
  static const String nameMustbeLongerThenTow =
      "Name must be longer than 2 characters";

  static const String saveChanged = "Save Changed?";
  static const String address = "Address";
  static const String hintAddress = "Enter Your Address";
  static const String userIsDisable =
      "User is Disable Please Contract with Admin";
  static const String successfullySignedOut = "Successfully Signed Out";
  static const String pleaseGiveYourPhoenNumber =
      "Please Give your Phone Numer";
  static const String profileUdate = "Profile Update";
  static const String orderDetails = "Order Details";
  static const String onTheWayFromDahaka = "On The way From Dhaka!";
  static const String estimatedDeliveryDate = "Estimated Delivery Date is";
  static const String orderDelivery = "Order Delivery ";
  static const String deliveryPartner = "Delivery Partner";
  static const String trackingNumber = "Tracking Number";
  static const String receiver = "Receiver";
  static const String order = "Order";
  static const String onBoardingSharedPre = "onBoarding";
  static const String similarProducts = "Similar Products";
  static const String alreadyAdded = "Already Added";
  static const String rattings = "Rattings";

  static const String exitMessage = 'Are you sure you want to Exit this Apps?';
  static const String orderReadyForShifted = "Ready For Shifted";
  static const String productReadyForUser = "Product Ready for User";
  static const String orderSuccesfuulydone = "Order is Successfully Done";

  //botton and text Button
  static const String signIn = 'Sign In';
  static const String skip = "Skip";
  static const next = "Next";

  // status
  static const String normalOrderStatus = "normal";
  static const String shiftOrderStatus = "shift";
  static const String completeOrderStatus = "complete";

  // Dynamic message generator
  static String pleaseEnterField(String fieldName) {
    return "$pleaseEnterPrefix $fieldName.";
  }

  // TextField
  static const String email = "Email";
  static const String emailAddress = "Email Address";
  static String password = "Password";

  // Validation Text
  static String enterEmailAddress = 'Email Address';
  static String validEmailAddress = 'Valid Email Address';
  static String enterPassword = 'Password';
  static String validPassword = 'Password Must be geather then 6 Characteris';
}
