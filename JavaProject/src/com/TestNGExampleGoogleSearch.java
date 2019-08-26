package com;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.openqa.selenium.By;
import org.openqa.selenium.Dimension;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.DataProvider;
import org.testng.annotations.Test;

import atu.testrecorder.ATUTestRecorder;
import atu.testrecorder.exceptions.ATUTestRecorderException;

public class TestNGExampleGoogleSearch {
	WebDriver driver;
    ATUTestRecorder recorder;
	
	@BeforeMethod
	void setUp() throws ATUTestRecorderException {
		
		DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy HH-mm-ss");
        Date date = new Date();
 
        //create an object of ATUTestRecorder class and pass 3 parameters explained above.
        recorder = new ATUTestRecorder(System.getProperty("user.dir") + "/Recordings/","Script_Video_" + dateFormat.format(date),false);
 
        //To start video recording.
        recorder.start();
	}
	
	@Test (dataProvider="SerachString")
	void f1(String search) {
	driver = new ChromeDriver();
	driver.get("https://www.google.com/");
	//driver.manage().window().maximize();
	driver.manage().window().setSize(new Dimension(1024, 768));
	driver.findElement(By.name("q")).sendKeys(search);
	driver.findElement(By.name("q")).submit();
	System.out.println(driver.getTitle());
	
	}
	
	@DataProvider (name= "SerachString")
		public Object[][] getData(){
		String[][] str = {{"Soumendra"},{"Sanjeev"}};
			return str;	
	}
	
	@AfterMethod
	void tearDown() throws ATUTestRecorderException{
		driver.quit();	
		recorder.stop();
	}
	
}
