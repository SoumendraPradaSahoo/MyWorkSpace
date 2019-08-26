package com;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class RegularExpressionExample {

	public static void main(String[] args) {
		String str = "Hi1";
		//Pattern pattern = Pattern.compile("^[0-9a-zA-Z]*$");
		Pattern pattern = Pattern.compile("Hi\\d");
		Matcher matcher = pattern.matcher(str);
		System.out.println(matcher.matches());
		
		String temp = "InterviewInCapgemini";
		pattern = Pattern.compile("[A-Z]");
		matcher = pattern.matcher(temp);
		while(matcher.find()) {
			System.out.println("Pattern found at " + matcher.start() + " and ends at " + (matcher.end() -1) );
			//System.out.println();
		}
		
		String abc = "123abcdEFG12$#@15cbE";
		Pattern pattern2 = Pattern.compile("[a-zA-Z]");
		Pattern pattern3 = Pattern.compile("[0-9]");
		String numericString="", alphabeticString="", specialString="";
		
		for(int i=0;i<abc.length();i++) {
			Matcher matcher2 = pattern2.matcher(String.valueOf(abc.charAt(i)));
			Matcher matcher3 = pattern3.matcher(String.valueOf(abc.charAt(i)));
			
			if (matcher2.matches())
			{
				alphabeticString += String.valueOf(abc.charAt(i));
			}else if (matcher3.matches()){
				numericString += String.valueOf(abc.charAt(i));
			}
			else
				specialString+=String.valueOf(abc.charAt(i));
			
		}
		System.out.println("Alphabetic String: " + alphabeticString);
		System.out.println("Numeric String: " + numericString);
		System.out.println("Special String: " + specialString);
		
	}

}
