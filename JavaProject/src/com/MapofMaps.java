package com;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

public class MapofMaps {
	public static void main(String args[]) {
		HashMap<String, LinkedHashMap<String, String>> allLocators = new LinkedHashMap<String, LinkedHashMap<String, String>>();
		LinkedHashMap<String, String> locators = new LinkedHashMap<String, String>();
		String sheetname = "Annuitant";
		String Filed_Name = "Suffix";
		String Field_Type = "TextBox";	
		String Identifier = "id";
		String Locator = "name";
		String Client_Side_Message_Identifier = "xpath";
		String Client_Side_Message_Locator = "//td[@class='abc']";
		locators.put("Field_Type", Field_Type);
		locators.put("Identifier", Identifier);
		locators.put("Locator", Locator);
		locators.put("Client_Side_Message_Identifier", Client_Side_Message_Identifier);
		locators.put("Client_Side_Message_Locator", Client_Side_Message_Locator);
		allLocators.put(sheetname + "." + Filed_Name, locators);
		locators = new LinkedHashMap<String, String>();
		locators.put("Field_Type", "DDLB");
		locators.put("Identifier", "name");
		locators.put("Locator", "a_Prefix");
		locators.put("Client_Side_Message_Identifier", "xpath");
		locators.put("Client_Side_Message_Locator", "//td[@class='xyz']");
		allLocators.put("Annuitant.Prefix", locators);
		for (Map.Entry<String, LinkedHashMap<String, String>> entry:allLocators.entrySet()) {
			System.out.println(entry.getKey() );
			System.out.println(entry.getValue() );
		}
	}

}
