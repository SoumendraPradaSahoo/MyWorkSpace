package com;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.firefox.FirefoxDriver;

public class FirefoxDriverExample {

	public static void main(String[] args) {
		System.setProperty("webdriver.firefox.marionette", "false");
		WebDriver driver = new FirefoxDriver();
		driver.get("https://www.google.com/");
		//driver.manage().window().maximize();
		driver.findElement(By.name("q")).sendKeys("Soumendra");
		driver.findElement(By.name("q")).submit();
		System.out.println(driver.getTitle());
		driver.close();
		driver.quit();
	}

}
