package com;

public class StringRev {

	public static void main(String[] args) {
		String str = "Soumendra";
		char[] ch = str.toCharArray();
		char temp;
		System.out.println( ch.length);
		for (int i=0; i< ch.length/2; i++)
		{
			temp = ch[i];
			ch[i] = ch[ch.length - 1 - i];
			ch[ch.length - 1 - i] = temp;
		}
		for (int i=0; i< ch.length; i++)
		{
			System.out.print(ch[i]);
		}
		System.out.println("");
		StringBuilder abc = new StringBuilder();
		abc.append(str);
		abc.reverse();
		System.out.println(abc.toString());
				
		
	}

}
