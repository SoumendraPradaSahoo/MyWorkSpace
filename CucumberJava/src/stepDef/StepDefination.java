package stepDef;

import org.junit.Assert;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;

import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;

public class StepDefination {
	WebDriver driver;
	@Given("Open Chrome Browser")
	public void open_Chrome_Browser() {
		driver=new ChromeDriver();
	}


	@Given("Lunch Google in Browser")
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
		System.out.println(driver.getTitle());
	}
	
	@Then("^Verify Title \"([^\"]*)\"$")
	public void verify_Title(String string) {
	    String title = driver.getTitle();
	    try {
	    Assert.assertTrue("Titles are equal", title.equalsIgnoreCase(string));
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
