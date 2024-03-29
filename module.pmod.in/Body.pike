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
    b->add_ns(encodingStyle, SOAP_ENCODING_PREFIX);

  b->set_ns(SOAP_NAMESPACE_PREFIX);

  if(encodingStyle)
    b->set_ns_attribute("encodingStyle", SOAP_NAMESPACE_PREFIX, encodingStyle);
  foreach(get_elements(), BodyElement elem)
    b->add_child(elem->render_element(b));

  return b;
}

void decode(Node n)
{
  if(n->get_node_name() == "Body" && n->get_ns() == SOAP_NAMESPACE_URI)
  {

    string key = search(n->get_nss(), SOAP_NAMESPACE_URI);
    mapping attrs;
    if(key)
    attrs = n->get_ns_attributes(key);

    if(attrs->encodingStyle)
    {
      encodingStyle = attrs->encodingStyle;
    }

    foreach(n->children(); int i; Node c)
    {
      werror("node: %O type: %O\n", c->get_node_name(), c->get_node_type());
      if(c->get_node_type() == Public.Parser.XML2.Constants.ELEMENT_NODE
           && c->get_node_name() == "Fault" && c->get_ns() ==
                Public.SOAP.Constants.SOAP_NAMESPACE_URI)
      {
         // we have a fault!
         add_element(Fault(c));
      }
      else if(c->get_node_type() == Public.Parser.XML2.Constants.ELEMENT_NODE)
      {
         add_element(BodyElement(c));
      }
    }

  }
  else error("invalid Body Node.\n");
}
