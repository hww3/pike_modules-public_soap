import Public.Parser.XML2;
import Public.SOAP;

.Type get_rpc_type(string type)
{
  if(type == "string")
    return .String;
  if(type == "boolean")
    return .Boolean;
}

.Type decode_data(Node data, ServiceDefinition wsdl)
{

}
