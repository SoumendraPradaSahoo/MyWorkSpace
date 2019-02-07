package com;

public class CountChar  
{ 
    static final int NO_OF_CHARS = 256; 
      
    /* Fills count array with frequency of characters */
    static void fillCharCounts(String str, int[] count) 
    { 
       for (int i = 0; i < str.length();  i++) {
    	  //int a = Character.getNumericValue(str.charAt(i));
    	 // if (str.contains(String.valueOf(str.charAt(i))))
          count[str.charAt(i)]++; 
    } }
       
    /* Print duplicates present in the passed string */
    static void printDups(String str) 
    { 
    	
      // Create an array of size 256 and fill count of every character in it 
      int count[] = new int[NO_OF_CHARS]; 
      int max_Count=0;
      String charwithMaxCount="";
      fillCharCounts(str, count); 
      
      
      for (int i = 0; i < NO_OF_CHARS; i++) {
       if(count[i] > 0) {
            System.out.printf("%c,  count = %d \n", i,  count[i]); 
            if (count[i]>max_Count) {
            	max_Count=count[i];
            	charwithMaxCount= String.valueOf((char)i);
            }else if(count[i]==max_Count) {
            	charwithMaxCount = charwithMaxCount + ", " + String.valueOf((char)i);
            }
       }
      }
      
      System.out.println("Max occurance of character(s) : '" + charwithMaxCount + "' is " + max_Count);
       
    } 
       
    // Driver Method 
    public static void main(String[] args) 
    { 
    	System.out.println("Start Time: " + System.currentTimeMillis());
        String str = "Spring Test"; 
        printDups(str); 
        System.out.println("End Time: " + System.currentTimeMillis());
    } 
} 