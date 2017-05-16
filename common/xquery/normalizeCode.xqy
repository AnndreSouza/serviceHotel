xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://telefonica.br/Common/ErrorTrace/v1";
(:: import schema at "../types/ErrorTrace.xsd" ::)

import module namespace fnx="http://andre.br/Common/Functions" at "Functions.xqy";

declare variable $code as element() (:: element(*, ns1:codeType) ::) external;

declare function local:normalize($code as element() (:: element(*, ns1:codeType) ::)) as element() {
    <ns1:code>
        <ns1:service>{
          fnx:left-offset(fn:data($code/ns1:service), 4, '0')
        }</ns1:service>
  
        <ns1:operation>{
          fnx:left-offset(fn:data($code/ns1:operation), 4, '0')
        }</ns1:operation>
  
        <ns1:layer>{
          fnx:left-offset(fn:data($code/ns1:layer), 4, '0')
        }</ns1:layer>
  
        <ns1:tamSystem>{
          fnx:left-offset(fn:data($code/ns1:tamSystem), 6, '0')
        }</ns1:tamSystem>
  
        <ns1:legacySystem>{
          fnx:left-offset(fn:data($code/ns1:legacySystem), 4, '0')
        }</ns1:legacySystem>
  
        <ns1:api>{
          fnx:left-offset(fn:data($code/ns1:api), 4, '0')
        }</ns1:api>
  
        <ns1:error>{
          fnx:left-offset(fn:data($code/ns1:error), 4, '0')
        }</ns1:error>
    </ns1:code>
};

local:normalize($code)
