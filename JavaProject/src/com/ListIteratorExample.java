package com;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;

public class ListIteratorExample {

	public static void main(String[] args) {
		List<String> lst = new ArrayList<String>();
		lst.add("Soumendra");
		lst.add("Sanjeev");
		ListIterator<String> itr = lst.listIterator();
		
		while(itr.hasNext())
		{	
			System.out.println(itr.next());
			itr.add("Sudha");
		}
		
		System.out.println("Printing New Iteration");
		Iterator<String> itr1 = lst.iterator();
		while(itr1.hasNext())
		{
			System.out.println(itr1.next());
		}
	}

}
