//!

import Public.Parser.XML2;

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

  foreach(get_elements(), BodyElement e)
    b->add_child(e->render_element());

  return b;
}

