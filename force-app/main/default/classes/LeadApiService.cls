public class LeadApiService {
    private static String instanceUrl = ''; // Dynamically set instance URL
    private static String authToken = '';
    private static String Base_Url = 'https://curious-badger-2m1vaq-dev-ed.trailblaze.my.salesforce.com/services/apexrest/LeadManipulation/';

    private static void setInstanceUrlAndToken() {
        if (String.isEmpty(instanceUrl) || String.isEmpty(authToken)) {
            Map<String, Object> authDetails = LeadApiUtility.getAuthDetails(); // Fetch both token and instance URL
            authToken = (String) authDetails.get('access_token');
            instanceUrl = (String) authDetails.get('instance_url');
        }
    }

    // POST Request - Create Lead
    public static HttpResponse createLead(String leadJson) {
        setInstanceUrlAndToken();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(Base_Url);
        req.setMethod('POST');
        req.setHeader('Authorization', 'Bearer ' + authToken);
        req.setHeader('Content-Type', 'application/json');
        req.setBody(leadJson);

        Http http = new Http();
        return http.send(req);
    }

    // PATCH Request - Update Lead partially
    public static HttpResponse updateLeadPartial(String leadId, String leadJson) {
        setInstanceUrlAndToken();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(Base_Url + leadId);
        req.setMethod('PATCH');
        req.setHeader('Authorization', 'Bearer ' + authToken);
        req.setHeader('Content-Type', 'application/json');
        req.setBody(leadJson);

        Http http = new Http();
        return http.send(req);
    }

    // PUT Request - Replace Lead
    public static HttpResponse replaceLead(String leadId, String leadJson) {
        setInstanceUrlAndToken();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(Base_Url + leadId);
        req.setMethod('PUT');
        req.setHeader('Authorization', 'Bearer ' + authToken);
        req.setHeader('Content-Type', 'application/json');
        req.setBody(leadJson);

        Http http = new Http();
        return http.send(req);
    }

    // DELETE Request - Delete Lead
    public static HttpResponse deleteLead(String leadId) {
        setInstanceUrlAndToken();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(Base_Url + leadId);
        req.setMethod('DELETE');
        req.setHeader('Authorization', 'Bearer ' + authToken);

        Http http = new Http();
        return http.send(req);
    }

    // GET Request - Retrieve Lead
    public static HttpResponse getLead(String leadId) {
        setInstanceUrlAndToken();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(Base_Url + leadId);
        req.setMethod('GET');
        req.setHeader('Authorization', 'Bearer ' + authToken);

        Http http = new Http();
        HttpResponse response = http.send(req);

        // Handle the response
        String responseBody = response.getBody();
        if (response.getStatusCode() == 200) {
            // Assuming the response is in JSON format
            Map<String, Object> leadData = (Map<String, Object>) JSON.deserializeUntyped(responseBody);
            System.debug('Lead Data: ' + leadData);
        } else {
            // Handle errors
            System.debug('Error: ' + response.getStatusCode() + ' - ' + response.getBody());
        }

        return response;
    }
}


// Example usage:

// String leadId = '00Q5g00000XYZ123';  // Replace with actual Lead ID
// HttpResponse response = LeadApiService.getLead(leadId);
// System.debug('Status Code: ' + response.getStatusCode());
// System.debug('Response Body: ' + response.getBody());





// String leadJson = '{"FirstName":"Khan", "LastName":"Sameed", "Company":"CTI"}';
// HttpResponse response = LeadApiService.createLead(leadJson);
// System.debug('Status Code: ' + response.getStatusCode());
// System.debug('Response Body: ' + response.getBody());






// String leadId = '00Q5g00000XYZ123';  // Replace with actual Lead ID
// String leadJson = '{"Company":"Updated CTI"}';
// HttpResponse response = LeadApiService.updateLeadPartial(leadId, leadJson);
// System.debug('Status Code: ' + response.getStatusCode());
// System.debug('Response Body: ' + response.getBody());



// String leadId = '00Q5g00000XYZ123';  // Replace with actual Lead ID
// String leadJson = '{"FirstName":"Jane", "LastName":"Doe", "Company":"Acme Corp Updated"}';
// HttpResponse response = LeadApiService.replaceLead(leadId, leadJson);
// System.debug('Status Code: ' + response.getStatusCode());
// System.debug('Response Body: ' + response.getBody());




// String leadId = '00Q5g00000XYZ123';  // Replace with actual Lead ID
// HttpResponse response = LeadApiService.deleteLead(leadId);
// System.debug('Status Code: ' + response.getStatusCode());
// System.debug('Response Body: ' + response.getBody());