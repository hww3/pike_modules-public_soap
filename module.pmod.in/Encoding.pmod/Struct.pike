inherit .Type;

import Public.Parser.XML2;
import ".";
import .Constants;

string type="STRUCT";

mapping elements = ([]);

Node encode()
{
  Node n = new_node(name);

  if(ns) n->add_ns(ns, prefix);

  foreach(elements; string name; Type v)
  {
    n->add_child(v->encode());
  }

  return n;
}
