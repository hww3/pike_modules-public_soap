//!

import Public.SOAP;
import Public.Parser.XML2;
import .Constants;

static string name;
static string target_namespace;

static mapping(string:SOAPType) types = ([]);
static mapping(string:SOAPMessage) messages = ([]);
static mapping(string:SOAPOperation) operations = ([]);
static mapping(string:SOAPPortType) porttypes = ([]);
static mapping(string:SOAPBinding) bindings = ([]);
static mapping(string:SOAPPort) ports = ([]);
static mapping(string:SOAPService) services = ([]);

//!
mapping get_types()
{
   return types;
}

//!
mapping get_messages()
{
   return messages;
}

//!
mapping get_operations()
{
   return operations;
}

//!
mapping get_porttypes()
{
   return porttypes;
}

//!
mapping get_bindings()
{
   return bindings;
}

//!
mapping get_services()
{
   return services;
}

//!
mapping get_ports()
{
   return ports;
}

//!
static void create(Node|void wsdlnode)
{
  if(wsdlnode)
  {
    decode(wsdlnode);
  } 
}

//!
string get_name()
{
  return name;
}

//!
string get_target_namespace()
{
  return target_namespace;
}

//!
void set_name(string _name)
{
  name = _name;
}

//!
void set_target_namespace(string _target_namespace)
{
  target_namespace = _target_namespace;
}

//!
void decode(Node w)
{
  // first, we see if we're in the right namespace.
  if(w->get_ns() != WSDL_NAMESPACE_URI)
    error("WSDL.decode: incorrect default namespace.\n");

  // second, we check to see if we've got the right root element name.
  if(w->get_node_name() != "definitions")
    error("WSDL.decode: invalid root element. expecting definitions.\n");

  // if so, we pull any of the required information from the definition.
  mapping attrs = w->get_attributes();

  if(attrs->name) 
    name = attrs->name;

  if(attrs->targetNamespace)
    target_namespace = attrs->targetNamespace;

  // then, we loop through all of its children looking for definitions.

  foreach(w->children(); int i; Node c)
  {
    // we can skip anything that's not an element.
    if(c->get_node_type() != Public.Parser.XML2.Constants.ELEMENT_NODE)
      continue;

    else if (c->get_ns() == WSDL_NAMESPACE_URI)
    {
       switch(c->get_node_name())
       {
          case "documentation":
            break;
 
          case "types":
            // the types element is tricky, because we can have multiple 
            // definitions within a single tag.

            break;

          case "message":
            SOAPMessage m = SOAPMessage(c);
            messages[m->get_name()] = m;
            break;

          case "portType":
            break;

          case "binding":
            break;

          case "service":
            break;

          default:
            werror("WSDL.decode: got an unknown element: %O", 
                      c->get_node_name());
       }
    }
  }
}

//!
class SOAPType
{
}

//!
class SOAPMessage
{
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
  }

  //!
  class Part
  {
    static string name;
    static string element;
    static string type;
 
    //!
    void create()
    {
    }
    
    //!
    void set_name(string _name)
    {
       name = _name;
    }

    //!    
    void set_element(string _element)
    {
       element = _element;
    }

    //!
    void set_type(string _type)
    {
       type = _type;
    }

    //!
    string get_name()
    {
      return name;
    }

    //!
    string get_element()
    {
      return element;
    }

    //!
    string get_type()
    {
      return type;
    }
  }
}

//!
class SOAPOperation
{
}

//!
class SOAPPortType
{
}

//!
class SOAPBinding
{
}

//!
class SOAPPort
{
}

//!
class SOAPService
{
}
