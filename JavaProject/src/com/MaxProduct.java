package com;

import java.util.Collections;
import java.util.LinkedList;
import java.util.List;

public class MaxProduct {
	
	public static void main (String[] args) {
		MaxProductUsingCollection();	
		MaxProductUsingFindElement();

}
	static void MaxProductUsingCollection() {
		int arr[] = {1, 2, -3, 2, 3, 4, -6, 1, 2, 3, 4, 5, -8, 5, 6};
		List<Integer> al = new LinkedList<Integer>(); 
		int len=arr.length;
		System.out.println("Using Collection Method");
		System.out.println("-----------------------------");
		System.out.println("Start Time " + System.currentTimeMillis());
		for(int i=0;i<len;i++) {
			al.add(arr[i]);
		}
		//System.out.println(len);
		System.out.println(al.size());
		Collections.sort(al);
		
		for(int i=0;i<al.size();i++) {
			System.out.print(al.get(i) + " ");
		}
		if(al.size()<3)
		{
		System.out.println("Input array size is < 3");	
		} else {
		System.out.println();
		System.out.println("Last 3 integer are");
		System.out.println(al.get(al.size()-3) + " " + al.get(al.size()-2)+ " " + al.get(al.size()-1));
		System.out.println("1st 2 integer are");
		System.out.println(al.get(0) + " " + al.get(1));
		System.out.println("Max Prod is " + Math.max(al.get(al.size()-1)*al.get(al.size()-2)*al.get(al.size()-3),
				al.get(al.size()-1)*al.get(0)*al.get(1)));
		}
		System.out.println("End Time " + System.currentTimeMillis());
	}
	
	static void MaxProductUsingFindElement() {
		int arr[] = {1, 2, -3, 2, 3, 4, -6, 1, 2, 3, 4, 5, -8, 5, 6};
		int MaxA = Integer.MIN_VALUE,MaxB=Integer.MIN_VALUE, MaxC=Integer.MIN_VALUE, MinA=Integer.MAX_VALUE, MinB=Integer.MAX_VALUE;
		int len=arr.length;
		System.out.println("Using Find Element Method");
		System.out.println("-----------------------------");
		System.out.println("Start Time " + System.currentTimeMillis());
		for(int i=0;i<len;i++) {
			if(arr[i]>MaxA)
			{
				MaxB=MaxA;
				MaxC=MaxB;
				MaxA=arr[i];
			}
			else if(arr[i]>MaxB)
			{
				MaxC=MaxB;
				MaxB=arr[i];
			}
			else if(arr[i]>MaxC)
			{
				MaxC=arr[i];
			}
			
			if(arr[i]<MinA) {
				MinB=MinA;
				MinA=arr[i];
			}
			else if(arr[i]<MinB) {
				MinB=arr[i];
			}
		}
	if(len<3) {
		System.out.println("Len of array < 3");
		}
	else {
		System.out.println("Max 3 integer are");
		System.out.println(MaxC + " " + MaxB + " " + MaxA);
		System.out.println("Min 2 integer are");
		System.out.println(MinA + " " + MinB);
		System.out.println("Max Prod is " + Math.max(MaxA*MaxB*MaxC, MaxA*MinB*MinA));
	}
	System.out.println("End Time " + System.currentTimeMillis());
	}
	}
