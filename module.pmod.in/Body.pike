//!

import Public.SOAP;
import Public.Parser.XML2;
import .Constants;

private string encodingStyle = Encoding.Constants.SOAP_ENCODING_URI;
private array(BodyElement) elements = ({});

void create(void|Node n)
{
  if(n)
    decode(n);
}

string get_encoding()
{
  return encodingStyle;
}

void add_element(BodyElement e)
{
  elements+=({e});
}

array(BodyElement) get_elements()
{
  return elements;
}

Node render_body(Node e)
{
  Node b = e->add_child(new_node("Body"));

  if(encodingStyle)
    b->add_ns(encodingStyle, "BODY-ENC");

  b->set_ns("SOAP-ENV");

  if(encodingStyle)
    b->set_ns_attribute("encodingStyle", "SOAP-ENV", encodingStyle);

  foreach(get_elements(), BodyElement e)
    b->add_child(e->render_element(b));

  return b;
}

void decode(Node n)
{
  werror("decode body\n");
  if(n->get_node_name() == "Body" && n->get_ns() == SOAP_NAMESPACE_URI)
  {

    string key = search(n->get_nss(), SOAP_NAMESPACE_URI);
    mapping attrs;
    if(key)
    attrs = n->get_ns_attributes(key);

    if(attrs->encodingStyle)
    {
      werror("setting encoding Style.\n"); 
      encodingStyle = attrs->encodingStyle;
    }

    foreach(n->children(); int i; Node c)
    {
      werror("node: %O type: %O\n", c->get_node_name(), c->get_node_type());
      if(c->get_node_type() == Public.Parser.XML2.Constants.ELEMENT_NODE)
      {
         add_element(BodyElement(c));
      }
    }

  }
  else error("invalid Body Node.\n");
}
