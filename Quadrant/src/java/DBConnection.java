
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
    ResultSet user;

    DBConnection(String dburl) {
        this.dburl = dburl;
        this.conn = null;
        this.connprops = new Properties();
        this.connprops.put("user", "ismi01");
        this.connprops.put("password", "K8dKjuSx");
        this.user = null;
    }

    public boolean connectDB(){
        try {
            this.conn = DriverManager.getConnection("jdbc:mysql://"+this.dburl+"/ismi01",this.connprops);
        } catch (SQLException ex) {
            
            return false;
        }
        return true;
    }
    
    public boolean setUser(String username) {
        Statement statement = null;
        this.user = null;
        String query = "select * from quad_user_table where email=\'"+username+"\';";
        try {
            statement = this.conn.createStatement();
            this.user = statement.executeQuery(query);
            while(this.user.next()){
                if(this.user.getString("Email").contentEquals(username)){
                    return true;
                }
            }
        } catch (SQLException ex) {
            return false;
        }
        return false;
    }
}
