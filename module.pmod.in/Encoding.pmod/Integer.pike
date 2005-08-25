inherit .Type;

import Public.Parser.XML2;
import .Constants;

string type="INTEGER";

int contents = UNDEFINED;

void set(int|string val)
{
  if(intp(val)) 
    value = val;
  else if(!sscanf(val, "%d", value))
  {
    error("invalid boolean value %s\n", (string)val);
  }
}

Node encode(Node b)
{
  Node n = b->add_child(new_node(name));

  if(ns) n->add_ns(ns, prefix);

  n->set_content((string)contents);
  n->set_attribute("xsi:type", "BODY-ENC:integer");
  return n;
}
