package com;

public class NonRepeatingSubString {

	public static void main(String[] args) {
		String str = "JAVA_IS_A_GOOD_LANGUAGE";
		String currString="";
		String maxString="";
		int currLength=0,maxLength=0;
		
		for(int i=0;i<str.length();i++) {
			if(!currString.contains(Character.toString(str.charAt(i)))) {
				currLength++;
				currString+=str.charAt(i);
			}
				else {
					if(currLength>maxLength) {
						maxLength=currLength;
						maxString=currString;
					}
					currString=currString.substring(currString.indexOf(str.charAt(i))+1, currString.length());
					currString+=str.charAt(i);
					currLength=currString.length();
				}
			}
		System.out.println("Max Length is " + maxLength + " and max String is " + maxString);
		}
	}
