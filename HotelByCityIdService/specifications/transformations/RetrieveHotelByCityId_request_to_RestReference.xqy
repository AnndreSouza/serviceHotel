xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare default element namespace "";
(:: import schema at "../../schemas/HotelByCityId_request.xsd" ::)

declare variable $payload as element() (:: schema-element(Request) ::) external;

declare function local:func($payload as element() (:: schema-element(Request) ::)) as element() (:: schema-element(Request) ::) {
    <Request>
        {
            if ($payload/CityCode)
            then <CityCode>{fn:data($payload/CityCode)}</CityCode>
            else ()
        }
        {
            if ($payload/Checkin)
            then <Checkin>{fn:data($payload/Checkin)}</Checkin>
            else ()
        }
        {
            if ($payload/Checkout)
            then <Checkout>{fn:data($payload/Checkout)}</Checkout>
            else ()
        }
        {
            if ($payload/QtdAdultos)
            then <QtdAdultos>{fn:data($payload/QtdAdultos)}</QtdAdultos>
            else ()
        }
        {
            if ($payload/QtdCriancas)
            then <QtdCriancas>{fn:data($payload/QtdCriancas)}</QtdCriancas>
            else ()
        }
    </Request>
};

local:func($payload)