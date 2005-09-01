//!

import Public.SOAP;

static string name;
static string type;

static Encoding.Type val;

static void create(string|void name, string type)
{
  val = Encoding.get_rpc_type(type)(name);
}

void set(mixed v)
{
  if(v == UNDEFINED)
  {
//    werror("undefined value!\n");
  }
  else
    val->set(v);
}

void set_value(Encoding.Type v)
{
  val = v;
}

Encoding.Type get_value()
{
  return val;
}

string get_type()
{
  return type;
}

string get_name()
{
  return name;  
}
