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
}
