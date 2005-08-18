//!

import Public.Parser.XML2;

private string encodingStyle = 0;
private int mustUnderstand = 0;
private string actor = 0;


private string namespace = 0;
private string localname = 0;

private Node element;

//!
void set_encodingStyle(string s)
{
  encodingStyle = s;
}

//!
void set_mustUnderstand(int m)
{
  mustUnderstand = m;
}

//!
void set_actor(string a)
{
  actor = a;
}

//!
void set_element(Node e)
{
  string ns = e->get_ns();
  if(!ns || !strlen(ns)
  {
    error("set_element(): all header elements must be namespace qualified.\n");
  }

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

  if(actor)
    e->set_ns_attribute("actor", "SOAP-ENV", actor);

  if(mustUnderstand)
    e->set_ns_attribute("mustUnderstand", "SOAP-ENV", mustUnderstand);

  if(encodingStyle)
    e->set_ns_attribute("encodingStyle", "SOAP-ENV", encodingStyle);
  
  return e;
}
