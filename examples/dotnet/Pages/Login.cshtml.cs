using System;
using System.Net.Http;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

public class LoginModel : PageModel {
    static HttpClient myAppHTTPClient = new HttpClient();

    public LoginModel(){
        dynamic body = new JObject();
        body.CompanyID = "DINOS";
        body.DivisionID = "DEFAULT";
        body.DepartmentID = "DEFAULT";
        body.EmployeeID = "Demo";
        body.EmployeePassword = "Demo";
        body.language = "english";

        this.doRequest("POST", "/index.php?page=api&module=auth&action=login", body.ToString());
    }

    public async doRequest(string type, string getParams, string body){
        string firstName, lastName, email;
        string host = "https://google.com:443/";
        string pathname = "/";

        string requestUrl = host;

        HttpRequestMessage httpRequestMessage = new HttpRequestMessage();

        Console.WriteLine("Start API Request");        
        try
        {
            var data = new StringContent(json, Encoding.UTF8, "application/json");
            var client = new HttpClient();
            var response = await client.PostAsync("http://localhost/EnterpriseUniversalAPI" + getParams, new StringContent(body));
            string result = response.Content.ReadAsStringAsync().Result;
            dynamic resObj = JObject.Parse(result);
            Console.WriteLine(resObj);
            //Console.WriteLine(result);            
            //Console.WriteLine(response.StatusCode);
            /*
            HttpResponseMessage responseMessage = await myAppHTTPClient.PostAsync(requestUrl, httpRequestMessage.Content);
            HttpContent content = responseMessage.Content;
            string message = await content.ReadAsStringAsync();
            Console.WriteLine("The output from thirdparty is: {0}", message);*/
            RedirectToPage();
        }
        catch (HttpRequestException exception)
        {
            Console.WriteLine("An HTTP request exception occurred. {0}", exception.Message);
        }
        Console.WriteLine("End API Request");
    }
}
