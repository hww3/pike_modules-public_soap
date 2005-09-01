//!

import Public.Parser.XML2;
import Public.SOAP;
import .Constants;

private string encodingStyle = 0;

private string namespace = 0;
private string localname = 0;

private Encoding.Type element;

void create(void|Node n)
{
  if(n)
  {
    decode(n);
  }
}


//!
void set_encodingStyle(string s)
{
  encodingStyle = s;
}

Encoding.Type get_element()
{
  return element;
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

  Node r = b->parent();

  Node e = element->encode(b);

  if(encodingStyle)
    e->set_ns_attribute("encodingStyle", "ELEMENT-ENV", encodingStyle);

  foreach(element->get_namespaces(); int x; string element_ns)
  {

    int i = 1;
    int gns = 0;
    mapping nss =  r->get_nss();
    do
    {
      if(search(nss, "ens" + i)!= -1)
        gns = 1;
      i++;
    } while(!gns);

    r->add_ns(element_ns, "ens" + i);

    if(x == 0) e->set_ns("ens" + i);
  }
  return e;
}

void decode(Node n)
{
  element = Encoding.decode_data(n);  
}
