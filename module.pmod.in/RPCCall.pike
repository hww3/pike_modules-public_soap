//!

import Public.SOAP;
import Public.Parser.XML2;

static array(RPCParameter) input_params;
static RPCParameter result_param;
static string method_name;
static string endpoint;

void create(string method, array(RPCParameter) parameters, RPCParameter result)
{
  method_name = method;
  input_params = parameters;
  result_param = result;
}

void set_endpoint(string url)
{
  endpoint = url;
}

array `()(mixed ... args)
{
  if(sizeof(args) != sizeof(input_params))
    error("incorrect number of input arguments.\n");

  foreach(args; int i; mixed a)
  {
    input_params[i]->set(a);
  }

  object e = Public.SOAP.Envelope();                   
  e->set_body(Public.SOAP.Body());                        

  object s = Public.SOAP.Encoding.Struct(method_name);  

  foreach(input_params; int j; mixed input)
  {
    s->add(input->get_value());  
  }
  object be = Public.SOAP.BodyElement();               
  be->set_element(s);                                  
  e->get_body()->add_element(be); 

  object q = Protocols.HTTP.do_method("POST", endpoint,  0, 
    (["SOAPAction": "\"\"", "Content-Type": "text/xml"]), 0,  
    (string)e->render_envelope());

  object rn = Public.Parser.XML2.parse_xml(q->data());

  .Envelope envelope = .Envelope(rn);
  .Body body = envelope->get_body();


  if(!body || !sizeof(body->get_elements()))
    error("empty response body!\n");

  array elements = body->get_elements();

  if(object_program(elements[0]) == .Fault)
     error(elements[0]->faultstring + "\n");

  mixed retval = elements[0]->get_element();
  if(object_program(retval) != .Encoding.Struct)
    error("invalid RPC response: expected struct.\n");

  retval = retval->get_elements()[retval->get_order()[0]];

  return retval->get_native_type();
}

void decode_result(Node n)
{
  // the response should be a struct. we don't care what the name is.
  Encoding.decode_data(n);  
}

