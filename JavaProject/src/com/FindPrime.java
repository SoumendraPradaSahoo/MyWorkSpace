package com;

import java.util.Scanner;

public class FindPrime {

	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		System.out.print("Enter a no: ");
		int temp = sc.nextInt();
		Boolean isPrime = true;
		for(int i=2;i<=temp/2;i++)
		{
			if(temp%i==0) {
				isPrime=false;
				break;
			}
		}
		if(isPrime) 
			System.out.println("The entered no " + temp + " is a prime no.");
		else
			System.out.println("The entered no " + temp + " is a not prime no.");

		sc.close();
	}

}
