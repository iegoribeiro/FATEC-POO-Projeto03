package web;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Random;

public class tests {
    public static void main(String[] args) {
//        List<Integer> givenList = Arrays.asList(1, 2, 3);
//        
//        Random random = new Random();
        
        Random random = new Random();
        ArrayList<Integer> list = new ArrayList<>(3);
        while (list.size()<3) {
            int n = random.nextInt(3)+1;
            if (!list.contains(n)) {
                list.add(n);
            }
        }
        System.out.println(list);
    }
}
