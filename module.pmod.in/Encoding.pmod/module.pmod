
.Type get_rpc_type(string type)
{
  if(type == "string")
    return .String;
  if(type == "boolean")
    return .Boolean;
}
