xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace soap11="http://schemas.xmlsoap.org/soap/envelope/";


declare function local:newBody11() as element() {
    <soap11:Body/>
};

local:newBody11()
