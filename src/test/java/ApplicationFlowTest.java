import org.json.JSONObject;
import org.junit.jupiter.api.*;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.SQLException;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
class ApplicationFlowTest {
    private static String PROJECT_USERNAME, PROJECT_PASSWORD, PROJECT_NAME, PROJECT_FLOW;
    private static String[] FILL_DATABASE_SCRIPTS, EMPTY_DATABASE_SCRIPTS;
    private static BlueriqApi blueriqApi;
    private static Database database;
    private static DatabaseConnector connector;
    private static JSONObject session;

    // Runs before executing the tests
    @BeforeAll
    static void init() throws IOException, InterruptedException, SQLException {
        setDbConfig();

        setApiConfig();

        initializeProject();

        emptyDatabase();
    }

    // Runs after all tests are finished
    @AfterAll
    static void close() throws IOException, InterruptedException, SQLException {
        connector.closeConnection();
        blueriqApi.sessionLogout();
    }

    // Sets all the database configuration
    private static void setDbConfig() throws SQLException {
        final String DB_URI = System.getenv("DB_URI");
        final String DB_USER = System.getenv("DB_USER");
        final String DB_PASSWORD = System.getenv("DB_PASSWORD");

        FILL_DATABASE_SCRIPTS = new String[] {
                System.getenv("H2_COMMENTS_SQL_STORE_SCRIPT"),
                System.getenv("H2_PROCESS_SQL_STORE_SCRIPT"),
                System.getenv("H2_REPORTING_SQL_STORE_SCRIPT"),
                System.getenv("H2_TRACE_SQL_STORE_SCRIPT")
        };

        EMPTY_DATABASE_SCRIPTS = new String[] {
                System.getenv("H2_COMMENTS_SQL_STORE_DROP_SCRIPT"),
                System.getenv("H2_PROCESS_SQL_STORE_DROP_SCRIPT"),
                System.getenv("H2_REPORTING_SQL_STORE_DROP_SCRIPT"),
                System.getenv("H2_TRACE_SQL_STORE_DROP_SCRIPT")
        };

        connector = new DatabaseConnector(DB_URI, DB_USER, DB_PASSWORD);
        database = new Database(connector);
    }

    // Sets all the API configuration
    private static void setApiConfig() {
        final String API_URI = System.getenv("API_URI");
        PROJECT_USERNAME = System.getenv("PROJECT_USERNAME");
        PROJECT_PASSWORD = System.getenv("PROJECT_PASSWORD");
        PROJECT_NAME = System.getenv("PROJECT_NAME");
        PROJECT_FLOW = System.getenv("PROJECT_FLOW");

        blueriqApi = new BlueriqApi(API_URI);
    }

    // Initialized the project
    private static void initializeProject() throws IOException, InterruptedException {
        blueriqApi.initializeProject(
                PROJECT_USERNAME,
                PROJECT_PASSWORD,
                PROJECT_NAME,
                PROJECT_FLOW
        );
    }

    // Empties the database
    private static void emptyDatabase() throws FileNotFoundException {
        database.runDatabaseScripts(EMPTY_DATABASE_SCRIPTS);
        database.runDatabaseScripts(FILL_DATABASE_SCRIPTS);
    }

    @Test
    @Order(1)
    void createApplication() throws IOException, InterruptedException {
        session = blueriqApi.loadSession();

        blueriqApi.sessionStartFlow(PROJECT_FLOW);

        blueriqApi.sessionEventPost(session, "P247_NewApplication_1");
        session = blueriqApi.loadSession();

        Assertions.assertEquals("P520",
                session.getJSONArray("elements").getJSONObject(0).getString("key").split("-")[0]);
    }

    @Test
    @Order(2)
    void submitApplication() throws IOException, InterruptedException {
        blueriqApi.sessionEventPost(session, "P520_Submit_1");
        session = blueriqApi.loadSession();

        Assertions.assertEquals("P247",
                session.getJSONArray("elements").getJSONObject(0).getString("key").split("-")[0]);
    }

