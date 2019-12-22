import org.json.JSONArray;
import org.json.JSONObject;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public class BlueriqApi {
    private String baseUrl;
    private String sessionId;
    private String cookie;
    private String token;
    private HttpClientHelper httpClientHelper;

    // Constructor
    public BlueriqApi(String apiUrl) {
        this.baseUrl = apiUrl + "/runtime/server/api/v2";
        this.httpClientHelper = new HttpClientHelper();
    }

    // Initializes the project by logging in the user and starting the project
    public void initializeProject(
            String username,
            String password,
            String project,
            String flow
    ) throws IOException, InterruptedException {
        // Puts the login data in a HashMap
        Map<Object, Object> loginData = new HashMap<>();
        loginData.put("username", username);
        loginData.put("password", password);

        // Puts the request headers in a HashMap
        Map<String, String> requestHeaders = new HashMap<>();
        requestHeaders.put("Content-Type", "application/x-www-form-urlencoded");

        // Sends a HTTP POST request with the login data to login the user, and extracts the cookie out of the response headers
        this.cookie = httpClientHelper.postForm(this.baseUrl, "/login", loginData, requestHeaders)
                .headers()
                .allValues("set-cookie")
                .get(0);

        // Puts the extracted cookie in the request headers
        requestHeaders.put("Cookie", this.cookie);

        // Puts the project data in a HashMap
        Map<Object, Object> projectData = new HashMap<>();
        projectData.put("project", project);
        projectData.put("flow", flow);

        // Sends a HTTP POST request to start the project
        String response = httpClientHelper.postForm(this.baseUrl ,"/start", projectData, requestHeaders).body();

        // Parses the response to a JSONObject and extracts the sessionId out of it
        this.sessionId = new JSONObject(response).getString("sessionId");
    }

    // Logs out the user and closes all the sessions
    public void sessionLogout() throws IOException, InterruptedException {
        // Puts the request headers in a HashMap
        Map<String, String> requestHeaders = new HashMap<>();
        requestHeaders.put("Content-Type", "application/json");
        requestHeaders.put("Cookie", this.cookie);
        requestHeaders.put("X-CSRF-Token", this.token);

        // Sends a HTTP POST request to logout the user
        httpClientHelper.postRequest(this.baseUrl, "/logout", "", requestHeaders).body();
    }

    // Loads the session information
    public JSONObject loadSession() throws IOException, InterruptedException {
        // Puts the request headers in a HashMap
        Map<String, String> requestHeaders = new HashMap<>();
        requestHeaders.put("Content-Type", "application/json");
        requestHeaders.put("Cookie", this.cookie);

        // Sends a HTTP POST request to load the session
        String response = httpClientHelper.postRequest(this.baseUrl, "/session/" + this.sessionId + "/load","", requestHeaders).body();

        // Parses the response of type String to a JSONObject
        JSONObject responseToJsonObject = new JSONObject(response);
        // Gets the CSRF-Token out of the response
        this.token = responseToJsonObject.getString("csrfToken");

        // Returns the response
        return responseToJsonObject;
    }

    // Starts a flow
    public void sessionStartFlow(String flow) throws IOException, InterruptedException {
        // Puts the request headers in a HashMap
        Map<String, String> requestHeaders = new HashMap<>();
        requestHeaders.put("Content-Type", "application/json");
        requestHeaders.put("Cookie", this.cookie);
        requestHeaders.put("X-CSRF-Token", this.token);

        // Sends a HTTP POST request to start the flow
        httpClientHelper.postRequest(this.baseUrl, "/session/" + this.sessionId + "/flow/" + flow, "", requestHeaders).body();
    }

    // Sends a user event with the payload as request body
    public void sessionEventPost(JSONObject session, String elementKey) throws IOException, InterruptedException {
        // Puts the request headers in a HashMap
        Map<String, String> requestHeaders = new HashMap<>();
        requestHeaders.put("Content-Type", "application/json");
        requestHeaders.put("Cookie", this.cookie);
        requestHeaders.put("X-CSRF-Token", this.token);

        // Creates the payload and stores the result in a String
        String payload = createPayload(session, elementKey);

        // Sends a HTTP POST request to the given endpoint and with the payload as the request body
        httpClientHelper.postRequest(this.baseUrl, "/session/" + this.sessionId + "/event", payload, requestHeaders).body();
    }

    // Creates the payload object
    private String createPayload(JSONObject session, String elementKey) {
        // Extracts the elements out of the JSONObject: session
        JSONArray elements = session.getJSONArray("elements");

        // Creates a new JSONObject: payload
        JSONObject payload = new JSONObject();
        // Puts the elementKey inside the payload object
        payload.put("elementKey", elementKey);

        // Creates a new JSONArray, which stores the field objects, created by the createFieldObjects method
        JSONArray fieldObjects = createFieldObjects(elements);

        // Puts the JSONArray: fieldObjects inside the JSONObject: payload
        payload.put("fields", fieldObjects);

        // Parses the payload to a String and returns it
        return payload.toString();
    }

    // Creates the field objects
    private JSONArray createFieldObjects(JSONArray elements) {
        // Creates a new JSONArray: fieldObjects
        JSONArray fieldObjects = new JSONArray();

        // Iterates through all the elements
        for (int i = 0; i < elements.length(); i++) {
            // Creates a new JSONObject: element
            JSONObject element = elements.getJSONObject(i);

            // If the element is of type field, then run the code below
            if (element.getString("type").equals("field")){
                // Creates a new JSONObject, which stores the functionalKey and the values
                JSONObject field = new JSONObject();
                // Creates a new JSONArray, which stores the values
                JSONArray values = new JSONArray();

                // Puts the functionalKey in the JSONObject: field
                field.put("key", element.getString("functionalKey"));

                if (!element.getBoolean("required")) {
                    // If the field element is not required to be filled in, then put an empty value in the JSONArray: values
                    values.put("");
                } else if (!element.getJSONArray("values").isEmpty()) {
                    // Else, if there is an existing value in the element, then extract the first value and put it in the JSONArray: values
                    values.put(element.getJSONArray("values").get(0));
                } else if (element.getBoolean("hasDomain")) {
                    // Else, if there is an existing domain in the element, then extract the first value and put it in the JSONArray: values
                    values.put(element.getJSONArray("domain").getJSONObject(0).getString("value"));
                } else {
                    // Else, put default values in the JSONArray: values
                    switch (element.getString("dataType")) {
                        case "date":
                            // Puts a default date value in the JSONArray: values
                            values.put(System.getenv("DEFAULT_DATE_VALUE"));
                            break;
                        case "text":
                            // Puts a default text value in the JSONArray: values
                            values.put(System.getenv("DEFAULT_TEXT_VALUE"));
                            break;
                        case "field":
                            // Puts a default field value in the JSONArray: values
                            values.put(System.getenv("DEFAULT_FIELD_VALUE"));
                            break;
                        case "currency":
                            // Puts a default currency value in the JSONArray: values
                            values.put(System.getenv("DEFAULT_CURRENCY_VALUE"));
                            break;
                        case "integer":
                            // Puts a default integer value in the JSONArray: values
                            values.put(System.getenv("DEFAULT_INTEGER_VALUE"));
                            break;
                        default:
                            // If all of the above are false, then return null
                            return null;
                    }
                }
                // Puts the JSONArray: values in the JSONObject: field
                field.put("values", values);
                // Puts the JSONObject: field in the JSONArray: fieldObjects
                fieldObjects.put(field);
            }
        }

        // Returns the fieldObjects
        return fieldObjects;
    }
}
