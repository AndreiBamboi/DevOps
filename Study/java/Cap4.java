public class Cap4{
    public static void main(String[]args){
        int val1=7;
        int val2=5;
        int maxval = val1 > val2 ? val1 : val2 ;
        System.out.println(maxval);
        if (val1 > val2)
            System.out.println("value1 is bigger");
        else
            System.out.println("value1 is not bigger");
        final int diff;
        int resultat = val1 > val2 ? val1 : val2;
        System.out.println(resultat);

    }
}
