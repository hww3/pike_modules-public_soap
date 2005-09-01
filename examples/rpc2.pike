int main()
{
object n = Public.SOAP.RPCParameter("topics", "string");
object m = Public.SOAP.RPCParameter("minLength", "double");
object l = Public.SOAP.RPCParameter("maxLength", "double");
object o = Public.SOAP.RPCParameter("fortune", "string");
object c = Public.SOAP.RPCCall("getFortune", ({n, m, l}), o);
c->set_endpoint("http://www.doughughes.net/WebServices/fortune/fortune.cfc");
//c->set_call_ns("http://fortune.WebServices");
mixed e  =c(UNDEFINED, UNDEFINED, UNDEFINED);

write(e + "\n");
  return 0;
}

