//                 << COLLECTIONS NAMES >>
const String COLLECTION_USERS = 'Users';
const String COLLECTION_MESSAGES = 'Messages';
const String COLLECTION_FRIENDS = 'Friends';
const String COLLECTION_FRIENDS_REQUESTS = 'Friends Requests';

//                 << FIELDS NAMES >>
const String FIELD_NAME = 'name';
const String FIELD_PHONE_NUMBER = 'phoneNumber';
const String FIELD_EMAIL = 'email';
const String FIELD_PASSWORD = 'password';
const String FIELD_STATUS = 'status';
const String FIELD_IS_COMPLETED_ACCOUNT = 'isCompletedAccount';
const String FIELD_FRIENDS_COUNT = 'friendsCount';
const String FIELD_FRIENDS_REQUESTS_COUNT = 'friendsRequestsCount';
const String FIELD_PERSONAL_IMAGE = 'personalImage';
const String FIELD_COVER_IMAGE = 'coverImage';
const String FIELD_DESCRIPTION = 'description';
const String FIELD_UID = 'uid';
const String FIELD_LAST_SEEN = 'lastSeen';
const String FIELD_LAST_SIGN_IN = 'lastSignIn';
const String FIELD_GENDER = 'gender';
const String FIELD_COUNTRY = 'country';
const String FIELD_SIGN_IN_METHOD = 'signInMethod';
const String FIELD_DATE_OF_BIRTH = 'dateOfBirth';
const String FIELD_CREATION_TIME = 'creationTime';
const String FIELD_IS_VERIFIED_ACCOUNT = 'isVerifiedAccount';

//                 << STORAGE  >>

const String STORAGE_USERS_PERSONAL_IMAGES_PATH = 'users/personal_images/';
const String STORAGE_USERS_COVER_IMAGES_PATH = 'users/cover_images/';


//                 << USER STATUS >>
const int USER_STATUS_ACTIVE = 2;
const int USER_STATUS_OFFLINE = 1;
const int USER_STATUS_BUSY = 3;

//                 << USER GENDER >>
const int USER_GENDER_MALE = 1;
const int USER_GENDER_FEMALE = 2;

//                 << SIGN IN METHOD>>
const int SIGN_IN_METHOD_FACEBOOK = 3;
const int SIGN_IN_METHOD_GOOGLE = 2;
const int SIGN_IN_METHOD_EMAIL_AND_PASSWORD = 1;

//                 << SUPPORTED COUNTRIES >>
const List<String> COUNTRIES = [
  'Palestine',
  'Jordan',
  'Egypt',
  'Qatar',
  'Algeria',
  'Iraq',
  'Morocco',
  'Saudi Arabia',
  'Yemen',
  'Tunisia',
];

//                 << ERROR MESSAGES >>
const String ERROR_PASSWORD_REQUIRED = 'Password field is required';
const String ERROR_CONFIRM_PASSWORD_REQUIRED =
    'Confirm password field is required';
const String ERROR_CONFIRM_PASSWORD_NOT_MATCH_PASSWORD =
    'Confirm password not match password';
const String ERROR_PASSWORD_LENGTH =
    'Password field must be equal or more than 6 characters';
const String ERROR_EMAIL_REQUIRED = 'Email address field is required';

//                 << SUCCESS MESSAGES >>
const String SUCCESS_RESET_PASSWORD_EMAIL_SENT =
    'We sent an email for you to reset your password';

//                 << ROUTES NAMES >>
const String ROUTES_SIGN_UP_SCREEN = 'signUpScreen';
const String ROUTES_SETUP_SCREEN = 'setupScreen';
const String ROUTES_HOME_SCREEN = 'homeScreen';
const String ROUTES_SIGN_IN_SCREEN = 'signInScreen';
const String ROUTES_SPLASH_SCREEN = 'splashScreen';
const String ROUTES_FORGOT_PASSWORD_SCREEN = 'resetPassword';
const String ROUTES_INTRO_SCREEN = 'introScreen';
const String ROUTES_PROFILE_SCREEN = 'profileScreen';

//                 << ASSETS >>
//   < ASSETS PATHS >
const String ASSETS_IMAGES_FOLDER_PATH = 'assets/images/';

//  < ASSETS IMAGES NAMES >
const String ASSETS_IMAGE_NAME_DEFAULT_USER_PERSONAL_IMAGE =
    '${ASSETS_IMAGES_FOLDER_PATH}default_user_personal_image.jpg';
const String ASSETS_IMAGE_NAME_DEFAULT_USER_COVER_IMAGE =
    '${ASSETS_IMAGES_FOLDER_PATH}default_user_cover_image.jpg';
const String ASSETS_IMAGE_NAME_INTRO_PAGE_1 =
    '${ASSETS_IMAGES_FOLDER_PATH}intro_page_1.jpg';
const String ASSETS_IMAGE_NAME_INTRO_PAGE_2 =
    '${ASSETS_IMAGES_FOLDER_PATH}intro_page_2.jpg';
const String ASSETS_IMAGE_NAME_INTRO_PAGE_3 =
    '${ASSETS_IMAGES_FOLDER_PATH}intro_page_3.jpg';

//                  << SHARED PREFERENCES >>
const String SHARED_PREFERENCES_REMEMBER_ME = 'rememberMe';
const String SHARED_PREFERENCES_IS_FIRST_TIME = 'isFirstTime';
