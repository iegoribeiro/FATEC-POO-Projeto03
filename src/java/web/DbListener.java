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

    public static final String URL = "jdbc:sqlite:C:\\Users\\notebook-user\\Documents\\GitHub\\FATEC-POO-Projeto03\\SQLite\\quiz.db";    
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
                //INSERT INTO questions VALUES ('Pergunta?', 'CERTA', 'ERRADA', 'ERRADA OPCIONAL', CATEGORIA OPCIONAL);
                step = "Default questions creation";
                stmt.executeUpdate("INSERT INTO questions VALUES ('Normalmente, quantos litros de sangue uma pessoa tem?', 'Entre 4 a 6 litros.', 'Tem entre 2 a 4 litros.', 'Tem 7 litros', NULL)");
                stmt.executeUpdate("INSERT INTO questions VALUES ('Em média, quantos litros são retirados numa doação de sangue?', 'São retirados 450 mililitros', 'São retirados 0,5 litro', 'São retirados 1,5 litros', NULL)");
                stmt.executeUpdate("INSERT INTO questions VALUES ('De onde é a invenção do chuveiro elétrico?', 'Brasil', 'Inglaterra', 'França', NULL)");
                stmt.executeUpdate("INSERT INTO questions VALUES ('Qual o nome do presidente do Brasil que ficou conhecido como Jango?', 'João Goulart', 'Jânio Quadros', 'Getúlio Vargas', NULL)");
                stmt.executeUpdate("INSERT INTO questions VALUES ('Atualmente, quantos elementos químicos a tabela periódica possui?', '118', '109', '113', 2)");
                stmt.executeUpdate("INSERT INTO questions VALUES ('Qual o número mínimo de jogadores de um time numa partida de futebol?', '7', '11', '9', 1)");
                stmt.executeUpdate("INSERT INTO questions VALUES ('Quanto tempo a luz do Sol demora para chegar à Terra?', '8 minutos', '12 horas', '6 segundos', 2)");
                stmt.executeUpdate("INSERT INTO questions VALUES ('Qual a altura da rede de vôlei nos jogos masculino e feminino?', '2,43 m e 2,24 m', '2,45 m e 2,15 m', '1,8 m e 1,5 m', 1)");
                stmt.executeUpdate("INSERT INTO questions VALUES ('Em que ordem surgiram os modelos atômicos?', 'Dalton, Thomson, Rutherford, Rutherford-Bohr.', 'Rutherford-Bohr, Rutherford, Thomson, Dalton', 'Dalton, Thomson, Rutherford-Bohr, Rutherford', 2)");
                stmt.executeUpdate("INSERT INTO questions VALUES ('Em que período da pré-história o fogo foi descoberto?', 'Paleolítico', 'Idade Média', 'Neolítico', NULL)");
                stmt.executeUpdate("INSERT INTO questions VALUES ('Qual a montanha mais alta do Brasil?', 'Pico da Neblina', 'Monte Roraima', 'Monte Everest', NULL)");
                stmt.executeUpdate("INSERT INTO questions VALUES ('Qual a velocidade da luz?', 'Aproximadamente 300.000.000 (m/s)'', 'Aproximadamente 150.000.000 (m/s)', 'Aproximadamente 30.000.000 (m/s)', 2)");
                stmt.executeUpdate("INSERT INTO questions VALUES ('“Twenty past six”. Que horas são em inglês?', '6:20', '12:06', '12:54', NULL)");
                stmt.executeUpdate("INSERT INTO questions VALUES ('Quem é o autor de “O Príncipe”?', 'Maquiavel', 'Antoine de Saint-Exupéry', 'Rousseau', NULL)");
                stmt.executeUpdate("INSERT INTO questions VALUES ('Quantos graus são necessário para que dois ângulos sejam complementares?', '90', '45', '180', 2)");
                stmt.executeUpdate("INSERT INTO questions VALUES ('Se uma casa tem quatro lados e em cada canto tem um gato e cada gato vê três gatos, quantos gatos há na casa?', '4', '6', '3', 2)");
                stmt.executeUpdate("INSERT INTO questions VALUES ('Futebol: Qual seleção foi a campeã mundial de 2006?', 'Itália', 'França', 'Alemanha', 1)");
                stmt.executeUpdate("INSERT INTO questions VALUES ('Qual o nome do americano que é considerado o maior golfista de todos os tempos?', 'Tiger Woods', 'Jack Nicklaus', 'Arnold Palmer', 1)");
                stmt.executeUpdate("INSERT INTO questions VALUES ('Quem torce para o São Paulo é?', 'São Paulino', 'Bambi', 'Paulistano', 1)");
                stmt.executeUpdate("INSERT INTO questions VALUES ('Qual o maior vencedor de Grand Slam em simples da história?', 'Roger Federer', 'Rafael Nadal', 'Novak Djokovic', 1)");
                stmt.executeUpdate("INSERT INTO questions VALUES ('Qual o nadador americano recordista de medalhas de ouro nas Olimpíadas?', '´Michael phelps', 'Mark Spitz', 'César Cielo', 1)");
                stmt.executeUpdate("INSERT INTO questions VALUES ('Qual é o elemento mais abundante na Terra?', 'Hidrogênio', 'Oxigênio', 'Hélio', 2)");
                stmt.executeUpdate("INSERT INTO questions VALUES ('Qual destes países é transcontinental?', 'Rússia', 'Istambul', 'Groenlândia', NULL)");
                stmt.executeUpdate("INSERT INTO questions VALUES ('Qual é o nome da unidade de corrente elétrica?', 'Ampere', 'Ohm', 'Volt', 1)");
                stmt.executeUpdate("INSERT INTO questions VALUES ('Qual foi o humilhante placar sofrido pelo Santos contra o corinthians em 2005?', '7x1', '8x2', NULL, 1)");
                stmt.executeUpdate("INSERT INTO questions VALUES ('Qual o maior animal terrestre?', 'Elefante africano', 'Nhonho', 'Girafa', NULL)");
                stmt.executeUpdate("INSERT INTO questions VALUES ('Qual o tema do famoso discurso Eu Tenho um Sonho, de Martin Luther King?', 'Igualdade das raças', 'Justiça para os menos favorecidos', 'Intolerância religiosa', NULL)");
                stmt.executeUpdate("INSERT INTO questions VALUES ('Qual é a fórmula mais famosa de Albert Einstein?', 'E=MC2', 'P=mg', 'F=ma', 2)");
                stmt.executeUpdate("INSERT INTO questions VALUES ('Quantos mundiais tem o palmeiras?', 'Nenhum', '15', '75', 1)");
                stmt.executeUpdate("INSERT INTO questions VALUES ('Qual é o maior planeta do sistema solar?', 'Júpiter', 'Marte', 'Sol', NULL)");
                stmt.executeUpdate("INSERT INTO questions VALUES ('Os ornitorrincos são mamíferos: verdadeiro ou falso?', 'Verdade', 'Falso', NULL, NULL)");
                stmt.executeUpdate("INSERT INTO questions VALUES ('Que líder mundial ficou conhecida como “Dama de Ferro”?', 'Margaret Thatcher', 'Dilma Rousseff', 'Hillary Clinton', NULL)");
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
