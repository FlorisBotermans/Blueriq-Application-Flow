import java.io.IOException;
import java.net.URI;
import java.net.URLEncoder;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.util.Map;

public class HttpClientHelper {
    private final String userAgent = "Java 13 HttpClient Bot";

    private HttpClient httpClient = HttpClient.newBuilder()
            .version(HttpClient.Version.HTTP_2)
            .build();

    public HttpResponse<String> postRequest(
            String baseUrl,
            String uri,
            String json,
            Map<String, String> requestHeaders
    ) throws IOException, InterruptedException {
        HttpRequest.Builder builder = HttpRequest.newBuilder()
                .POST(HttpRequest.BodyPublishers.ofString(json))
                .uri(URI.create(baseUrl + uri))
                .setHeader("User-Agent", userAgent);

        fillHeaders(builder, requestHeaders);

        return httpClient.send(builder.build(), HttpResponse.BodyHandlers.ofString());
    }

    public HttpResponse<String> postForm(
            String baseUrl,
            String uri,
            Map<Object, Object> formData,
            Map<String, String> requestHeaders
    ) throws IOException, InterruptedException {
        HttpRequest.Builder builder = HttpRequest.newBuilder()
                .POST(buildFormData(formData))
                .uri(URI.create(baseUrl + uri))
                .setHeader("User-Agent", userAgent);

        fillHeaders(builder, requestHeaders);

        return httpClient.send(builder.build(), HttpResponse.BodyHandlers.ofString());
    }

    private HttpRequest.BodyPublisher buildFormData(Map<Object, Object> formData) {
        var builder = new StringBuilder();

        for (Map.Entry<Object, Object> entry : formData.entrySet()) {
            if (builder.length() > 0) builder.append('&');
            builder.append(URLEncoder.encode(entry.getKey().toString(), StandardCharsets.UTF_8));
            builder.append('=');
            builder.append(URLEncoder.encode(entry.getValue().toString(), StandardCharsets.UTF_8));
        }

        return HttpRequest.BodyPublishers.ofString(builder.toString());
    }

    private void fillHeaders(HttpRequest.Builder builder, Map<String, String> requestHeaders) {
        requestHeaders.forEach(builder::header);
    }
}
