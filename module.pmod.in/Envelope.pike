//!

import Public.Parser.XML2;
import Public.SOAP;
import .Constants;
import .Encoding.Constants;

Header header;
Body body;

void create(void|Node n)
{
  if(n)
    decode(n);
}

Node render_envelope()
{
  Node e = new_node("Envelope");

  e->add_ns(SOAP_NAMESPACE_URI, "SOAP-ENV");
  e->add_ns(SOAP_XSI_URI, "xsi");
  e->add_ns(SOAP_XSD_URI, "xsd");
  e->set_ns("SOAP-ENV");
  
  if(header)
  {
    header->render_header(e);
  }

  if(!body) 
  {
    error("render_envelope(): a SOAP body is required.\n");
  }

  body->render_body(e);

  return e;
}

void decode(Node node)
{
  // an envelope can consist of Header elements and Body elements.
  if(node->get_node_name() == "Envelope" && node->get_ns() == SOAP_NAMESPACE_URI)
  {
    foreach(node->children(); int i; Node n)
    {
      if(n->get_node_type() != Public.Parser.XML2.Constants.ELEMENT_NODE)
      {
        werror("got non element data.\n");
        continue;
      }
      else if(n->get_node_name() == "Header" && node->get_ns() == SOAP_NAMESPACE_URI)
      {
        header = Header(n);
      }
      else if(n->get_node_name() == "Body" && node->get_ns() == SOAP_NAMESPACE_URI)
      {
        body = Body(n);
      }
      else error("Invalid Envelope contents: %O\n", n->get_node_name()
    }
  }
  else error("Invalid Envelope element.\n");
}

Node encode()
{

}
