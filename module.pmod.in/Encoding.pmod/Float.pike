inherit .Type;

import Public.Parser.XML2;
import .Constants;

string type="FLOAT";

float contents;

void set(float|string val)
{
  if(floatp(val)) 
    contents = val;
  else if(!sscanf(val, "%f", contents))
  {
    error("invalid float value %s\n", (string)val);
  }
}

Node encode(Node b)
{
  Node n = b->add_child(new_node(name));

  if(ns) n->add_ns(ns, prefix);

  n->set_content(sprintf("%f", contents));
  n->set_attribute("xsi:type", "BODY-ENC:float");
  return n;
}

mixed get_value()
{
  return contents;
}

