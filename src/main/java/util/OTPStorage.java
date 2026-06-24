package util;

import java.util.HashMap;
import java.util.Random;

public class OTPStorage {

    public static HashMap<String, String> otpMap = new HashMap<>();

    // generate 6 digit OTP
    public static String generateOTP() {
        Random r = new Random();
        int otp = 100000 + r.nextInt(900000);
        return String.valueOf(otp);
    }
}