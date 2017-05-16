xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://telefonica.br/Common/TEFHeader/v1";
(:: import schema at "../types/TEFHeader.xsd" ::)

declare variable $trackingID as xs:string external;

declare variable $service as xs:string external;

declare variable $payload as element() (:: schema-element(ns1:tefHeader) ::) external;

declare function local:func($trackingID as xs:string, 
                            $service as xs:string, 
                            $payload as element() (:: schema-element(ns1:tefHeader) ::)) as element() (:: schema-element(ns1:tefHeader) ::) {
    <ns1:tefHeader>
        {
            if ($payload/ns1:userLogin)
            then <ns1:userLogin>{fn:data($payload/ns1:userLogin)}</ns1:userLogin>
            else ()
        }
        {
            if ($payload/ns1:serviceChannel)
            then <ns1:serviceChannel>{fn:data($payload/ns1:serviceChannel)}</ns1:serviceChannel>
            else ()
        }
        {
            if ($payload/ns1:sessionCode)
            then <ns1:sessionCode>{fn:data($payload/ns1:sessionCode)}</ns1:sessionCode>
            else ()
        }
        {
            if ($payload/ns1:application)
            then <ns1:application>{fn:data($payload/ns1:application)}</ns1:application>
            else ()
        }
        
             <ns1:idMessage>{$trackingID}</ns1:idMessage>
        
        {
            if ($payload/ns1:operationNumber)
            then <ns1:operationNumber>{fn:data($payload/ns1:operationNumber)}</ns1:operationNumber>
            else ()
        }
        {
            if ($payload/ns1:ipAddress)
            then <ns1:ipAddress>{fn:data($payload/ns1:ipAddress)}</ns1:ipAddress>
            else ()
        }
        {
            if ($payload/ns1:functionalityCode)
            then <ns1:functionalityCode>{fn:data($payload/ns1:functionalityCode)}</ns1:functionalityCode>
            else ()
        }
         <ns1:transactionTimestamp>{fn:current-dateTime()}</ns1:transactionTimestamp>
        {
        if(fn:not(fn:empty($service)))
        then
          <ns1:serviceName>{$service}</ns1:serviceName>
        else
          <ns1:serviceName/>
      }
        {
            if ($payload/ns1:serviceOperation)
            then <ns1:serviceOperation>{fn:data($payload/ns1:serviceOperation)}</ns1:serviceOperation>
            else ()
        }
        {
            if ($payload/ns1:version)
            then <ns1:version>{fn:data($payload/ns1:version)}</ns1:version>
            else ()
        }
    </ns1:tefHeader>
};

local:func($trackingID,$service,$payload)
