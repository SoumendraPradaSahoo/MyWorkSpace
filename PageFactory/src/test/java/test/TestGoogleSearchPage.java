package test;

import java.util.concurrent.TimeUnit;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.testng.annotations.AfterTest;
import org.testng.annotations.BeforeTest;
import org.testng.annotations.Test;

import pageFactory.GoogleSearchPage;
import pageFactory.SearchResultpage;

public class TestGoogleSearchPage {
	WebDriver driver;
	GoogleSearchPage googleSearchPage;
	SearchResultpage serachResultPage;
	
	@BeforeTest
	public void setUp() {
		driver=new ChromeDriver();
		driver.get("https://www.google.com/");
		driver.manage().window().maximize();
		driver.manage().timeouts().implicitlyWait(5,TimeUnit.SECONDS);
	}
	
	@Test
	public void test() {
				
		googleSearchPage = new GoogleSearchPage(driver);
		googleSearchPage.search("Soumendra");
		
		serachResultPage = new SearchResultpage(driver);
		serachResultPage.getResult();
	}
	
	@AfterTest
	public void tearDown()
	{
		driver.close();
		driver.quit();
	}
	

}
