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
    public string login_url = "/index.php?page=api&module=auth&action=login";
    public string login_method = "POST";
    public string login_request = "";
    public string login_response = "";
    
    static HttpClient myAppHTTPClient = new HttpClient();

    public LoginModel(){
        dynamic body = new JObject();
        body.CompanyID = "DINOS";
        body.DivisionID = "DEFAULT";
        body.DepartmentID = "DEFAULT";
        body.EmployeeID = "Demo";
        body.EmployeePassword = "Demo";
        body.language = "english";

        doRequest(this.login_method, this.login_url, this.login_request = body.ToString()).ContinueWith(t => login_response = t.Result);
    }

    public async Task<string> doRequest(string type, string getParams, string body){
        HttpRequestMessage httpRequestMessage = new HttpRequestMessage();
        string result = "";
        Console.WriteLine("Start API Request");        
        try
        {
            var data = new StringContent(body, System.Text.Encoding.UTF8, "application/json");
            var client = new HttpClient();
            var response = await client.PostAsync("http://localhost/EnterpriseUniversalAPI" + getParams, data);
            result = response.Content.ReadAsStringAsync().Result;
            dynamic resObj = JObject.Parse(result);
            Console.WriteLine(resObj);
            //Console.WriteLine(result);            
            //Console.WriteLine(response.StatusCode);
            /*
            HttpResponseMessage responseMessage = await myAppHTTPClient.PostAsync(requestUrl, httpRequestMessage.Content);
            HttpContent content = responseMessage.Content;
            string message = await content.ReadAsStringAsync();*/
            RedirectToPage();
        }
        catch (HttpRequestException exception)
        {
            Console.WriteLine("An HTTP request exception occurred. {0}", exception.Message);
        }
        Console.WriteLine("End API Request");
        return result;
    }
}
