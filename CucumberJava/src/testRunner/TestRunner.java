package testRunner;

import org.junit.runner.RunWith;
import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
@RunWith(Cucumber.class)
@CucumberOptions(
		features = {"Feature"},
		glue={"stepDef"},
		tags= {"@RegressionTest"},			
		plugin= {"html:Target/Report"}
		)
public class TestRunner {	 
}
