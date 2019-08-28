package com;

import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.Dimension;
import org.openqa.selenium.Point;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;

public class GoogleSearchOptoin {

	public static void main(String[] args) throws InterruptedException {
		WebDriver driver = new ChromeDriver();
		driver.get("https://www.google.com/");
		driver.manage().window().maximize();
		//driver.manage().window().setSize(new Dimension(1024, 1000));
		//driver.manage().window().fullscreen();
		WebElement searchbox = driver.findElement(By.name("q"));
		searchbox.sendKeys("Soumendra");
		Point pos = searchbox.getLocation();
		int xpos = pos.getX();
		int ypos = pos.getY();
		System.out.printf("Position of searchbox is %d xpos , %d ypos \n",xpos, ypos);
		
		Dimension dim = searchbox.getSize();
		int width = dim.width;
		int height = dim.height;
		System.out.printf("Dimension of searchbox is %d height, %d width \n", height, width);
		
		
		Thread.sleep(1000);
		List<WebElement> list = driver.findElements(By.xpath("//ul/li//div//div[@class='sbtc']//span"));
		
		if (list.size()==0) {
			System.out.println("No option found in DDLB");
		}
		else {
			for(WebElement ele:list) {
				System.out.println(ele.getText());
			}
		}
		driver.close();
		driver.quit();

	}}
