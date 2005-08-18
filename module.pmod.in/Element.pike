//!

import Public.Parser.XML2;

private string encodingStyle = 0;

private string namespace = 0;
private string localname = 0;

private Node element;

//!
void set_encodingStyle(string s)
{
  encodingStyle = s;
}

//!
void set_element(Node e)
{
  string ns = e->get_ns();

  namespace = ns;
  localname = e->get_node_name();
  element = e;
}

//! returns a copy of the element node, properly configured with any SOAP 
//! attributes.
Node render_element()
{
  if(!element)
  {
    error("render_element(): no element set.\n");
  }

  Node e = element->copy_list();

  e->add_ns(SOAP_ENV_URI, "SOAP-ENV");

  if(encodingStyle)
    e->set_ns_attribute("encodingStyle", "SOAP-ENV", encodingStyle);
  
  return e;
}
