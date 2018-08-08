package com;

import java.util.ArrayList;
import java.util.List;
import org.testng.ITestResult;
import org.testng.TestListenerAdapter;
import org.testng.TestNG;

public class TestNGClass {
	@SuppressWarnings("deprecation")
	public static void main(String[] args) {
	TestNG test = new TestNG();
	TestListenerAdapter list = new TestListenerAdapter();
	test.addListener(list);
	List<String> suites = new ArrayList<String>();
	suites.add("D:\\MyWorkSpace\\JavaProject\\TestNGExampleGoogleSearch.xml");
	test.setTestSuites(suites);
	test.run();
	List<ITestResult> result = list.getPassedTests();
	for (ITestResult r:result) {
		System.out.println(r.getName());
	}
	
	}

}
