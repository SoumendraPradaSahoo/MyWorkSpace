package pageFactory;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;

public class GoogleSearchPage {

		WebDriver driver;
		
		@FindBy(name="q")
		WebElement searchBox;
		
		@FindBy(name="btnK")
		WebElement searchButton;
		
		public GoogleSearchPage(WebDriver driver) {
			this.driver=driver;
			PageFactory.initElements(driver, this);
		}
		
		public void search(String str) {
			
			searchBox.sendKeys(str);
			searchButton.click();
		}
		
}
