package com;

import java.util.List;
import java.util.concurrent.TimeUnit;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

public class FlightSearch {

	public static void main(String[] args) throws InterruptedException {
		WebDriver driver = new ChromeDriver();
		try {
		driver.get("https://www.makemytrip.com/flights/");
		driver.manage().window().maximize();
		driver.manage().timeouts().pageLoadTimeout(10, TimeUnit.SECONDS);
		driver.manage().timeouts().implicitlyWait(5, TimeUnit.SECONDS);
		driver.findElement(By.id("hp-widget__sfrom")).clear();
		driver.findElement(By.id("hp-widget__sfrom")).sendKeys("BLR");
		driver.findElement(By.xpath("//div[@class='locationFilter autocomplete_from']/ul/li/div/p/span[contains(text(),'Bangalore')]")).click();
		driver.findElement(By.id("hp-widget__sTo")).clear();
		driver.findElement(By.id("hp-widget__sTo")).sendKeys("BBI");
		//Thread.sleep(1000);
		driver.findElement(By.xpath("//div[@class='locationFilter autocomplete_to']/ul/li/div/p/span[contains(text(),'Bhubaneswar')]")).click();
		driver.findElement(By.id("hp-widget__depart")).click();
		driver.findElement(By.xpath("//table[@class='ui-datepicker-calendar']/tbody//td[@data-month='3']/a[text()='27']")).click();
		//Thread.sleep(1000);
		driver.findElement(By.id("searchBtn")).click();
		
		//Thread.sleep(5000);
		new WebDriverWait(driver, 5).until(ExpectedConditions.visibilityOfAllElementsLocatedBy(By.xpath("//div[@class='listing_top clearfix']")));
		//List<WebElement> flightDetails = driver.findElements(By.xpath("//div[@class='fli-list one-way ']"));
		List<WebElement> flightDetails = driver.findElements(By.xpath("//div[@class='listing_top clearfix']"));
		
		System.out.println("No of flights: " + flightDetails.size());
		//*[@id="fli_list_item0"]/div[1]/div/div/div/div[1]/div[2]/p[2]
		//div/div/div/div/div/div/p[@class="fli-code"]
		
		//Thread.sleep(5000);
		
		for(WebElement ele:flightDetails) {
		
			String flight_name = ele.findElement(By.xpath("child::div//span[@class='pull-left airline_info_detls']/span[starts-with(@class,'logo_name')]")).getText();
			String flight_code = ele.findElement(By.xpath("child::div//span[@class='pull-left airline_info_detls']/span[starts-with(@class,'block logo_name')]")).getText();
			System.out.println(flight_name + " : " + flight_code);
			
			
		}
	//	Thread.sleep(5000);
		}
		catch(Exception e) {
			System.out.println(e.toString());
			
		}
		
		driver.close();
		driver.quit();
		
	}

}
