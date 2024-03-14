package model;

public class Constants {
    public static String GOOGLE_CLIENT_ID = "847546457050-7ccq01atin7m0ke5v2nva6u7i3k7bn6r.apps.googleusercontent.com";
    public static String GOOGLE_CLIENT_SECRET = "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";
    public static String GOOGLE_REDIRECT_URI = "http://localhost:8080/googlehandle";
    public static String GOOGLE_LINK_GET_TOKEN= "https://accounts.google.com/o/oauth2/token";
    public static String GOOGLE_LINK_GET_USER_INFO = "https://www.googleapis.com/oauth2/v1/userinfo?access_token=";
    public static String GOOGLE_GRANT_TYPE = "authorization_code";

    public static String FACEBOOK_APP_ID = "424799260070203";
    public static String FACEBOOK_APP_SECRET = "dce8cd289e47cbda11f123796c246994";
    public static String FACEBOOK_REDIRECT_URL = "http://localhost:8080/fbhandle";
    public static String FACEBOOK_LINK_GET_TOKEN = "https://graph.facebook.com/oauth/access_token?client_id=%s&client_secret=%s&redirect_uri=%s&code=%s";
}
