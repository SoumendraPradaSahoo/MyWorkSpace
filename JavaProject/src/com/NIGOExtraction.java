package com;

import java.io.File;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathFactory;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

public class NIGOExtraction {

	public static void main(String[] args) throws Exception {
		DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
		DocumentBuilder db = dbf.newDocumentBuilder();
		//Location of Input xmls
		//String inputXMLDir = System.getProperty("user.dir")+ "\\_OXML\\XMLIn";
		String inputXMLDir = "C:\\Users\\ssahoo43\\Desktop\\eApp\\xml files\\Production Tx103 Logs";
		//String outPutXMLDir = System.getProperty("user.dir")+ "\\_OXML\\XMLOut";
		//Get no of Iterations
				File   fl = new File(inputXMLDir);
				File[] filesinDir = fl.listFiles();
				int count = 0;
				for(File files: filesinDir) {
					if (files.getName().endsWith(".xml") && files.getName().startsWith("TX103")) {
						count++;
						Document originalDocument = db.parse(files);
						//xPath of Holding/Policy		
						XPath xPath =  XPathFactory.newInstance().newXPath();
						String expression = "/TXLife/TXLifeRequest/OLifE/Holding[1]/Policy";	        
						NodeList nodeList   = (NodeList) xPath.compile(expression).evaluate(originalDocument, XPathConstants.NODESET);

						//Select only Primary Holding.
						Node nNode = nodeList.item(0);
						// System.out.println("\nCurrent Element :" + nNode.getNodeName());

						String polNumber_original = "";
						//String productCode = "";
						if (nNode.getNodeType() == Node.ELEMENT_NODE) {
							Element eElement = (Element) nNode;
							//Fetch Policy No
							polNumber_original = eElement.getElementsByTagName("PolNumber").item(0).getTextContent();
							
							//System.out.println(polNumber_original);
							
							//Fetch ProductCode
							//productCode = eElement.getElementsByTagName("ProductCode").item(0).getTextContent();
							String nigoInd;
							Element nodeOLifEExtension = null;
							try {
							NodeList nodeListApplicationInfo  = eElement.getElementsByTagName("ApplicationInfo");
							nodeOLifEExtension = (Element) nodeListApplicationInfo.item(0);
							NodeList nodeListApplicationInfoExtension = nodeOLifEExtension.getElementsByTagName("ApplicationInfoExtension");
							eElement = (Element) nodeListApplicationInfoExtension.item(0);
							nigoInd = eElement.getElementsByTagName("NIGOInd").item(0).getTextContent();
							}
							catch(Exception e) {
								nigoInd = "";
							}
							
							String distChan;
							try {
							NodeList nodeListApplicationInfoExtension = nodeOLifEExtension.getElementsByTagName("ApplicationInfoExtension");
							eElement = (Element) nodeListApplicationInfoExtension.item(0);
							distChan = eElement.getElementsByTagName("DistChan").item(0).getTextContent();
							}
							catch(Exception e) {
								distChan = "";
							}
							
							System.out.println(count + "\t" + polNumber_original + "\t" + distChan + "\t" + nigoInd);
						}
						
						
						
					}
				}
			}

	public static boolean createParentDirectory(String absFilePath){

		  boolean result = false;

		  File file = new File(absFilePath);
		  File dir = file.getParentFile();
		  if(dir != null && !dir.exists()){
			  dir.mkdirs();
			  result = true;
		  }

		  return result;
		}

}