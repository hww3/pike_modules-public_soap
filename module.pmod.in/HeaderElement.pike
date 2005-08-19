//!

import Public.Parser.XML2;
import Public.SOAP;
inherit Element;

private int mustUnderstand;
private string actor;


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
  if(!ns || !strlen(ns))
  {
    error("set_element(): all header elements must be namespace qualified.\n");
  }

  ::set_element(e);
}

//! returns a copy of the element node, properly configured with any SOAP 
//! attributes.
Node render_element()
{
  Node e = ::render_element();

  if(actor)
    e->set_ns_attribute("actor", "SOAP-ENV", actor);

  if(mustUnderstand)
    e->set_ns_attribute("mustUnderstand", "SOAP-ENV", (string)mustUnderstand);

  return e;
}