    @Test
    @Order(3)
    void submitVerificationTask() throws IOException, InterruptedException {
        blueriqApi.sessionEventPost(session, "P247_Start_1");
        session = blueriqApi.loadSession();

        blueriqApi.sessionEventPost(session, "P418_Submit_1");
        session = blueriqApi.loadSession();

        Assertions.assertEquals("P247",
                session.getJSONArray("elements").getJSONObject(0).getString("key").split("-")[0]);
    }

    @Test
    @Order(4)
    void submitPepCheckTask() throws IOException, InterruptedException {
        blueriqApi.sessionEventPost(session, "P247_Start_1");
        session = blueriqApi.loadSession();

        blueriqApi.sessionEventPost(session, "P835_Submit_1");
        session = blueriqApi.loadSession();

        Assertions.assertEquals("P247",
                session.getJSONArray("elements").getJSONObject(0).getString("key").split("-")[0]);
    }

    @Test
    @Order(5)
    void submitEmploymentVerificationTask() throws IOException, InterruptedException {
        blueriqApi.sessionEventPost(session, "P247_Start_1");
        session = blueriqApi.loadSession();

        blueriqApi.sessionEventPost(session, "P95_Submit_1");
        session = blueriqApi.loadSession();

        Assertions.assertEquals("P247",
                session.getJSONArray("elements").getJSONObject(0).getString("key").split("-")[0]);
    }

    @Test
    @Order(6)
    void submitCreditCheckTask() throws IOException, InterruptedException {
        blueriqApi.sessionEventPost(session, "P247_Start_1");
        session = blueriqApi.loadSession();

        blueriqApi.sessionEventPost(session, "P391_Submit_1");
        session = blueriqApi.loadSession();

        Assertions.assertEquals("P247",
                session.getJSONArray("elements").getJSONObject(0).getString("key").split("-")[0]);
    }

    @Test
    @Order(7)
    void submitCheckForNegativeNewsTask() throws IOException, InterruptedException {
        blueriqApi.sessionEventPost(session, "P247_Start_1");
        session = blueriqApi.loadSession();

        blueriqApi.sessionEventPost(session, "P488_Submit_1");
        session = blueriqApi.loadSession();

        Assertions.assertEquals("P247",
                session.getJSONArray("elements").getJSONObject(0).getString("key").split("-")[0]);
    }

    @Test
    @Order(8)
    void submitCheckForCompanyOwnershipTask() throws IOException, InterruptedException {
        blueriqApi.sessionEventPost(session, "P247_Start_1");
        session = blueriqApi.loadSession();

        blueriqApi.sessionEventPost(session, "P571_Submit_1");
        session = blueriqApi.loadSession();

        Assertions.assertEquals("P247",
                session.getJSONArray("elements").getJSONObject(0).getString("key").split("-")[0]);
    }


    @Test
    @Order(9)
    void submitCheckForLawsuitsTask() throws IOException, InterruptedException {
        blueriqApi.sessionEventPost(session, "P247_Start_1");
        session = blueriqApi.loadSession();

        blueriqApi.sessionEventPost(session, "P383_Submit_1");
        session = blueriqApi.loadSession();

        Assertions.assertEquals("P247",
                session.getJSONArray("elements").getJSONObject(0).getString("key").split("-")[0]);
    }

    @Test
    @Order(10)
    void submitApplicationEvaluationTask() throws IOException, InterruptedException, SQLException {
        blueriqApi.sessionEventPost(session, "P247_Start_1");
        session = blueriqApi.loadSession();

        blueriqApi.sessionEventPost(session, "P103_Submit_1");
        session = blueriqApi.loadSession();

        Assertions.assertEquals("P247",
                session.getJSONArray("elements").getJSONObject(0).getString("key").split("-")[0]);

        Snapshot snapshot = new Snapshot(database);
        snapshot.createSnapshots(new File(System.getProperty("user.dir") + System.getenv("SNAPSHOT_PATH_URI")).toString());
    }

    @Test
    @Order(11)
    void submitGenerateAgreementTask() throws IOException, InterruptedException {
        blueriqApi.sessionEventPost(session, "P247_Start_1");
        session = blueriqApi.loadSession();

        blueriqApi.sessionEventPost(session, "P835_CloseApplication_1");
        session = blueriqApi.loadSession();

        Assertions.assertEquals("P247",
                session.getJSONArray("elements").getJSONObject(0).getString("key").split("-")[0]);
    }
}
