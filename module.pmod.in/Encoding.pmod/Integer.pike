inherit .Type;

import Public.Parser.XML2;
import .Constants;

string type="INTEGER";
string xsi_type = "integer";

int contents = UNDEFINED;

void set(int|string val)
{
  if(intp(val)) 
    contents = val;
  else if(!sscanf(val, "%d", contents))
  {
    error("invalid integer value %s\n", (string)val);
  }
}

Node encode(Node b)
{
  Node n = b->add_child(new_node(name));

  if(ns) n->add_ns(ns, prefix);

  n->set_content((string)contents);
  n->set_attribute("xsi:type", "BODY-ENC:" + xsi_type);
  return n;
}

mixed get_value()
{
  return contents;
}

