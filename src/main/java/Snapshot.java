import java.io.File;
import java.nio.file.Path;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

public class Snapshot {
    private Database database;

    // Constructor
    public Snapshot(Database database) {
        this.database = database;
    }

    // Returns the table names
    private ResultSet getTables() throws SQLException {
        // Returns a ResultSet of all the table names
        return this.database.runQuery("SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='PUBLIC'");
    }

    // Transfers files to the given destination path
    private void transferFiles(File current, Path destination) {
        File[] files = current.listFiles();

        // Iterates through the files
        for (int i = 0; i < files.length; i ++) {
            // Changes the name of the folder
            files[i].renameTo(new File(destination + "\\" + files[i].getName()));
            // Deletes the old files
            files[i].delete();
        }
    }

    // Manages the files by transferring them across directories
    private void manageArchive(String rootPath) {
        // Creates file objects with the specified directory names
        File current = new File(rootPath + "\\current");
        File previous = new File(rootPath + "\\previous");
        File archive = new File(rootPath + "\\archive");
        File archiveSnapshot = new File(rootPath + "\\archive\\" + new Date().getTime());

        // Creates the directories
        current.mkdirs();
        previous.mkdirs();
        archive.mkdirs();
        archiveSnapshot.mkdirs();

        // If the length of the previous list is greater than zero, transfer the files to the archive directory
        if (previous.list().length > 0) {
            transferFiles(previous, archiveSnapshot.toPath());
        }

        // If the length of the current list is bigger than zero, transfer the files to the previous directory
        if (current.list().length > 0) {
            transferFiles(current, previous.toPath());
        }
    }

    // Creates the snapshots
    public void createSnapshots(String path) throws SQLException {
        // Calls the getTables method and stores the table names in a ResultSet
        ResultSet tables = getTables();
        // Calls the manageArchive method with the given path
        manageArchive(path);

        // While the cursor has a next, move the cursor forward one row from its current position in the ResultSet
        while(tables.next()) {
            // Gets the table name
            String table = tables.getString("TABLE_NAME");

            // Selects all columns from a table and writes the data from the database to a file
            this.database.runQuery("CALL CSVWRITE('" + path + "\\current\\SNAPSHOT_" + table + "_" + new Date().getTime() + ".csv', 'SELECT * FROM " + table + "')");
        }
    }
}
