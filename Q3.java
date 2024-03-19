import java.util.Scanner;

public class Q3{


    public static int calculatePower(int power){
        int result = 1;
        for(int a = 0;a<power;a++){
            result*=2;
        }
        return result;
    }

    public static String swapString(String str, int a, int b, int chunk_size){
        str = str.substring(0,a)+str.substring(b, b+chunk_size) + str.substring(a, b) + str.substring(b+chunk_size, str.length());
        return str;
    }
    public static String modify(String input, int n, int chunk_size, int beginning){
        int len = input.length();
        while(beginning+chunk_size<len){
            System.out.println(input);
            input = swapString(input, beginning, beginning+chunk_size, chunk_size);
            beginning+=chunk_size*2;
        }
        return input;
    }
    public static void main(String[] args) {
        Scanner inp = new Scanner(System.in);
        String str = inp.nextLine();
        int num = inp.nextInt();
        for(int n = 0; n<num;n++) {
            int chunk_size = str.length() / calculatePower(n + 1);
            str = modify2(str, 0, str.length() - 1, chunk_size);
            System.out.println(str);
        }
    }
    public static String modify2(String str1, int begin, int end, int chunk_size){

        int mid = (begin + end +1 ) / 2;
        if((end-begin+1)/2!=chunk_size){
            str1 =modify2(str1, begin, mid-1, chunk_size) + modify2(str1, mid, end, chunk_size);
            return str1;
        }

        return str1.substring(mid, end+1) + str1.substring(begin, mid);

    }

}