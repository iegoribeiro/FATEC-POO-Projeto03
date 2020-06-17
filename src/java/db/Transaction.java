package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

/**
 *
 * @author iego_
 */
public class Transaction {
    private long rowId;
    private String datetime;
    private String description;
    private double value;
    private String origin;
    
    public static ArrayList<Transaction> getList()throws Exception{
        ArrayList<Transaction> list = new ArrayList<>();
        Class.forName("org.sqlite.JDBC");
        Connection con = DriverManager.getConnection(web.DbListener.URL);
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT rowid, * from transactions");
        while(rs.next()){
            list.add(
                new Transaction(
                    rs.getLong("rowid"), 
                    rs.getString("datetime"), 
                    rs.getString("description"),
                    rs.getDouble("value"),
                    rs.getString("origin")
                )
            );
        }
        rs.close();
        stmt.close();
        con.close();
        return list;
    }
    public static Transaction getTransaction(long rowId)throws Exception{
        Transaction transaction = null;
        Class.forName("org.sqlite.JDBC");
        Connection con = DriverManager.getConnection(web.DbListener.URL);
        String SQL = "SELECT rowid, * from transactions WHERE rowid=?";
        PreparedStatement stmt = con.prepareStatement(SQL);
        stmt.setLong(1, rowId);
        ResultSet rs = stmt.executeQuery();
        if(rs.next()){
            transaction = new Transaction(
                            rs.getLong("rowid"), 
                            rs.getString("datetime"), 
                            rs.getString("description"),
                            rs.getDouble("value"),
                            rs.getString("origin")
                    );
        }
        rs.close();
        stmt.close();
        con.close();
        return transaction;
    }
    public static void addTransaction(String datetime, String description, double value, String origin) throws Exception{
        Class.forName("org.sqlite.JDBC");
        Connection con = DriverManager.getConnection(web.DbListener.URL);
        String SQL = "INSERT INTO transactions(datetime, description, value, origin) VALUES(?,?,?,?)";
        PreparedStatement stmt = con.prepareStatement(SQL);
        stmt.setString(1, datetime);
        stmt.setString(2, description);
        stmt.setDouble(3, value);
        stmt.setString(4, origin);
        stmt.execute();
        stmt.close();
        con.close();
    }
    public static void putTransaction(long rowId, String datetime, String description, double value, String origin) throws Exception{
        Class.forName("org.sqlite.JDBC");
        Connection con = DriverManager.getConnection(web.DbListener.URL);
        String SQL = "UPDATE transactions "
                + "SET datetime=?, "
                + "description=?, "
                + "value=?, "
                + "origin=? "
                + "WHERE rowid=?";
        PreparedStatement stmt = con.prepareStatement(SQL);
        stmt.setString(1, datetime);
        stmt.setString(2, description);
        stmt.setDouble(3, value);
        stmt.setString(4, origin);
        stmt.setLong(5, rowId);
        stmt.execute();
        stmt.close();
        con.close();
    }
    public static void removeTransaction(long rowId) throws Exception{
        Class.forName("org.sqlite.JDBC");
        Connection con = DriverManager.getConnection(web.DbListener.URL);
        String SQL = "DELETE FROM transactions WHERE rowid=?";
        PreparedStatement stmt = con.prepareStatement(SQL);
        stmt.setLong(1, rowId);
        stmt.execute();
        stmt.close();
        con.close();
    }

    public Transaction(long rowId, String datetime, String description, double value, String origin) {
        this.rowId = rowId;
        this.datetime = datetime;
        this.description = description;
        this.value = value;
        this.origin = origin;
    }

    public String getDatetime() {
        return datetime;
    }

    public void setDatetime(String datetime) {
        this.datetime = datetime;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getValue() {
        return value;
    }

    public void setValue(double value) {
        this.value = value;
    }

    public String getOrigin() {
        return origin;
    }

    public void setOrigin(String origin) {
        this.origin = origin;
    }

    public long getRowId() {
        return rowId;
    }

    public void setRowId(long rowId) {
        this.rowId = rowId;
    }
        
}
