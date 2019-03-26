package com;

import org.testng.annotations.Factory;

public class TestNGFactory {
	
	@Factory
	public Object[] getTestClasses() {
		
		Object[] obj = new Object[2];
		obj[0] = new TestNGExecution();
		obj[1] = new TestNGGroup();
		return obj;
		
	}

}
