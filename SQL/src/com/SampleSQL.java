package com;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class SampleSQL {

	public static void main(String[] args) {
		// variables
		Connection connection = null;
		Statement statement = null;
		ResultSet resultSet = null;

		// Step 1: Loading or registering SQl Server JDBC driver class
		try {

			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		}
		catch(ClassNotFoundException cnfex) {

			System.out.println("Problem in loading or "
					+ "registering SQL JDBC driver");
			cnfex.printStackTrace();
		}

		// Step 2: Opening database connection
		try {

			String sqlDB = "20.15.66.67:1433;DatabaseName=eApp_BHF_SIT2";
			String dbURL = "jdbc:sqlserver://" + sqlDB; 

			// Step 2.A: Create and get connection using DriverManager class
			connection = DriverManager.getConnection(dbURL,"",""); 

			// Step 2.B: Creating JDBC Statement 
			//statement = connection.createStatement(); //without scrollable resultset
			statement = connection.createStatement( ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);      //scrollable resultset      

			// Step 2.C: Executing SQL & retrieve data into ResultSet
			resultSet = statement.executeQuery("SELECT * FROM nbp_partialsave where policynumber in ('21820001','21820002')");

			//moving the cursor to last record
			resultSet.last();

			System.out.println("Total no of records :" + resultSet.getRow());

			//move the resultset to before 1st row
			resultSet.beforeFirst();

			System.out.println("First Name\tLast Name");
			System.out.println("==============\t===============================");

			// processing returned data and printing into console
			while(resultSet.next()) {
				System.out.println(resultSet.getString("FIRSTNAME_PINS") + "\t\t" + 
						resultSet.getString("LASTNAME_PINS"));
			}
		}
		catch(SQLException sqlex){
			System.out.println("Problem in connecting to database or "
					+ "DB username and Password is not provided or not correct");
			sqlex.printStackTrace();
		}
		finally {

			// Step 3: Closing database connection
			try {
				if(null != connection) {

					// cleanup resources, once after processing
					resultSet.close();
					statement.close();

					// and then finally close connection
					connection.close();
				}
			}
			catch (SQLException sqlex) {
				
				sqlex.printStackTrace();
			}
		}
	}

}
