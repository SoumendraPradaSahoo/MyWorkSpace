package com;

public class MaxPosLength {

	public static void main(String[] args) {
		int arr[] = {1, 2, -3, 2, 3, 4, -6, 1, 2, 3, 4, 5, -8, 5, 6};
		int maxIndex=0;
		int maxLen=0;
		int currLen=0;
		int currIndex=0;

		for(int i=0;i<arr.length;i++) {
			if (arr[i]>0) {
				if (currLen==0){
					currIndex = i;	
				}
				currLen++; 			
			}
			else{

				if (currLen>maxLen) {
					maxLen=currLen;
					maxIndex = currIndex;
				}
				currLen=0;
			}
		}

		System.out.println("Max Postive integer len is " + maxLen + " and its starting from Index " + maxIndex );

	}

}
