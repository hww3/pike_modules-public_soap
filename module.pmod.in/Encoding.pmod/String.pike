inherit .Type;

import Public.Parser.XML2;
import .Constants;

string type="STRING";

string contents;

Node encode()
{
  node n = new_node(name);

  if(ns) n->add_ns(ns, prefix);

  n->set_content(contents);
  n->set_attribute("xsi:type", "xs:string");
  return n;
}
