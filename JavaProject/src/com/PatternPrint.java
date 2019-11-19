package com;

import java.util.Scanner;

public class PatternPrint {

	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		
		System.out.print("Enter pattern length : ");
		int len = sc.nextInt();
		sc.close();
		int[][] arr = new int[len][len];
		
		for(int i=0;i<len;i++) {
			for(int j=0;j<=i;j++) {
				if(j==0 || j==i) {
					arr[i][j]=1;
				}
				else {
				arr[i][j] = arr[i-1][j-1] + arr[i-1][j];
				}
						
				
			}
		}
		
		System.out.println("\n Printing pattern \n\n -------------------------------------------");
		for(int i=0;i<len;i++) {
			
			for (int k=i;k<len;k++) {
				System.out.print(" ");
				}
			
			for(int j=0;j<=i;j++) {
				System.out.print(arr[i][j] + " ");
			}
			System.out.println("");
			}
		
	}

}
