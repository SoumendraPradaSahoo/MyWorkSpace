package RestAPIAutomation.RestAPI;

import org.json.JSONArray;
import org.json.JSONObject;
import org.testng.annotations.Test;

import io.restassured.RestAssured;
import io.restassured.response.Response;
import junit.framework.Assert;

public class TestGETSample 
{
    @Test
    public void GETSample()
    {
    	System.out.println("Inside Test");
    	RestAssured.baseURI = "https://reqres.in";
    	Response response=RestAssured.get("/api/users?page=2");
    	int code = response.getStatusCode();
    	String str = response.asString();
    	JSONObject myObject = new JSONObject(str);
    	JSONArray actualObject = myObject.getJSONArray("data");
    	System.out.println("Status code is "+ code);
    	//System.out.println("Response body is "+str);
    	/*System.out.println("Id is " + actualObject.getInt("id"));
    	System.out.println("First Name is " + actualObject.getString("first_name"));
    	System.out.println("Last Name is " + actualObject.getString("last_name"));
    	System.out.println("Avatar is " + actualObject.getString("avatar"));   	
    	String name = actualObject.getString("first_name");
    	Assert.assertEquals("Janet", name);*/
    	Assert.assertEquals(2, myObject.getInt("page"));
    	for(int i=0;i<actualObject.length();i++)
    	{
    		System.out.println("Id of " + (i + 1)  + " : " + actualObject.getJSONObject(i).getInt("id"));
    		System.out.println("Id of " + (i + 1)  + " : " + actualObject.getJSONObject(i).getString("first_name"));
    		System.out.println("Id of " + (i + 1)  + " : " + actualObject.getJSONObject(i).getString("last_name"));
    		System.out.println("Id of " + (i + 1)  + " : " + actualObject.getJSONObject(i).getString("avatar"));
    	}
    }  
}
