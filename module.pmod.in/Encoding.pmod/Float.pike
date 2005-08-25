inherit .Type;

import Public.Parser.XML2;
import .Constants;

string type="FLOAT";
string xsi_type = "float";

float contents;

void set(float|string val)
{
  if(floatp(val)) 
    contents = val;
  else if(!sscanf(val, "%f", contents))
  {
    error("invalid float value %s\n", (string)val);
  }

  value_set = 1;
}

Node encode(Node b)
{
  Node n = b->add_child(new_node(name));

  if(ns) n->add_ns(ns, prefix);

  if(value_set)
    n->set_content(sprintf("%f", contents));
  n->set_attribute("xsi:type", "BODY-ENC:" + xsi_type);
  return n;
}

mixed get_value()
{
  return contents;
}

float get_native_type()
{
  return contents;
}

