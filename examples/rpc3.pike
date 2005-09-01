int main()
{
object o = Public.SOAP.RPCParameter("return", "string");
object c = Public.SOAP.RPCCall("getQuote", ({}), o);
c->set_endpoint("http://webservices.codingtheweb.com/bin/qotd");
c->set_call_ns("urn:xmethods-qotd");
c->set_soapaction("urn:xmethods-qotd#getQuote");
mixed e  =c();

write(e + "\n");
  return 0;
}

