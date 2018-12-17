package com;

import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.support.ui.Select;

public class DropDownSortVerification {

	public static void main(String[] args) {
		WebDriver driver = new ChromeDriver();
		driver.get("file:///C:/Users/ssahoo43/Desktop/eApp/BHF/BRD/PPfA/S%20LS4202.HTML");
		driver.manage().window().maximize();
		WebElement wb = driver.findElement(By.xpath("//html/body/select"));
		Select dropdown = new Select(wb);
		List<WebElement> option = dropdown.getOptions();
		int count = 0;
		for(int i=0;i<option.size()-1;i++)
		{
			if (option.get(i).getText().compareTo(option.get(i+1).getText())>0)
			{
				count++;
				System.out.println(option.get(i).getText() + " is present before " + option.get(i+1).getText());
			}
		}
		if(count!=0)
		System.out.println("The drop down values are not sorted");
		else
		System.out.println("The drop down values are sorted");
		
		driver.close();
		driver.quit();
		

	}

}
