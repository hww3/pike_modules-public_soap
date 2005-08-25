//!

import Public.Parser.XML2;

inherit .BodyElement;

string faultcode;
string faultspace;
string faultstring;
string faultactor;
string detail;
mapping other_elements = ([]);

void decode(Node n)
{
   if(n->get_node_type() == Public.Parser.XML2.Constants.ELEMENT_NODE
           && n->get_node_name() == "Fault" && n->get_ns() ==
                Public.SOAP.Constants.SOAP_NAMESPACE_URI)
   {
     mapping m = ([]);
     foreach(n->children(); int i; Node c)
     {
        if(c->get_node_type() != Public.Parser.XML2.Constants.ELEMENT_NODE)
          continue;

        string val = c->get_text();

        switch(c->get_node_name())
        {
            case "faultcode":
              string ns, tc;
              array v = c->get_text()/":";
              if(sizeof(v)>1)
              {
                ns = v[0];
                tc = v[1];
                ns = c->get_nss()[ns];
              }
              else tc = c->get_text();
              faultspace = ns;
              faultcode =  tc;
              break;
            case "faultstring":
              faultstring = val||""; 
              break;
            case "faultactor":
              faultactor = val;
              break;
            case "detail":
              detail = val||"";
              break;
            default:
              other_elements[c->get_node_name()] = c;
         }

     }
     if(!(faultcode && faultstring))
     {
       error("invalid Fault: must provide faultcode and faultstring\n");
     }

   }
   else
   {
     error("invalid Fault node\n");
   }
}
