package com;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.ie.InternetExplorerDriver;


public class IEDriverExample {
	public static void main(String[] args) {
		System.setProperty("InternetExplorerDriver.REQUIRE_WINDOW_FOCUS", "true");
		WebDriver driver = new InternetExplorerDriver();
		driver.get("https://www.google.com/");
		driver.manage().window().maximize();
		driver.findElement(By.name("q")).sendKeys("Soumendra");
		driver.findElement(By.name("q")).submit();
		System.out.println(driver.getTitle());
		driver.quit();
	}
}
