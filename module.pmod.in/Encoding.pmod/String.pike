inherit .Type;

import Public.Parser.XML2;
import .Constants;

string type="STRING";

string contents;

void set(string s)
{
  contents = s;
}

Node encode(Node b)
{
  Node n = b->add_child(new_node(name));

  if(ns) n->add_ns(ns, prefix);

  n->set_content(contents);
  n->set_attribute("xsi:type", "BODY-ENC:string");
  return n;
}

void decode(Node n)
{
  contents = n->get_text();
  name = n->get_node_name();
}

mixed get_value()
{
  return contents;
}
