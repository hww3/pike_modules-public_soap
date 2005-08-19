//!

import Public.Parser.XML2;
import Public.SOAP;
import .Constants;

private string encodingStyle = 0;

private string namespace = 0;
private string localname = 0;

private Encoding.Type element;

//!
void set_encodingStyle(string s)
{
  encodingStyle = s;
}

//!
void set_element(Encoding.Type e)
{
  element = e;
}

//! returns a copy of the element node, properly configured with any SOAP 
//! attributes.
Node render_element(Node b)
{
  if(!element)
  {
    error("render_element(): no element set.\n");
  }

  Node e = element->encode(b)->copy_list();

  if(encodingStyle)
    e->set_ns_attribute("encodingStyle", "ELEMENT-ENV", encodingStyle);
  
  return e;
}
