class APIConstants {
  // static const baseUrl = "https://api.vegacity.id.vn/api/v1";
  // static const baseUrl = "https://localhost:7127/api/v1";
  static const baseUrl = "https://localhost:7127/api/v1";
  static const contentType = 'application/json';
  static const contentHeader = 'Content-Type';
  static const authHeader = 'Authorization';
  static const prefixToken = 'bearer ';

  // http://14.225.204.144:8000/api/v1/auth/login

  // auth
  static const login = '/auth/login';
  static const register = '/auth/register';
  static const checkExists = '/auth/check-exists';
  static const verifyToken = '/auth/verify-token';
  static const reGenerateToken = '/auth/refresh-token';
  static const changePassword = '/auth/change-password';

  // user
  static const user = '/user';
  // order
  static const order = '/package-item/charge-money';
  // wallet
  static const wallet = '/wallet';
  // wallet etag
  static const card = '/etag';
  // package
  static const packages = '/packages';
  // etags
  static const packageitem = '/package-items';
  // test
  static const trucks = '/packages';
  //PAYMENTS
  static const payment = '/payment';
  //Transactions
  static const transactions = '/transactions';

  // error
  static const Map<String, String> errorTrans = {
    'Email is already registered.': 'Email này đã được đăng kí',
    'Phone number is already registered.': 'Số điện thoại này đã được đăng kí',
    'Email already exists.': 'Email này đã được đăng kí',
    'Phone already exists.': 'Số điện thoại này đã được đăng kí',
    'Wrong Password !!': "Sai password rồi",
    'Password is not changed!': "Hãy nhập mật khẩu hợp lệ",
    'Invalid Email !!': "Email không hợp lệ",
    'User Not Found !!': "Không tìm thấy người dùng",
    'Email does not exist in the system.':
        'Email không tồn tại trong hệ thống.',
    'Email or Password is invalid.': 'Email hoặc mật khẩu không hợp lệ.',
    'Your OTP code does not match the previously sent OTP code.':
        'Mã OTP bạn nhập không đúng.',
    'Email is invalid Email format.': 'Email sai định dạng.',
    'OTP code has expired.': 'Mã OTP đã hết hạn',
    'Email has not been previously authenticated.': 'Email chưa được xác thực',
    'Email is not yet authenticated with the previously sent OTP code.':
        'Email chưa được xác thực bằng mã OTP',
    'You are not allowed to access this function!':
        'Bạn không có quyền truy cập hệ thống',
    'Rejected Reason is not empty.': 'Lý do hủy đơn không được trống',
  };
}
