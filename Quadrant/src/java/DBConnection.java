
import java.sql.*;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Ian
 */
public class DBConnection {

    String dburl;
    Connection conn;
    Properties connprops;

    DBConnection(String dburl) {
        this.dburl = dburl;
        this.conn = null;
        this.connprops = new Properties();
        this.connprops.put("user", "root");
        this.connprops.put("password", "root");
    }

    public String connectDB(){
        try {
            this.conn = DriverManager.getConnection("jdbc:mysql://"+this.dburl+"/quadrantdb",this.connprops);
        } catch (SQLException ex) {
            
            return ex.getLocalizedMessage();
        }
        return "yay";
    }
    
    public String find(String username) {
        Statement statement = null;
        ResultSet result = null;
        String query = "select * from user_table where email=\'"+username+"\';";
        String check = null;
        try {
            statement = this.conn.createStatement();
            result = statement.executeQuery(query);
            if(result.getString("Email").contentEquals(username)){
                    check = "yay";
            }
            while(result.next()){
                if(result.getString("Email").contentEquals(username)){
                    check = "yay";
                }
            }
        } catch (SQLException ex) {
            check = query;
        }
        return check;
    }
}
