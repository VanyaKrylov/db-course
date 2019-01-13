package bd;

import org.apache.commons.lang3.RandomStringUtils;
import java.util.Random;
import java.sql.Date;

public class Generator {

    static String generateString(int minLength, int maxLength) {
        int length = generateInt(minLength, maxLength);
        return RandomStringUtils.randomAlphabetic(length);
    }
  
    static String generateDate(String min, String max){
        long from = Date.valueOf(min).getTime();
        long to = Date.valueOf(max).getTime();
        Date gDate = new Date(from + (long) (Math.random() * (to - from + 1)));
        return String.valueOf(gDate);

        //String date="";
        //int yearBegin=1990;
        //int yearEnd=2018-yearBegin;
        //date=""+(1+(int)(Math.random()*28)+"/"+(1+(int)(Math.random()*12)+"/"+(yearBegin+(int)(Math.random()*yearEnd))));
        //return date;
    }
     
    
      static Double generateDouble(double min, double max) {
          Random r=new Random();
          double rand=min+((max - min) + 1) *r.nextDouble();
          return Double.valueOf(rand);
    }
    static int generateInt(int min, int max) {
   
        return (int)(Math.random()*((max - min) + 1)) + min;
    }

    static boolean generateBoolean() {
        return Math.random()<0.5;
    }

    static long generatePhoneNumber(){
        int num1, num2, num3;
        int set2, set3;
        Random generator = new Random();
        num1 = generator.nextInt(7) + 1; //до 8 без 0
        num2 = generator.nextInt(8);//до 8 с 0
        num3 = generator.nextInt(8);
        set2 = generator.nextInt(643) + 100;//100 до 743
        set3 = generator.nextInt(8999) + 1000;//1000 до 9999
        return  Long.valueOf("8" + num1 + num2 + num3 + set2 + set3);
    }
}

