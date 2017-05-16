xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

import module namespace functx="http://andre.br/Common/Functions" at "Functions.xqy";
import module namespace const="http://andre.br/Common/Constants" at "Constants.xqy";

declare variable $tam as xs:string external;
declare variable $error as xs:string external;
declare variable $fault as element() external;
declare variable $body as element() external;

declare function local:newExpositionFault($tam as xs:string, 
                                          $error as xs:string, 
                                          $fault as element(),
                                          $body as element()) 
                                          as element() {
                                          
    functx:newFault11(const:ExpositionLayerCode(), $tam, '0000', '0000', $error, $fault, $body)
};

local:newExpositionFault($tam, $error, $fault, $body)
