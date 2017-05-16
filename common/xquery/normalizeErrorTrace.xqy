xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://telefonica.br/Common/ErrorTrace/v1";
(:: import schema at "../types/ErrorTrace.xsd" ::)

import module namespace fnx="http://andre.br/Common/Functions" at "Functions.xqy";

declare variable $errorTrace as element() (:: schema-element(ns1:errorTrace) ::) external;

declare function local:normalize($errorTrace as element() (:: schema-element(ns1:errorTrace) ::)) as element() (:: schema-element(ns1:errorTrace) ::) {
    <ns1:errorTrace>
        <ns1:code>

          <ns1:service>{
            fnx:left-offset(fn:data($errorTrace/ns1:code/ns1:service), 4, '0')
          }</ns1:service>

          <ns1:operation>{
            fnx:left-offset(fn:data($errorTrace/ns1:code/ns1:operation), 4, '0')
          }</ns1:operation>

          <ns1:layer>{
            fnx:left-offset(fn:data($errorTrace/ns1:code/ns1:layer), 4, '0')
          }</ns1:layer>

          <ns1:tamSystem>{
            fnx:left-offset(fn:data($errorTrace/ns1:code/ns1:tamSystem), 6, '0')
          }</ns1:tamSystem>

          <ns1:legacySystem>{
            fnx:left-offset(fn:data($errorTrace/ns1:code/ns1:legacySystem), 4, '0')
          }</ns1:legacySystem>

          <ns1:api>{
            fnx:left-offset(fn:data($errorTrace/ns1:code/ns1:api), 4, '0')
          }</ns1:api>

          <ns1:error>{
            fnx:left-offset(fn:data($errorTrace/ns1:code/ns1:error), 4, '0')
          }</ns1:error>

        </ns1:code>

        <ns1:description>{fn:data($errorTrace/ns1:description)}</ns1:description>

        <ns1:details>

          <ns1:timeStamp>{fn:data($errorTrace/ns1:details/ns1:timeStamp)}</ns1:timeStamp>

          <ns1:cause>{fn:data($errorTrace/ns1:details/ns1:cause)}</ns1:cause>

        </ns1:details>
    </ns1:errorTrace>
};

local:normalize($errorTrace)
