package com;

import java.util.HashSet;
import java.util.Set;

public class SetDemo {
	public static void main(String[] args) {
		
		Set<String> dum = new HashSet<String>();
		dum.add("abc");
		dum.add("xyz");
		dum.add("abc");
		
		for(String list:dum) {
			System.out.println(list);
		}
		
		
	}

}
