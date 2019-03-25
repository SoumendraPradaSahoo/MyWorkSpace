package pageFactory;

import java.util.List;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;

public class SearchResultpage {
	WebDriver driver;
	
	@FindBy(xpath="//*[@class='LC20lb']")
	List<WebElement> searchResult;
	
	public SearchResultpage(WebDriver driver) {
		this.driver=driver;
		PageFactory.initElements(driver, this);
	}
	
	public void getResult() {
		
		for(WebElement ele:searchResult)
		{
			System.out.println(ele.getText());
		}
	}
}
