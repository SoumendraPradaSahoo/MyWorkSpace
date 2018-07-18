package com;

import org.testng.annotations.Test;
import org.testng.annotations.BeforeTest;
import org.testng.annotations.Parameters;

import java.net.MalformedURLException;
import java.net.URL;

import org.openqa.selenium.By;
import org.openqa.selenium.Platform;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.remote.DesiredCapabilities;
import org.openqa.selenium.remote.RemoteWebDriver;
import org.testng.annotations.AfterTest;

public class ParallelTest {
	WebDriver driver;
	DesiredCapabilities cap = new DesiredCapabilities();
	@Test
	public void f() throws MalformedURLException {
		driver = new RemoteWebDriver(new URL("http://localhost:8080/wd/hub"), cap);
		driver.get("https://www.google.com/");
		//driver.manage().window().maximize();
		driver.findElement(By.name("q")).sendKeys("Soumendra");
		driver.findElement(By.name("q")).submit();
		System.out.println(driver.getTitle());
	}

	@Parameters("browser")
	@BeforeTest
	public void beforeTest(String browser) {
		if (browser.equalsIgnoreCase("Chrome")){
			cap.setBrowserName("chrome");
			cap.setPlatform(Platform.WIN10);
		}
		if (browser.equalsIgnoreCase("Firefox")){
			cap.setBrowserName("firefox");
			cap.setCapability("marionette", true);
			cap.setPlatform(Platform.WIN10);
		}
	}

	@AfterTest
	public void afterTest() {
		driver.quit();
	}

}
