package com;

import java.util.HashMap;
import java.util.Map;

public class BenePercentage {

	public static void main(String[] args) {
		int noBene = 7;
		Map<String, String> BenePercentage = new HashMap<String, String>();
		int totalpercentage=100;
		for(int i=1;i<=noBene;i++) {
			int intPercentage = totalpercentage/(noBene-i+1);
			BenePercentage.put("A_InterestPercent_BEN" + i, Integer.toString(intPercentage));
			totalpercentage = totalpercentage - intPercentage;
			}
		for(Map.Entry<String, String> entry : BenePercentage.entrySet())
		{
			System.out.println(entry.getKey() + " : " + entry.getValue());
			}
		}

}
