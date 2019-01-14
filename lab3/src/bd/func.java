package bd;


import com.google.common.collect.SortedSetMultimap;
import com.google.common.collect.TreeMultimap;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;



public class func {
   
    
    static void Database(){
        Generator gen = new Generator();
        par param = new par();
        Statement st;
        String sql;
        ResultSet rs;
        SortedSetMultimap<String, Integer> tablesID = TreeMultimap.create();
        //multimap позволяющие просто работать со случаями когда один ключ и много значений у этого ключа
        //В отличии от конструкций вроде Map<K,Set<V>>, Multimap предоставляет ряд удобных функций для сокращения кода и упрощения алгоритмов.
        //метод, в котором несколько значений или объектов , которые связаны с одним ключом, 
        //но он возвращает отсортированный список объектов в соответствии с их естественным порядком без каких - либо повторяющихся пар ключ / значение
        Connection conn = getDBConnection(); //Создается обьект Statement
        //Объект Statement используется для выполнения SQL-запросов к БД
        //Интерфейс Statement предоставляет базовые методы для выполнения запросов и извлечения результатов
        try {

            String manuf, os, versionn, manufactures, modell, name_DLC, release_date= " ",per= " ", download_link, name_pr, name_t, period= " " ,datefr= " " ,dateto= " ", 
                    description, manufacturer, model, website, name_dev, name_game, language, date= " " , date2= " ", instructions, OS, rules;
            int cores, RAM, price, memory, bits, year_of_foundation, id_tournament_fk, id_dev_fk, id_game_fk,prize,
                    id_sys_fk, id_peg_fk, rating, price_game, id_OS_fk, id_CPU_fk, id_GPU_fk, id_mr_fk, id_or_fk, id_sr_fk, memoryy;
            //boolean paid;
            int frequency; 
          
           
            //--------------- tournament  ---------------
            st = conn.createStatement();
            for (int i = 0; i < param.size_for_tournament; i++) {
                name_t = gen.generateString(1, 5); 
                datefr= gen.generateDate("1940-01-01", "2018-11-11");
                dateto= gen.generateDate(datefr, "2019-11-11");
                prize= gen.generateInt(1, 15);
                rules= gen.generateString(1, 15);
                sql = "INSERT INTO tournament (name,rules,xprize, date_from, date_to)VALUES ('" + name_t + "','" +rules+ "','" +prize+ "','"+ datefr+ "','" +dateto+  "');";
                st.executeUpdate(sql);
            }

            st.close();
           
            //--------------- tournament table primary keys  ---------------
            st = conn.createStatement();
            rs = st.executeQuery("SELECT id_tournament FROM tournament;");
            while (rs.next())
                tablesID.get("id_tournament").add(rs.getInt("id_tournament"));
            rs.close();
            st.close();  
            
             
           
            
             
            
            //--------------- developer  ---------------
            st = conn.createStatement();
            for (int i = 0; i < param.size_for_developer; i++) {
                name_dev = gen.generateString(1, 15);
                year_of_foundation = gen.generateInt(1900, 2018);
                website = gen.generateString(1, 15);
                sql = "INSERT INTO developer (name, year_of_foundation, website)VALUES ('"+ name_dev + "','" + year_of_foundation + "','"+ website + "');";
                st.executeUpdate(sql);
            }

            st.close();
           
            //--------------- developer table primary keys ---------------
            st = conn.createStatement();
            rs = st.executeQuery("SELECT id_developer FROM developer;");
            while (rs.next())
                tablesID.get("id_developer").add(rs.getInt("id_developer"));
            rs.close();
            st.close();  
            
     
            
            //--------------- OS ---------------
            st = conn.createStatement();
            for (int i = 0; i < param.size_for_OS; i++) {
                manuf = gen.generateString(0, 20);
                versionn = gen.generateString(0, 20);
                bits = gen.generateInt(1, 50);
       
                sql = "INSERT INTO OS(manufacturer, version, bits)" +
                        " VALUES ('"
                        + manuf + "','" + versionn + "','" + bits+ "');";
                st.executeUpdate(sql);
            }

            st.close();
            //--------------- OS table primary keys  ---------------
            st = conn.createStatement();
            rs = st.executeQuery("SELECT id_os FROM OS;");
            while (rs.next())
                tablesID.get("id_OS").add(rs.getInt("id_os"));
            rs.close();
            st.close(); 
           
            
            
            
            //--------------- DLC ---------------
            /*  st = conn.createStatement();
            for (int i = 0; i < param.size_for_DLC; i++) {
                name_DLC = gen.generateString(1, 15); 
                release_date= gen.generateDate("1940-01-01", "2018-11-11");
                price= gen.generateInt(1, 15);
                description= gen.generateString(1, 15);
                sql = "INSERT INTO DLC (name, price, release_date, description) VALUES ('" + name_DLC + "','" +price+ "','" +release_date+ "','" +description+"');";
                st.executeUpdate(sql);
            }
            st.close();
           
            //--------------- DLC table primary keys  ---------------
            st = conn.createStatement();
            rs = st.executeQuery("SELECT id_dlc FROM DLC;");
            while (rs.next())
                tablesID.get("id_dlc").add(rs.getInt("id_dlc"));
            rs.close();
            st.close();  */
            
            //--------------- CPU table generating ---------------
            st = conn.createStatement();
            for (int i = 0; i < param.size_for_CPU; i++) {
                manufactures = gen.generateString(1, 10); 
                modell = gen.generateString(1, 10);   
                cores = gen.generateInt(1, 10);   
                RAM = gen.generateInt(1, 10); 
                frequency = gen.generateInt(1, 10);   
       
                //Результатом оператора INSERT, UPDATE, или DELETE является модификация одной или более колонок 
                //в нуле или более строках таблицы.
                sql = "insert into CPU (manufacturer, model, cores, frequency, RAM) values('"  
                        + manufactures + "','" + modell+ "'," + cores+ "," + frequency+ "," + RAM +");";
                st.executeUpdate(sql);
                //метод executeUpdate. оператор завершен сразу после выполнения оператора
            }
            st.close();
           
            //--------------- CPU  primary keys --------------
            st = conn.createStatement();
            //метод executeQuery возвращает единственный набор данных, оператор завершен,
            //если считаны все строки соответствующего объекта
            rs = st.executeQuery("SELECT id_CPU FROM CPU;");//считывание строк
            while (rs.next())
                tablesID.get("id_CPU").add(rs.getInt("id_cpu"));
            rs.close();
            st.close();  
            

            
            //--------------- GPU table ---------------
            st = conn.createStatement();
            for (int i = 0; i < param.size_for_GPU; i++) {
                manufacturer = gen.generateString(1, 15);
                model = gen.generateString(1, 15);
                memory = gen.generateInt(1, 15);
                sql = "INSERT INTO GPU(manufacturer, model, memory)" 
                        + " VALUES ('" + manufacturer + "','" + model + "'," +memory+ ");";
                st.executeUpdate(sql);
            }

            st.close();
          
            
            //--------------- GPU table primary keys ---------------
            st = conn.createStatement();
            rs = st.executeQuery("SELECT id_GPU FROM GPU;");
            while (rs.next())
                tablesID.get("id_GPU").add(rs.getInt("id_gpu"));
            rs.close();
            st.close(); 
          
             //--------------- minimal_requirements ---------------  
            st = conn.createStatement();
                for (int i = 0; i < param.size_for_OS; i++) {
                id_OS_fk = (int)(Math.floor(Math.random() * tablesID.get("id_OS").size()) + 1);
                id_CPU_fk = (int)(Math.floor(Math.random() * tablesID.get("id_CPU").size()) + 1);                   
                id_GPU_fk = (int)(Math.floor(Math.random() * tablesID.get("id_GPU").size()) + 1);                   
                    System.out.println(id_OS_fk + " "+id_CPU_fk + " "+ id_GPU_fk);     
                sql = "INSERT INTO minimal_requirements (id_OS, id_CPU,id_GPU)" +
                        " VALUES ('"
                        + id_OS_fk + "','" + id_CPU_fk + "','" + id_GPU_fk +  "');";
                st.executeUpdate(sql);
               
            }
            st.close();

            //--------------- minimal_requirements primary keys ---------------
            st = conn.createStatement();
            rs = st.executeQuery("SELECT id_minimal_requirements  FROM minimal_requirements ;");
            while (rs.next())
                tablesID.get("id_minimal_requirements").add(rs.getInt("id_minimal_requirements"));
            rs.close();
            st.close();
            
           //-------------optimal_requirements---------
            st = conn.createStatement();
                for (int i = 0; i < param.size_for_OS; i++) {
                id_OS_fk = (int)(Math.floor(Math.random() * tablesID.get("id_OS").size()) + 1);
                id_CPU_fk = (int)(Math.floor(Math.random() * tablesID.get("id_CPU").size()) + 1);                   
                id_GPU_fk = (int)(Math.floor(Math.random() * tablesID.get("id_GPU").size()) + 1);                   
                    System.out.println(id_OS_fk + " "+id_CPU_fk + " "+ id_GPU_fk);     
                sql = "INSERT INTO optimal_requirements (id_OS, id_CPU,id_GPU)" +
                        " VALUES ('"
                        + id_OS_fk + "','" + id_CPU_fk + "','" + id_GPU_fk +  "');";
                st.executeUpdate(sql);
               
            }
            st.close();

           //--------------- optimal_requirements primary keys ---------------
            st = conn.createStatement();
            rs = st.executeQuery("SELECT id_optimal_requirements  FROM optimal_requirements ;");
            while (rs.next())
                tablesID.get("id_optimal_requirements").add(rs.getInt("id_optimal_requirements"));
            rs.close();
            st.close();
           
           //---------------
            
             //--------------- system_requirements ---------------
              st = conn.createStatement();
                for (int i = 0; i < param.size_for_OS; i++) {
                os = gen.generateString(1,10);
                memoryy = gen.generateInt(1,10);
                id_mr_fk = (int)(Math.floor(Math.random() * tablesID.get("id_minimal_requirements").size()) + 1);
                id_or_fk = (int)(Math.floor(Math.random() * tablesID.get("id_optimal_requirements").size()) + 1);                   
                //id_ps_fk = (int)(Math.floor(Math.random() * tablesID.get("id_preinstalled_software").size()) + 1);
                
                        
                sql = "INSERT INTO system_requirements( OS, memory_space, id_minimal_requirements, id_optimal_requirements)" +
                        " VALUES ('"+ os+ "','" + memoryy + "','" + id_mr_fk +"','" + id_or_fk +  "');";
                st.executeUpdate(sql);
               
            }
            st.close();

            //--------------- system_requirements primary keys ---------------
            st = conn.createStatement();
            rs = st.executeQuery("SELECT id_system_requirements FROM system_requirements ;");
            while (rs.next())
                tablesID.get("id_system_requirements").add(rs.getInt("id_system_requirements"));
            rs.close();
            st.close();



            //--------------- preinstalled_software table ---------------

            st = conn.createStatement();
            for (int i = 0; i < param.size_for_preinstalled_software; i++) {
                name_pr = gen.generateString(1, 15);
                download_link = gen.generateString(1, 15);
                instructions = gen.generateString(1, 15);
                id_sr_fk = (int)(Math.floor(Math.random() * tablesID.get("id_system_requirements").size()) + 1);
                //System.out.println(name_pr + " " + download_link + " " + instructions);
                sql = "INSERT INTO preinstalled_software (name,download_link,instructions, id_system_requirements)" +
                        " VALUES ('"
                        + name_pr + "','" +download_link+ "','" +instructions + "','"+ id_sr_fk +"');";
                st.executeUpdate(sql);
            }

            st.close();

            //--------------- preinstalled_software table primary keys ---------------
            st = conn.createStatement();
            rs = st.executeQuery("SELECT id_preinstalled_software FROM \"preinstalled_software\";");
            while (rs.next())
                tablesID.get("id_preinstalled_software").add(rs.getInt("id_preinstalled_software"));
            rs.close();
            st.close();

            //--------------- game  ---------------
            st = conn.createStatement();
            for (int i = 0; i < param.size_for_developer; i++) {
                name_game = gen.generateString(1, 15);
                language = gen.generateString(1, 15);
                
                id_peg_fk = gen.generateInt(1,10);
                id_dev_fk = (int)((Math.random() * tablesID.get("id_developer").size()) + 1);
                id_sys_fk = (int)((Math.random() * tablesID.get("id_system_requirements").size()) + 1);
                id_tournament_fk = (int)((Math.random() * tablesID.get("id_tournament").size()) + 1);
                //id_DLC_fk = (int)((Math.random() * tablesID.get("id_DLC").size()) + 1);
                rating = gen.generateInt(1,10);
                date = gen.generateDate("1940-01-01", "2018-11-11");

                price_game = gen.generateInt(1,10);
              
                
                
                sql = "INSERT INTO game (name, price, release_date,rating, language,PEGI_rating,id_system_requirements, id_developer, id_tournament)"
                        + " VALUES ('"
                        + name_game + "','" + price_game + "','" + date + "','" + rating + "','" + language + "','" + id_peg_fk + "','" + id_sys_fk + "','" + id_dev_fk + "','" + id_tournament_fk +"');";
                st.executeUpdate(sql);
            }

            st.close();

            
            //--------------- game primary keys  ---------------
            st = conn.createStatement();
            rs = st.executeQuery("SELECT id_game FROM game;");
            while (rs.next())
                tablesID.get("id_game").add(rs.getInt("id_game"));
            rs.close();
            st.close();

            //--------------- DLC ---------------
            st = conn.createStatement();
            for (int i = 0; i < param.size_for_DLC; i++) {
                name_DLC = gen.generateString(1, 15);
                release_date= gen.generateDate("1940-01-01", "2018-11-11");
                price= gen.generateInt(1, 15);
                description= gen.generateString(1, 15);
                id_game_fk = (int)((Math.random() * tablesID.get("id_game").size()) + 1);
                sql = "INSERT INTO DLC (name, price, release_date, description, id_game) VALUES ('" + name_DLC + "','" +price+ "','" +release_date+ "','" +description+ "','" +id_game_fk+ "');";
                st.executeUpdate(sql);
            }
            st.close();

            //--------------- DLC table primary keys  ---------------
            st = conn.createStatement();
            rs = st.executeQuery("SELECT id_dlc FROM DLC;");
            while (rs.next())
                tablesID.get("id_dlc").add(rs.getInt("id_dlc"));
            rs.close();
            st.close();
            
            
        } catch (SQLException e) {
            Logger.getLogger(func.class.getName()).log(Level.SEVERE, null, e);
        }
    }


    private static Connection getDBConnection() { //подключиться к базе
        par param = new par();//копия 
        Connection dbConnection = null;

        try {
            Class.forName(param.DB_DRIVER);
        } catch (ClassNotFoundException e) {
            System.out.println(e.getMessage());
        }

        try {
            dbConnection = DriverManager.getConnection(
                    param.DB_CONNECTION, param.DB_USER, param.DB_PASSWORD); //

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }

        return dbConnection;
    }
}
