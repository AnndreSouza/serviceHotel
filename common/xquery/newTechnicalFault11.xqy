xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

import module namespace functx="http://andre.br/Common/Functions" at "Functions.xqy";

declare variable $error as xs:string external;
declare variable $fault as element() external;
declare variable $body as element() external;

declare function local:newTecnhicalFault($error as xs:string,  
                                         $fault as element(),
                                         $body as element()) as element() {
        
    functx:newFault11('0000', '0000', '000000', '0000', $error, $fault, $body)
};

local:newTecnhicalFault($error, $fault, $body)
