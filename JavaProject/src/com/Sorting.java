package com;

public class Sorting {

	public static void main(String[] args) {
		int[] input = {10, 30, 12, 8, 7, 99};
		int temp;
		for (int i=0; i< input.length;i++) {
			for (int j=0; j < input.length-i-1; j++) {
				if (input[j]>input[j+1]) {
					temp = input[j+1];
					input[j+1]=input[j];
					input[j]=temp;
				}
			}
		}
		for (int i=0; i<input.length;i++)
			System.out.print(input[i] + "\t");
	}

}
