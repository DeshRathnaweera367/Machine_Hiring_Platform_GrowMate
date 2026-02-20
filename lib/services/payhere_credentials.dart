// This file stores your PayHere credentials safely
// NEVER commit this file to public repositories!
class PayHereCredentials {
  // ✅ Your PayHere sandbox credentials (from sandbox.payhere.lk)
  static const String merchantId = "1234097";
  static const String merchantSecret = "MTAxNjQzMTAyNjE3ODA1ODQwODIxNTc1NzkwNDk5NTM2NzY4MTEz";
  
  // ⚙️ Environment setting
  // true = Sandbox mode (test payments, no real money)
  // false = Live mode (real payments, requires live credentials)
  static const bool isSandbox = true;
  
  // 📝 Helper method to get environment name (for debugging)
  static String get environment => isSandbox ? 'Sandbox' : 'Live';
  
  // ⚠️ IMPORTANT: When going live, remember to:
  // 1. Change isSandbox to false
  // 2. Replace merchantId with your LIVE merchant ID
  // 3. Replace merchantSecret with your LIVE merchant secret
  // 4. NEVER commit live credentials to public repositories!
}