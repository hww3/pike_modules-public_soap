//!

import Public.Parser.XML2;
import .Constants;

private array(HeaderElement) elements = ({});

void add_element(HeaderElement e)
{
  elements+=({e});
}

array(HeaderElement) get_elements()
{
  return elements;
}

Node render_header()
{
  Node h = new_node("Header");

  h->add_ns(SOAP_NAMESPACE_URI, "SOAP-ENV");

  foreach(get_elements(), HeaderElement e)
    h->add_child(e->render_element());

  return h;
}
