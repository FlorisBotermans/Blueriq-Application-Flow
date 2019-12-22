import org.apache.ibatis.jdbc.ScriptRunner;

import java.io.*;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Database{
    private Connection connection;
    private ScriptRunner scriptRunner;

    // Constructor
    public Database(DatabaseConnector connector) throws SQLException{
        // Establishes a new connection
        this.connection = connector.getConnection();
        // Creates a new script runner object with the connection
        this.scriptRunner = new ScriptRunner(this.connection);

        // Prevents the script runner to write in the console
        this.scriptRunner.setLogWriter(null);
        this.scriptRunner.setErrorLogWriter(null);
    }

    // Runs the sql scripts given in the parameters
    public void runDatabaseScripts(String[] sqlScripts) throws FileNotFoundException{
        // Iterates through the Array
        for (String sqlScript : sqlScripts) {
            // Creates a new reader object
            Reader reader = new BufferedReader(new FileReader(sqlScript));
            // The script runner runs the script with the provided reader
            this.scriptRunner.runScript(reader);
        }
    }

    // Runs a query given in the parameters
    public ResultSet runQuery(String query) throws SQLException{
        // Creates a new statement object
        Statement statement = this.connection.createStatement();
        // Executes the query and returns the ResultSet
        return statement.executeQuery(query);
    }
}
