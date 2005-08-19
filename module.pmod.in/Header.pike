//!

import Public.Parser.XML2;
import Public.SOAP;
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

Node render_header(Node e)
{
  Node h = e->add_child("Header");

  foreach(get_elements(), HeaderElement e)
    h->add_child(e->render_element());

  return h;
}
