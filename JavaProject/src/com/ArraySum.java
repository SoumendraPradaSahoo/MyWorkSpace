package com;

public class ArraySum {

	public static void main(String[] args) {
		int[] a = {1,2,3,4,5,6} ;
		int[] b = {2,3,4,5,6,7,8} ;
		int[] c= new int[a.length+b.length];
		int len=0,i=0,j=0;
		int sum=0;
		if(a.length>b.length) {
			len=a.length;
		}
		else
			len=b.length;
		
		for(i=0;i<len;i++) {
			if(i<a.length && i<b.length) {
			sum=a[i]+b[i];	
				if(sum>9) {
					int temp=sum%10;
					c[j++]=1;
					c[j++]=temp;
				}else {
					c[j++]=sum;
				}
			}
			else if(i<a.length) {
				c[j++]=a[i];
			}
			else {
				c[j++]=b[i];
			}
		}
		
		for(i=0;i<j;i++) {
			System.out.print(c[i] + " ");
		}

	}

}
