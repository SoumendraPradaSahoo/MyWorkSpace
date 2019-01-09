package com;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DatabaseTesting {

    public static void main(String[] args) {

        // variables
        Connection connection = null;
        Statement statement = null;
        ResultSet resultSet = null;

        // Step 1: Loading or registering Oracle JDBC driver class
        try {

            Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
        }
        catch(ClassNotFoundException cnfex) {

            System.out.println("Problem in loading or "
                    + "registering MS Access JDBC driver");
            cnfex.printStackTrace();
        }

        // Step 2: Opening database connection
        try {

            String msAccDB = "C:\\Users\\ssahoo43\\Downloads\\NBA.mdb";
            String dbURL = "jdbc:ucanaccess://" + msAccDB; 

            // Step 2.A: Create and get connection using DriverManager class
            connection = DriverManager.getConnection(dbURL); 

            // Step 2.B: Creating JDBC Statement 
            //statement = connection.createStatement(); //without scrollable resultset
            statement = connection.createStatement( ResultSet.TYPE_SCROLL_INSENSITIVE,
                    ResultSet.CONCUR_READ_ONLY);      //scrollable resultset      

            // Step 2.C: Executing SQL & retrieve data into ResultSet
            resultSet = statement.executeQuery("SELECT * FROM NBA_BankAccounts");
            
            //moving the cursor to last record
            resultSet.last();
            
            System.out.println("Total no of records :" + resultSet.getRow());
            
            //move the resultset to before 1st row
            resultSet.beforeFirst();

            System.out.println("Bank Account\tTransalation");
            System.out.println("==============\t===============================");

            // processing returned data and printing into console
            while(resultSet.next()) {
                System.out.println(resultSet.getString("BANK_ACCT_NUM") + "\t\t" + 
                        resultSet.getString("TRANSLATION"));
            }
        }
        catch(SQLException sqlex){
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