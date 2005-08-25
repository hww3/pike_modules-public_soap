//!

import Public.Parser.XML2;

static string name;
static string type;
static string ns;
static string prefix;

static mapping type_constraints = ([]);
static mapping instance_constraints = ([]);

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
