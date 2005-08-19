//!

import Public.Parser.XML2;
import Public.SOAP;
import .Constants;
import .Encoding.Constants;

Header header;
Body body;

Node render_envelope()
{
  Node e = new_node("Envelope");

  e->add_ns(SOAP_NAMESPACE_URI, "SOAP-ENV");
  e->add_ns(SOAP_XSI_URI, "xsi");
  e->add_ns(SOAP_XSD_URI, "xsd");
  e->set_ns("SOAP-ENV");
  
  if(header)
  {
    e->add_child(header->render_header());
  }

  if(!body) 
  {
    error("render_envelope(): a SOAP body is required.\n");
  }

  e->add_child(body->render_body());

  return e;
}

void decode(Node node)
{

}

Node encode()
{

}
