//!

import Public.Parser.XML2;

static string name;
static string type;
static string ns;
static string prefix;
static string xsi_type;
static int value_set = 0;
static mapping type_constraints = ([]);
static mapping instance_constraints = ([]);
static array namespaces = ({});

static void create(Node|string _name, string|void _ns, string|void _prefix)
{
  if(objectp(_name))
  {
    decode(_name);
    return;
  }
  name = _name;

  if(_prefix)
    prefix = _prefix;
  if(_ns)
    ns = _ns;
}

Node encode(Node b);

void decode(Node v);

void set(mixed val);

mixed get_value();

string get_name()
{
  return name;
}

string get_type()
{
  return type;
}

mixed get_native_type();

array get_namespaces()
{
  return namespaces;
}

void set_namespaces(array tns)
{
   namespaces = copy_value(tns);
}
