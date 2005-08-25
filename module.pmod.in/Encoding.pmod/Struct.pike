inherit .Type;

import Public.Parser.XML2;
import ".";
import .Constants;

string type="STRUCT";

static mapping elements = ([]);
static array order = ({});

void add(Type item)
{
write("added %O\n", item->get_name());
  order += ({ item->get_name() });
  elements[item->get_name()] = item;
}

array get_order()
{
  return order + ({});
}

mapping get_elements()
{
  return elements +([]);
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
        add(item);
    }
  }
}

Node encode(Node b)
{
  Node n = b->add_child(new_node(get_name()));

  if(ns) n->add_ns(ns, prefix);

  mapping e = get_elements();

  foreach(get_order(); int i; string nom)
  {
    n->add_child(e[nom]->encode(n));
  }

  return n;
}

mixed get_value()
{
  return get_elements();
}
