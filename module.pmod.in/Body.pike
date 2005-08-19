//!

import Public.SOAP;
import Public.Parser.XML2;
import .Constants;

private string encodingStyle = Encoding.Constants.SOAP_ENCODING_URI;
private array(BodyElement) elements = ({});

void add_element(BodyElement e)
{
  elements+=({e});
}

array(BodyElement) get_elements()
{
  return elements;
}

Node render_body()
{
  Node b = new_node("Body");

  b->add_ns(SOAP_NAMESPACE_URI, "SOAP-ENV");
  b->add_ns(encodingStyle, "SOAP-ENC");
  b->set_ns("SOAP-ENV");
  b->set_ns_attribute("encodingStyle", "SOAP-ENV", encodingStyle);
  foreach(get_elements(), BodyElement e)
    b->add_child(e->render_element());

  return b;
}

