package com;

import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.Map;
import java.util.Set;

public class RemoveDuplicateChar {

	public static void main(String[] args) {
		String input = new String("soumendra prasad sahoo");
        Set<Character> output = new LinkedHashSet<Character>();
        String outString = new String();
        Map<Character, Integer> count = new HashMap<Character, Integer>();
        
        for(char c: input.toCharArray()) {
        	output.add(c);
        }
        
        for (char c:output) {
        	outString += String.valueOf(c);
        }
        
        for (char c:input.toCharArray()) {
        	if (count.containsKey(c)) {
        		count.put(c,count.get(c)+1);
        	}else {
        		count.put(c,1);
        	}
        }
        
        System.out.println(outString);
        
        for (Map.Entry<Character, Integer> entry: count.entrySet()) {
        	System.out.println("Occurance of character '" + entry.getKey() + "' is : " + entry.getValue());
        }

	}
}
