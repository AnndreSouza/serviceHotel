xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare default element namespace "";
(:: import schema at "../../schemas/HotelByCityId_response.xsd", 
                     "../../schemas/RestReference_response.xsd" ::)
                     
                     
                     
declare variable $priceDurationChild as xs:string external;
declare variable $priceDurationAdult as xs:string external;

declare variable $payload as element() (:: schema-element(responseRestReference) ::) external;

declare function local:func(
$payload as element() (:: schema-element(responseRestReference) ::)) as element() (:: schema-element(response) ::) {
    <response>
        {
            for $Hotel in $payload/Hotel
            return 
            <Resposta>
                {
                    if ($Hotel/id)
                    then <id>{fn:data($Hotel/id)}</id>
                    else ()
                }
                {
                    if ($Hotel/cityName)
                    then <cityName>{fn:data($Hotel/cityName)}</cityName>
                    else ()
                }
                {
                    for $rooms in $Hotel/rooms
                    return 
                    <rooms>
                        {
                            if ($rooms/roomID)
                            then <roomID>{fn:data($rooms/roomID)}</roomID>
                            else ()
                        }
                        {
                            if ($rooms/categoryName)
                            then <categoryName>{fn:data($rooms/categoryName)}</categoryName>
                            else ()
                        }
                        <totalPrice>{(xs:decimal(fn:data($priceDurationAdult)) div 0.7) + (xs:decimal(fn:data($priceDurationChild)) div 0.7)}</totalPrice>
                        <priceDetail>
                            {
                                if ($rooms/price/adult)
                                then <pricePerDayAdult>{xs:decimal(fn:data($priceDurationAdult)) div 0.7}</pricePerDayAdult>
                                else ()
                            }
                            {
                                if ($rooms/price/child)
                                then <pricePerDayChild>{xs:decimal(fn:data($priceDurationChild)) div 0.7}</pricePerDayChild>
                                else ()
                            }
                        </priceDetail>
                    </rooms>
                }
            </Resposta>
        }
    </response>
};

local:func($payload)