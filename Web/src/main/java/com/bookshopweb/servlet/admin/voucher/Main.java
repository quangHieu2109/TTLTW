package com.bookshopweb.servlet.admin.voucher;

import java.util.Random;

public class Main {
    protected static String createVoucherCode(){
        String result = "";
        Random rd = new Random();
        while(result.length() <6){
            if(rd.nextInt(9) % 2 ==0){
                int c = rd.nextInt( 25)+65;
                if(rd.nextInt(10) % 2 ==0){
                    c += 32;
                }
                result += (char)c;
            }else{
                result += rd.nextInt(9);
            }
        }
        return result;
    }
    public static void main(String[] args) {
        System.out.println(Main.createVoucherCode());
    }
}
