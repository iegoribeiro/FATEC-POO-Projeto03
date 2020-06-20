package web;

import db.CategoryEnum;
import db.Question;
import db.Result;
import db.User;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

public class DbListener implements ServletContextListener {

    public static final String URL = "jdbc:sqlite:C:\\Users\\iego_\\OneDrive\\ADS\\4º Semestre\\POO\\Projeto3_Quiz\\SQLite\\quiz.db";    
    public static String exceptionMessage = null;
        
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        String step = "Starting database";
        try {
            Class.forName("org.sqlite.JDBC");
            Connection con = DriverManager.getConnection(URL);
            Statement stmt = con.createStatement();
            
            step = "alter default setting for foreign key";
            stmt.executeUpdate("PRAGMA foreign_keys = ON");
            
            step = "'users' table creation";
            stmt.executeUpdate("CREATE TABLE IF NOT EXISTS users("
                    + "name VARCHAR(200) NOT NULL,"
                    + "login VARCHAR(20) PRIMARY KEY,"
                    + "password_hash LONG NOT NULL,"
                    + "role VARCHAR(20) NOT NULL"
                    + ")");
                                    
            if(User.getList().isEmpty()){
                step = "Default user creation";
                stmt.executeUpdate("INSERT INTO users VALUES ("
                    + "'Administrador', 'admin', "+"123456".hashCode()+",'ADMIN')");
                stmt.executeUpdate("INSERT INTO users VALUES ("
                    + "'Fulano da Silva', 'fulano', "+"1234".hashCode()+",'USER')");
                stmt.executeUpdate("INSERT INTO users VALUES ("
                    + "'Beltrano Souza', 'beltrano', "+"123".hashCode()+",'USER')");
            }
            
            step = "'category_enum' table creation";
            stmt.executeUpdate("CREATE TABLE IF NOT EXISTS category_enum("
                    + "id INTEGER PRIMARY KEY AUTOINCREMENT,"
                    + "name VARCHAR(100) NOT NULL"
                    + ")");
            
            if(CategoryEnum.getList().isEmpty()){
                step = "Default Category Enum creation";
                stmt.executeUpdate("INSERT INTO category_enum VALUES (NULL, 'Esporte')");
                stmt.executeUpdate("INSERT INTO category_enum VALUES (NULL, 'Exatas')");
            }
            
            step = "'questions' table creation";
            stmt.executeUpdate("CREATE TABLE IF NOT EXISTS questions("
                    + "question VARCHAR(255) NOT NULL,"
                    + "answer1 VARCHAR(255) NOT NULL,"
                    + "answer2 VARCHAR(255) NOT NULL,"
                    + "answer3 VARCHAR(255),"
                    + "fk_category_enum INTEGER NOT NULL,"
                    + "CONSTRAINT fk_category_enum FOREIGN KEY (fk_category_enum) REFERENCES category_enum(id)"
                    + ")");
            
            if(Question.getList().isEmpty()){
                step = "Default questions creation";
                stmt.executeUpdate("INSERT INTO questions VALUES ('Quanto é 1+1?', '1', 'dois', '3', 2)");
            }
            
            step = "'results' table creation";
            stmt.executeUpdate("CREATE TABLE IF NOT EXISTS results("
                    + "result INTEGER NOT NULL,"
                    + "fk_user_login VARCHAR(20) NOT NULL,"
                    + "fk_category_enum INTEGER,"
                    + "FOREIGN KEY (fk_user_login) REFERENCES users(login),"
                    + "FOREIGN KEY (fk_category_enum) REFERENCES category_enum(id),"
                    + "CHECK (result >= 0 AND result <= 100)"
                    + ")");
            
           if(Result.getList().isEmpty()){
                step = "Default results creation";
                stmt.executeUpdate("INSERT INTO results VALUES ('70', 'admin', 2)");
                stmt.executeUpdate("INSERT INTO results VALUES ('30', 'fulano', 1)");
                stmt.executeUpdate("INSERT INTO results VALUES ('30', 'beltrano', NULL)");
            }
           
            stmt.close();
            con.close();
        } catch (Exception ex) {
            exceptionMessage = step + ": " + ex.getMessage();
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
    }
}
