//!

  static string name;
  array part_order = ({});
  mapping parts = ([]);

  //!
  void create(void|Node m)
  {
    if(m) decode(m);
  }

  //!
  mapping get_parts()
  {
    return parts;
  }
 
  //!
  array get_part_order()
  {
    return part_order;
  }

  //!
  string get_name()
  {
    return name;
  }

  //!
  void set_name(string _name)
  {
    name = _name;
  }

  //!
  void decode(Node m)
  {
    name = m->get_attributes()->name;    

    foreach(m->children(); int i; Node c)
    {
      if(c->get_node_type() != Public.Parser.XML2.Constants.ELEMENT_NODE)
        continue;

      if(c->get_node_name() == "part") // let's parse a part...
      {
         mapping a = c->get_attributes();

         part_order += ({ a->name });
         Part p = Part();
         p->set_name(a->name);
         p->set_element(a->element);
         p->set_type(a->type);         
        
         parts[p->get_name()] = p;
      }        
    }

