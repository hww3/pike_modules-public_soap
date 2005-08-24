int main()
{

  object n = Public.SOAP.RPCParameter("language", "string");  
  object o = Public.SOAP.RPCParameter("helo", "string"); 
  object c = Public.SOAP.RPCCall("sayHello", ({n}), o);
  object e = c("french"); 
  object q = Protocols.HTTP.do_method("POST", 
     "http://lepago.homeip.net:80/HelloLangJB4EAR/HelloLangJB4EJB/HelloLangEndpointPort", 
     0, (["SOAPAction": "\"\"", "Content-Type": "text/xml"]), 0, 
     (string)e->render_envelope()); 
  write("RESPONSE: " + q->data()); 

  return 0;
}

