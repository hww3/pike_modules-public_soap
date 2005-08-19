int main()
{
object e = Public.SOAP.Envelope();                 
e->body = Public.SOAP.Body();                      
object v = Public.SOAP.Encoding.String("St");
v->contents="German";                              
object s = Public.SOAP.Encoding.Struct("sayHello");
s->elements=(["String_1":v]);                      
object be = Public.SOAP.BodyElement();             
be->set_element(s);                                
e->body->add_element(be);                          
write("REQUEST: " + (string)e->render_envelope()); 
write("\n\n");
object q = Protocols.HTTP.do_method("POST", 
"http://lepago.homeip.net:80/HelloLangJB4EAR/HelloLangJB4EJB/HelloLangEndpointPort", 
0, (["SOAPAction": "\"\"", "Content-Type": "text/xml"]), 0, 
(string)e->render_envelope());
write("RESPONSE: " + q->data());
 return 0;
}
