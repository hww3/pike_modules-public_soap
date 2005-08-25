//!

import Public.SOAP;

array(RPCParameter) input_params;
RPCParameter result_param;
string method_name;

void create(string method, array(RPCParameter) parameters, RPCParameter 
result)
{
  method_name = method;
  input_params = parameters;
  result_param = result;
}

mixed `()(mixed ... args)
{
  if(sizeof(args) != sizeof(input_params))
    error("incorrect number of input arguments.\n");

  foreach(args; int i; mixed a)
  {
    input_params[i]->set(a);
  }

  object e = Public.SOAP.Envelope();                   
  e->body = Public.SOAP.Body();                        

  object s = Public.SOAP.Encoding.Struct(method_name);  

  foreach(input_params; int j; mixed input)
  {
    s->elements += ([ input->get_name(): input->get_value() ]);  
  }
  object be = Public.SOAP.BodyElement();               
  be->set_element(s);                                  
  e->body->add_element(be); 

  return e;
}
