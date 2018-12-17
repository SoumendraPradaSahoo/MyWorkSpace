package RestAPIAutomation.RestAPI;

import org.json.JSONObject;
import org.testng.annotations.Test;
import io.restassured.RestAssured;
import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;

public class TestPOSTSample {
	@Test
	public void POSTSample() {
		RestAssured.baseURI = "https://reqres.in";
		RequestSpecification httpRequest = RestAssured.given();
		httpRequest.header("Content-Type", "application/json");
		// Create new JSON Object
		JSONObject userDetails = new JSONObject();
		userDetails.put("name", "morpheus");
		userDetails.put("job", "leader");
		httpRequest.body(userDetails.toString());
		Response response = httpRequest.post("/api/users");
		int code = response.getStatusCode();
		System.out.println("Status code is " + code);
		JSONObject myObject = new JSONObject(response.asString());
		System.out.println("Id is " + myObject.getString("id"));
	}

}
