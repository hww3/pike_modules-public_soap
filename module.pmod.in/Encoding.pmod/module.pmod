
Type get_rpc_type(string type)
{
  if(type == "string")
    return Encoding.String;
  if(type == "boolean")
    return Encoding.Boolean;
}
