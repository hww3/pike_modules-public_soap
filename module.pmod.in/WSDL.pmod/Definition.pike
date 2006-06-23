//!

import Public.SOAP;
import Public.Parser.XML2;
import .Constants;

static string name;
static string target_namespace;

static mapping(string:WSDL.Type) types = ([]);
static mapping(string:WSDL.Message) messages = ([]);
static mapping(string:WSDL.Operation) operations = ([]);
static mapping(string:WSDL.PortType) porttypes = ([]);
static mapping(string:WSDL.Binding) bindings = ([]);
static mapping(string:WSDL.Port) ports = ([]);
static mapping(string:WSDL.Service) services = ([]);

static int have_documentation = 0;
static int have_types = 0;

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

static int decode_types(Node c)
{

}

static void decode_import(Node c)
{

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
            if(have_documentation) throw(Error.Generic("Duplicate documentation element!\n"));
            have_documentation = 1;
            break;
 
          case "types":
            // the types element is tricky, because we can have multiple 
            // definitions within a single tag.
            if(have_types) throw(Error.Generic("Duplicate types element!\n"));
            have_types = 1;
            decode_types(c);
            break;

          case "message":
            WSDL.Message m = WSDL.Message(c);
            messages[m->get_name()] = m;
            break;

          case "portType":
            WSDL.PortType p = WSDL.PortType(c);
            porttypes[p->get_name()] = p;
            break;

          case "binding":
            WSDL.Binding b = WSDL.Binding(c);
            bindings[b->get_name()] = p;
            break;

          case "service":
            WSDL.Service s = WSDL.Service(c);
            services[s->get_name()] = s;
            break;

          case "import":
            decode_import(c);
            break;

          default:
            werror("WSDL.decode: got an unknown element: %O", 
                      c->get_node_name());
       }
    }
  }
}

