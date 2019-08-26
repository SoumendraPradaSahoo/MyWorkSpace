package com;

import java.io.File;
import java.util.Scanner;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathFactory;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

public class CopyXML {

	public static void main(String[] args) throws Exception {
		DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
		DocumentBuilder db = dbf.newDocumentBuilder();
		//Location of Input xmls
		String inputXMLDir = System.getProperty("user.dir")+ "\\_OXML\\XMLIn";
		String outPutXMLDir = System.getProperty("user.dir")+ "\\_OXML\\XMLOut";
		//Get no of Iterations
		Scanner sc = new Scanner(System.in);
		System.out.println("\nEnter no. of time you want to copy the files.");
		try {
			int noIteration = sc.nextInt();
			sc.close();
			if (noIteration==0) {
				System.out.println("No of Iteration should be greater than 0");
				return;
			}
			for(int i= 1;i<= noIteration;i++) {
				//Location of Input XMLS
				//File   fl = new File("C:\\Users\\ssahoo43\\Desktop\\eApp\\CloneTX103\\_OXML\\XMLIn");
				File   fl = new File(inputXMLDir);
				File[] filesinDir = fl.listFiles();
				for(File files: filesinDir) {
					if (files.getName().endsWith(".xml")) {

						Document originalDocument = db.parse(files);
						//xPath of Holding/Policy		
						XPath xPath =  XPathFactory.newInstance().newXPath();
						String expression = "/TXLife/TXLifeRequest/OLifE/Holding[1]/Policy";	        
						NodeList nodeList   = (NodeList) xPath.compile(expression).evaluate(originalDocument, XPathConstants.NODESET);

						//Select only Primary Holding.
						Node nNode = nodeList.item(0);
						// System.out.println("\nCurrent Element :" + nNode.getNodeName());

						String polNumber_original = "";
						String productCode = "";
						if (nNode.getNodeType() == Node.ELEMENT_NODE) {
							Element eElement = (Element) nNode;
							//Fetch Policy No
							polNumber_original = eElement.getElementsByTagName("PolNumber").item(0).getTextContent();

							//Fetch ProductCode
							productCode = eElement.getElementsByTagName("ProductCode").item(0).getTextContent();

							//Update Policy No
							Node policyNo = eElement.getElementsByTagName("PolNumber").item(0); 
							policyNo.setTextContent("C" + i + polNumber_original);
						}

						//Get the Primary Node of the Input xml
						Node originalRoot = originalDocument.getDocumentElement();

						//New Document for output
						Document copiedDocument = db.newDocument();

						//Copy the Original Document
						Node copiedRoot = copiedDocument.importNode(originalRoot, true);
						copiedDocument.appendChild(copiedRoot);

						//Printing the copied document to the output xml file
						Transformer transformer = TransformerFactory.newInstance().newTransformer();
						transformer.setOutputProperty(OutputKeys.INDENT, "yes");

						//initialize StreamResult with File object to save to file
						String outputFile = outPutXMLDir + "\\Cloned-" + productCode + "-" + polNumber_original + "C" + i + ".xml";
						//outputFile+="Cloned-" + productCode + "-" + polNumber_original + "C" + i + ".xml";
						
						createParentDirectory(outputFile);
						
						StreamResult result = new StreamResult(new File(outputFile));
						DOMSource source = new DOMSource(copiedDocument);
						transformer.transform(source, result);
					}
				}
			}
		}  
	catch(Exception e) {
		System.out.println("Some exception occured....");
		e.printStackTrace();
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