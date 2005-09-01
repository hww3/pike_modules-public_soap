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

static void create(Node|void wsdlnode)
{
  if(wsdlnode)
  {
    decode(wsdlnode);
  } 
}

string get_name()
{
  return name;
}

string get_target_namespace()
{
  return target_namespace;
}

void set_name(string _name)
{
  name = _name;
}

void set_target_namespace(string _target_namespace)
{
  target_namespace = _target_namespace;
}

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
       werror("looking at: %O\n", c->get_node_name());
       switch(c->get_node_name())
       {
          case "documentation":
            break;
 
          case "types":
            break;

          case "message":
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
