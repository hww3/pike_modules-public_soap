import Public.Parser.XML2;
import Public.SOAP;
import .Constants;

enum RPCParamDirection 
{
  IN,
  OUT,
  INOUT
};

function get_xsd_type = get_rpc_type;

.Type get_rpc_type(string type)
{
  if(type == "string")
    return .String;
  if(type == "boolean")
    return .Boolean;
  if(type == "float")
    return .Float;
  if(type == "double")
    return .Double;
  if(type == "integer")
    return .Integer;
}

.Type decode_data(Node data, ServiceDefinition|void wsdl)
{
  .Type r;

  if(!wsdl)
    r = decode_from_data(data);
  else 
    r = decode_from_wsdl(data, wsdl);

  return r;
}

private .Type decode_from_data(Node data)
{
  .Type val;
  if(data->get_node_type() == Public.Parser.XML2.Constants.TEXT_NODE) return 0;
  if(data->get_ns() == SOAP_ENCODING_URI && data->get_node_name() =="Array")
  {
    val = .Array(data);
  }
  string key = search(data->get_nss(), SOAP_XSI_URI);
  mapping attrs;
  if(key)
    attrs = data->get_ns_attributes(key);
werror("attrs: %O %O\n", SOAP_XSI_URI, attrs);
  if(attrs && attrs->type)
  {
       string n,t;
       [n,t] = attrs->type/":";
       if(data->get_nss()[n] == SOAP_XSD_URI) // we have an xsd type.
       {
          program p = get_xsd_type(t);          
          if(p)
            val = p(data);
          else
            error("unable to determine deserialization for type " + t + "\n");
       }
    }

  if(!attrs || !attrs->type) // guess it's safe to assume a struct here.
  {
    werror("decoding as a struct.\n");
    val = .Struct(data);
  }    


  return val;
}

private .Type decode_from_wsdl(Node data, ServiceDefinition wsdl)
{
  .Type val;

  return val;
}

