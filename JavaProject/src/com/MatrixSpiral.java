package com;

public class MatrixSpiral {

	public static void main(String[] args) {
	        int R = 3; 
	        int C = 6; 
	        int a[][] = { {1,  2,  3,  4,  5,  6},  
	                      {7,  8,  9,  10, 11, 12},
	                      {13, 14, 15, 16, 17, 18} 
	                    }; 
	        spiralPrint(R,C,a); 
	    }
		
		public static void spiralPrint(int row, int col, int a[][]) {
			int k=0;
			int n=0;
			int l=col-1;
			int m=row-1;
			
			while ((k <= m) &&  (n <= l)) {
			for(int i=k;i<=l;i++)
			{
				System.out.print(a[k][i] + " ");
			}
			k++;
			
			for(int i=k;i<=m;i++)
			{
				System.out.print(a[i][l] + " ");
			}
			l--;
			
			if(k<=m) {
			for(int i=l;i>=n;i--)
			{
				System.out.print(a[m][i] + " ");	
			}}
			m--;
			if(n <= l) {
			for(int i=m;i>=k;i--)
			{
				System.out.print(a[i][n] + " ");	
			}}
			n++;
			
			//System.out.printf("k=%d, l=%d, m=%d, n=%d \n", k, l, m, n);
		}
		}

	}
