int main()
{
object c = Public.SOAP.RPCCall("getQuote");

c->set_result(Public.SOAP.RPCParameter("getQuoteResult", 
  Public.SOAP.Encoding.String, Public.SOAP.Encoding.Constants.RPCOUT));

c->set_endpoint("http://webservices.codingtheweb.com/bin/qotd");
c->set_call_ns("urn:xmethods-qotd");
c->set_soapaction("urn:xmethods-qotd#getQuote");
mixed e  =c();

write(e + "\n");
  return 0;
}

