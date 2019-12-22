import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnector{
    private String dbUri, dbUsername, dbPassword;
    private Connection dbConnection;

    // Constructor
    public DatabaseConnector(String dbUri, String dbUsername, String dbPassword){
        this.dbUri = dbUri;
        this.dbUsername = dbUsername;
        this.dbPassword = dbPassword;
    }

    // Creates a new database connection
    public Connection getConnection() throws SQLException{
        // Registers a new h2 driver to the DriverManager
        DriverManager.registerDriver(new org.h2.Driver());

        // Establishes a new connection with the given credentials
        dbConnection = DriverManager.getConnection(this.dbUri, this.dbUsername, this.dbPassword);

        // Returns the connection
        return dbConnection;
    }

    // Closes the database connection
    public void closeConnection() throws SQLException{
        dbConnection.close();
    }
}
