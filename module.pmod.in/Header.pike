//!

import Public.Parser.XML2;
import Public.SOAP;
import .Constants;

void create(void|Node n)
{
  if(n)
    decode(n);
}

private array(HeaderElement) elements = ({});

void add_element(HeaderElement e)
{
  elements+=({e});
}

array(HeaderElement) get_elements()
{
  return elements;
}

Node render_header(Node env)
{
  Node h = env->add_child(new_node("Header"));

  foreach(get_elements(), HeaderElement e)
    h->add_child(e->render_element(h));

  return h;
}


void decode(Node n)
{
  werror("decode header\n");
}

