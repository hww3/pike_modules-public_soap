//!

import Public.SOAP;

static string name;
static string type;

static Encoding.Type value;

static void create(string|void name, string type)
{
  value = Encoding.get_rpc_type(type)(name);
}

void set(mixed v);
{
  value->set(v);
}

void set_value(Encoding.Type v)
{
  value = v;
}

Encoding.Type get_value()
{
  return value;
}

string get_type()
{
  return type;
}

string get_name()
{
  return name;  
}
