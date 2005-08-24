//!

array(RPCParameter) input_params;
RPCParameter result_param;
string method_name

void create(string method, array(RPCParameter) parameters, RPCParameter 
result)
{
  method_name = method;
  input_params = parameters;
  result_param = result;
}
