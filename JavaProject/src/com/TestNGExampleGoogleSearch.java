package com;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.testng.annotations.DataProvider;
import org.testng.annotations.Test;

public class TestNGExampleGoogleSearch {
	
	@Test (dataProvider="SerachString")
	void f1(String search) {
	WebDriver driver = new ChromeDriver();
	driver.get("https://www.google.com/");
	driver.manage().window().maximize();
	driver.findElement(By.name("q")).sendKeys(search);
	driver.findElement(By.name("q")).submit();
	System.out.println(driver.getTitle());
	driver.quit();
	}
	
	@DataProvider (name= "SerachString")
		public Object[][] getData(){
		String[][] str = {{"Soumendra"},{"Sanjeev"}};
			return str;	
	}
	
}
