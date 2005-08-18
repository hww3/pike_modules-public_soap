//!

import Public.Parser.XML2;

private array(HeaderElement) elements = ({});

void add_element(HeaderElement e)
{
  elements+=({e});
}

array(HeaderElement) get_elements()
{
  return elements;
}
