package RestAPIAutomation.RestAPI;

import org.json.JSONArray;
import org.json.JSONObject;
import org.testng.annotations.Test;
import io.restassured.RestAssured;
import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;
import junit.framework.Assert;

public class JiraRestAPIGet 
{
    @Test
    public void GETSample()
    {
    	System.out.println("Inside Test");
    	RestAssured.baseURI = "#######"; //Give the Jira url, parent url
    	RequestSpecification httpRequest = RestAssured.given();
    	httpRequest.header("Authorization", "Basic ########"); //Give the basic authentication of username:password in base64 encoded format
		httpRequest.header("Content-Type", "application/json");
    	Response response=httpRequest.get("/rest/api/2/search?jql=fixVersion=######"); //Fix Version needs to be provided
    	int code = response.getStatusCode();
    	System.out.println("Status code is "+ code);
    	    	
    	Assert.assertEquals(200, code);
    	
    	String str = response.asString();
    	JSONObject myObject = new JSONObject(str);
    	System.out.println("Total# Issues " + myObject.getInt("total"));
    	JSONArray actualObject = myObject.getJSONArray("issues");
    	System.out.println("Jiras in the Version");
    	System.out.println("---------------------");
    	for(int i=0;i<actualObject.length();i++)
    	{
    		String key = actualObject.getJSONObject(i).getString("key");
    		JSONObject fields = new JSONObject(actualObject.getJSONObject(i).getJSONObject("fields").toString());
    		String summary = fields.getString("summary");
    		JSONObject issuetype = new JSONObject(fields.getJSONObject("issuetype").toString());
    		String issueName = issuetype.getString("name");
    		System.out.println(issueName + " " + key + " : " + summary);
    	}
    }  
}
