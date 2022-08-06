const baseURL = "http://evspay.com/api/";

class Endpoints {
  static const register = "accounts/register";
  static const login = "accounts/login";
  static const recoverPassword = "accounts/password-reset";
  static const verifyPhoneNumberInit = "accounts/verify/phone/init";
  static const verifyPhoneNumberComplete = "accounts/verify/phone/complete";
  static const verifyId = "accounts/verify/identity";
  static const verifyHome = "accounts/verify/address";
  static const uploadProfilePhoto = "accounts/profile/photo";
  static const profileEndpoint = "accounts/profile";
  static const notificationEndpoint = "accounts/notifications";
  static const activityLogEndpoint = "users/activity-logs";
  static const paymentMethods = "payment-methods";
  static const wallet = "wallets";
  static const transactionHistory = "btc/wallets/transactions";
  static const offers = "offers";
  static const trades = "trades";
  static const btcToNairaEndpoint = "services/exchange-rates/0.00046777/btc-to-naira";
}
