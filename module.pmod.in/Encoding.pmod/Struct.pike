inherit .Type;

import Public.Parser.XML2;
import .Constants;

string type="STRUCT";

mapping elements = ([]);

Node encode()
{
  node n = new_node(name);

  if(ns) n->add_ns(ns, prefix);

  foreach(elements; string n; string v)
  {
    n->add_child(v->encode());
  }

  return n;
}
