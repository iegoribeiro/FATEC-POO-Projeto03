package web;

import db.User;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/**
 *
 * @author grupo03
 */
public class DbListener implements ServletContextListener {
    public static final String URL = "jdbc:sqlite:C:\\Users\\iego_\\OneDrive\\ADS\\4º Semestre\\POO\\SQLiteDB\\quiz.db";
    
    public static String exceptionMessage = null;

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        String step = "Starting database";
        try{
            Class.forName("org.sqlite.JDBC");
            Connection con = DriverManager.getConnection(URL);
            Statement stmt = con.createStatement();
            step = "'users' table creation";
            stmt.executeUpdate("CREATE TABLE IF NOT EXISTS users("
                    + "name VARCHAR(200) NOT NULL,"
                    + "login VARCHAR(20) PRIMARY KEY,"
                    + "password_hash LONG NOT NULL,"
                    + "role VARCHAR(20) NOT NULL"
                    + ")");
            if(User.getList().isEmpty()){
                step = "Default users creation";
                stmt.executeUpdate("INSERT INTO users VALUES("
                        + "'Administrador', 'admin', "+"123456".hashCode()+",'ADMIN')");
                stmt.executeUpdate("INSERT INTO users VALUES("
                        + "'Fulano da Silva', 'fulano', "+"1234".hashCode()+",'USER')");
                stmt.executeUpdate("INSERT INTO users VALUES("
                        + "'Beltrano Souza', 'beltrano', "+"123".hashCode()+",'USER')");
            }
            
            stmt.close();
            con.close();
        }catch(Exception ex){
            exceptionMessage = step + ": " + ex.getMessage();
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        
    }
}
