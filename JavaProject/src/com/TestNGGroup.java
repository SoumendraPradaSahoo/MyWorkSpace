package com;

import java.lang.reflect.Method;

import org.testng.annotations.DataProvider;
import org.testng.annotations.Test;

public class TestNGGroup {
	
	@Test (groups = {"Group1","Group2"}, priority=0, dataProvider= "TestData")
	void g1(String str) {
		System.out.println(str);
		System.out.println("In Group 1 and 2");
	}
	
	@Test (groups = {"Group1"}, priority=1, dataProvider= "TestData")
	void f2(String str) {
		System.out.println(str);
		System.out.println("In Group 1 only");
	}
	
	@DataProvider (name="TestData")
	Object[][] dataProviderF1(Method m){
		String str=m.getName();
		if (str.equalsIgnoreCase("g1")){
			String[][] str1={{"Function G1"}};
			return str1;
		}
		if (str.equalsIgnoreCase("f2")){
			String[][] str1={{"Function F2"}};
			return str1;
		}
		return null;
		
	}

}
