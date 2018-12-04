package com;

import java.util.Scanner;

public class FindBinary {

	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		int temp = sc.nextInt();
		int test=temp;
		int rem=0;
		int out=0;
		int i=0;
		if (temp==0)
			out=0;
		while(temp>=1)
		{
			rem=temp%2;
			out= rem*((int)Math.pow(10, i++)) + out;
			temp=temp/2;
			System.out.println(out + " " + i);
		}
		System.out.println("Binary of " + test + " is " + out);
		sc.close();
	}

}
