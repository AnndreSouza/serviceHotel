xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace trace="http://telefonica.br/Common/ErrorTrace/v1";
(:: import schema at "../types/ErrorTrace.xsd" ::)
declare namespace fault="http://telefonica.br/Common/Fault/v1";
(:: import schema at "../types/FaultV1.xsd" ::)

declare variable $payload as element() (:: schema-element(trace:errorTrace) ::) external;

declare function local:transform($payload as element() (:: schema-element(trace:errorTrace) ::)) as element() (:: schema-element(fault:InputValidationFault) ::) {
  <fault:InputValidationFault>
    <trace:code>
        <trace:service>{fn:data($payload/trace:code/trace:service)}</trace:service>
        <trace:operation>{fn:data($payload/trace:code/trace:operation)}</trace:operation>
        <trace:layer>{fn:data($payload/trace:code/trace:layer)}</trace:layer>
        <trace:tamSystem>{fn:data($payload/trace:code/trace:tamSystem)}</trace:tamSystem>
        <trace:legacySystem>{fn:data($payload/trace:code/trace:legacySystem)}</trace:legacySystem>
        <trace:api>{fn:data($payload/trace:code/trace:api)}</trace:api>
        <trace:error>{fn:data($payload/trace:code/trace:error)}</trace:error>
    </trace:code>
    
    <trace:description>{fn:data($payload/trace:description)}</trace:description>
          
    <trace:details>
        <trace:timeStamp>{fn:data($payload/trace:details/trace:timeStamp)}</trace:timeStamp>
        <trace:cause>{fn:data($payload/trace:details/trace:cause)}</trace:cause>
    </trace:details>
  </fault:InputValidationFault>
};

local:transform($payload)
