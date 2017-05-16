xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare variable $soapfault as element() external;

declare function local:faultOf($soapfault as element()) as xs:string {

  if (fn:exists($soapfault/detail/*[1]))
  then
    fn:local-name($soapfault/detail/*[1])
  else
    ''
    
};

local:faultOf($soapfault)
