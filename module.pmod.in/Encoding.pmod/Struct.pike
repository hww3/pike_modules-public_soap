inherit .Type;

import Public.Parser.XML2;
import ".";
import .Constants;

string type="STRUCT";

mapping elements = ([]);

void add(Type item)
{
  elements[item->name] = item;
}

void decode(Node d)
{
  name = d->get_node_name();
werror("name of struct: %O\n", name);
  if(d->children())
  {
    foreach(d->children(); mixed v; Node c)
    {
      Type item = decode_data(c);
      if(item)
        elements[item->name] = item;
    }
  }
}

Node encode(Node b)
{
  Node n = b->add_child(new_node(name));

  if(ns) n->add_ns(ns, prefix);

  foreach(elements; string name; Type v)
  {
    n->add_child(v->encode(n));
  }

  return n;
}
