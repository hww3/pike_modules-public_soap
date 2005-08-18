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
