package stepDef;


import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;

import com.cucumber.listener.Reporter;

import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import junit.framework.Assert;

public class StepDefination {
	WebDriver driver;
	@Given("^Open Chrome Browser$")
	public void open_Chrome_Browser() {
		driver=new ChromeDriver();


	}

	@Given("^Lunch Google in Browser$")
	public void lunch_Google_in_Browser() {
		driver.get("https://www.google.com/");
		driver.manage().window().maximize();
	}

	@When("^Search \"([^\"]*)\"$")
	public void search(String serachString) {
		driver.findElement(By.name("q")).sendKeys(serachString);

	}

	@When("^Click on Search$")
	public void click_on_Search() {
		driver.findElement(By.name("q")).submit();
	}

	@Then("^Verify Title$")
	public void verify_Title() {
		Reporter.addStepLog(driver.getTitle());
		System.out.println(driver.getTitle());
	}
	
	@Then("^Get the list of hyperlinks$")
	public void get_the_list_of_hyperlinks() {
	    List<WebElement> wb_list = driver.findElements(By.xpath("//h3[@class='LC20lb']"));
	    for (WebElement wb: wb_list) {
	    	WebElement wb_temp = wb.findElement(By.xpath("parent::a"));
	    	System.out.print(wb.getText());
	    	System.out.println("\t - " + wb_temp.getAttribute("href"));
	    }
	}
	
	@Then("^Verify Title \"([^\"]*)\"$")
	public void verify_Title(String string) {
	    String title = driver.getTitle();
	    try {
	    Assert.assertTrue("Titles are equal", title.equalsIgnoreCase(string));
	    Reporter.addStepLog(title);
	    }catch (Exception e) {
	    	System.out.println(e.getMessage());
	    }
	}

	@Then("^Close the browser$")
	public void close_the_browser() {
		// Write code here that turns the phrase above into concrete actions
		driver.close();
		driver.quit();
	}
}
