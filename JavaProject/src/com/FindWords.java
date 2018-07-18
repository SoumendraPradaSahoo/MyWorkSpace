package com;

import java.util.ArrayList;
import java.util.List;

public class FindWords {

	public static void main(String[] args) {
		String str = "InterviewInOpentextOnFriday";
		//String str = "interview";
		char[] ch = str.toCharArray();
		List<String> output = new ArrayList<String>();
		int firstpos;
		firstpos=0;
		for (int i=1;i<ch.length;i++) {
			if (Character.isUpperCase(ch[i])) {
				output.add(str.substring(firstpos, i));
				firstpos=i;
			}
		}
		output.add(str.substring(firstpos, ch.length));
	for(String s:output) {
		System.out.println(s);
	}

}
}
