xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://telefonica.br/Common/TEFHeader/v1";
(:: import schema at "../types/TEFHeader.xsd" ::)

import module namespace fnx="http://andre.br/Common/Functions" at "Functions.xqy";

declare namespace ctx="http://www.bea.com/wli/sb/context";

declare variable $trackingID as xs:string external;
declare variable $service as xs:string external;

declare function local:newTEFHeader($trackingID as xs:string, 
                                    $service as xs:string) 
                                    as element() (:: schema-element(ns1:tefHeader) ::) {
    <ns1:tefHeader>
      <!-- use this id to track the message -->
      <ns1:idMessage>{$trackingID}</ns1:idMessage>
      <ns1:transactionTimestamp>{fn:current-dateTime()}</ns1:transactionTimestamp>
      {
        if(fn:not(fn:empty($service)))
        then
          <ns1:serviceName>{$service}</ns1:serviceName>
        else
          <ns1:serviceName/>
      }
    </ns1:tefHeader>
};

local:newTEFHeader($trackingID, $service)
