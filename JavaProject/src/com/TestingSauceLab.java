package com;

import java.net.MalformedURLException;
import java.net.URL;
import org.openqa.selenium.By;
import org.openqa.selenium.Platform;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.remote.DesiredCapabilities;
import org.openqa.selenium.remote.RemoteWebDriver;

public class TestingSauceLab {

	public static void main(String[] args) throws MalformedURLException {
		WebDriver driver;
		DesiredCapabilities cap = new DesiredCapabilities();
		cap.setBrowserName("internet explorer");
		cap.setPlatform(Platform.WIN10);
		cap.setCapability("username", "somu123_pdp");
		cap.setCapability("accessKey", "");
		driver = new RemoteWebDriver(new URL("http://ondemand.saucelabs.com:80/wd/hub"), cap);
		driver.get("https://www.google.com/");
		driver.manage().window().maximize();
		driver.findElement(By.name("q")).sendKeys("Soumendra");
		driver.findElement(By.name("q")).submit();
		System.out.println(driver.getTitle());
		driver.quit();
		

	}
}
