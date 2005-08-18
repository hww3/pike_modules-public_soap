//!

static string name;
static string type;
static string ns;
static string prefix;

static void create(string _name, string|void _ns, string|void _prefix)
{
  name = _name;

  if(_prefix)
    prefix = _prefix;
  if(_ns)
    ns = _ns;
}
