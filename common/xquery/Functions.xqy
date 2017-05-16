xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)
    
module namespace functx="http://andre.br/Common/Functions";

declare namespace sb0="http://www.bea.com/wli/sb/stages/transform/config";

declare namespace sb1="http://www.bea.com/wli/sb/context";

declare namespace soap11="http://schemas.xmlsoap.org/soap/envelope/";

declare namespace ns1="http://andre.br/Common/ErrorTrace/v1";

declare namespace fault="http://andre.br/Common/Fault/v1";


import module namespace const="http://andre.br/Common/Constants" at "Constants.xqy";

declare function functx:datax($element as item()*, $defaultValue as xs:anyAtomicType) as xs:anyAtomicType* {

  if(functx:has-value($element))
  then
    fn:data($element)
  else
    fn:data($defaultValue)
    
};

(:~
 : Recebuma string no formato yyyyMMddHHmmss e a transforma em yyyy-MM-ddTHH:mm:ss
 : Exemplo: 20160511151528 -> 2016-05-11T15:15:28
 
 : @param $stringDate - string com data e hora no formato yyyyMMddHHmmss
 : @return dateTime
 : @author Fábio J. Moraes
 : @since 1.0
:)
declare function functx:string-to-dateTime($stringDate as xs:string) as xs:dateTime{
  xs:dateTime(
   fn:concat
    (
      fn:substring($stringDate, 1, 4),
      '-',
      fn:substring($stringDate, 5, 2),
      '-',
      fn:substring($stringDate, 7, 2),
      'T',
      fn:substring($stringDate, 9, 2),
      ':',
      fn:substring($stringDate, 11, 2),
      ':',
      fn:substring($stringDate, 13, 2)
    )
  )
};

declare function functx:roundit-bytes($bytes as xs:long) as xs:long {

  if($bytes < 1024)
  then
    $bytes (: bytes :)
  else
    if(xs:long($bytes div 1024) < 1024)
    then
      xs:long($bytes div 1024) (: kilo bytes :)
    else
      if(xs:long($bytes div (1024 * 1024)) < 1024)
      then
        xs:long($bytes div (1024 * 1024)) (: mega bytes :)
      else
        xs:long($bytes div (1024 * 1024 * 1024)) (: giga bytes :)
};

declare function functx:indicator-bytes($bytes as xs:long) as xs:string {

  if($bytes < 1024)
  then
    'BYTE'
  else
    if(xs:long($bytes div 1024) < 1024)
    then
      'KBYTE' (: kilo bytes :)
    else
      if(xs:long($bytes div (1024 * 1024)) < 1024)
      then
        'MBYTE' (: mega bytes :)
      else
        'GBYTE' (: giga bytes :)
};

declare function functx:roundit-time($seconds as xs:long) as xs:long {

  if($seconds < 60)
  then
    $seconds (: segundos :)
  else
    if(xs:long($seconds div 60) < 60)
    then
      xs:long($seconds div 60) (: minutos :)
    else
      xs:long($seconds div (60 * 60)) (: horas :)

};

declare function functx:indicator-time($seconds as xs:long) as xs:string {

  if($seconds < 60)
  then
    'SEGUNDOS' (: segundos :)
  else
    if(xs:long($seconds div 60) < 60)
    then
      'MINUTOS' (: minutos :)
    else
      'HORAS' (: horas :)
      
};

declare function functx:is-a-number( $value as xs:anyAtomicType? ) as xs:boolean {

  string(number($value)) != 'NaN'
  
};

declare function functx:substring-before-if-contains
  ( $arg as xs:string? ,
    $delim as xs:string )  as xs:string? {

   if (contains($arg,$delim))
   then substring-before($arg,$delim)
   else $arg
} ;

declare function functx:substring-after-if-contains
  ( $arg as xs:string? ,
    $delim as xs:string )  as xs:string? {

   if (contains($arg,$delim))
   then substring-after($arg,$delim)
   else $arg
 } ;

declare function functx:iso-datetime-to-xml-datetime($ISODateTime as xs:string) as xs:dateTime {

  xs:dateTime
  (
    fn:concat
    (
      fn:substring($ISODateTime, 7, 4), (: ano YYYY :)
      '-',
      fn:substring($ISODateTime, 4, 2), (:  mes MM  :)
      '-',
      fn:substring($ISODateTime, 1, 2), (:  dia DD  :)
      'T',
      fn:substring($ISODateTime, 12)    (:  horas   :)
    )
  )
  
};


(: 
- Cabeçalho ---------------------------------------------------------------------------------------------------------------------------------
Autor: Adriano Gomes 
Data: 08/06/2016
- Nome---------------------------------------------------------------------------------------------------------------------------------------
setValue-to-Date
- Objetivo ----------------------------------------------------------------------------------------------------------------------------------
Atribui o valor para um campo especifico da data .
- Descrição ---------------------------------------------------------------------------------------------------------------------------------
Permite setar um valor especifo para o dia, mes ou ano de uma data especifica.
- Campos de entrada -------------------------------------------------------------------------------------------------------------------------
field: tipo do campo a ser setado; os tipos estão predefinidos na xquerie de constant - DefaultDayOfMounth(), DefaultMounth() e DefaultYear();
value: valor a ser setado no campo especifico da data
dateTime: data que tera o valor setado
- Campo de saida ----------------------------------------------------------------------------------------------------------------------------
date: data com o valor alterado
- Fluxo alternativo -------------------------------------------------------------------------------------------------------------------------
Caso o field sejá invalido (diferente dos ), a data é retornada sem nenhuma alteração. 
- Exemplo de uso ----------------------------------------------------------------------------------------------------------------------------
O exemplo abaixo seta o mês 10 na data corrente.
 
 <ns11:billingDate>
    {func:setValue-to-Date(const:DefaultMounth(),10,fn:current-date())}
 </ns11:billingDate>
 
:)
declare function functx:setValue-to-Date($field as xs:string, $value as xs:int, $xmlDate as xs:date) as xs:date {
  xs:date
  (
    (: seta o valor do campo dia do mes :)
    if($field = const:DefaultDayOfMounth())
      then
          fn:concat 
          (
              functx:left-offset(xs:string(fn:year-from-date($xmlDate)), 4, '0'),
              "-",
              functx:left-offset(xs:string(fn:month-from-date($xmlDate)), 2, '0'),
              "-",
              functx:left-offset(xs:string($value), 2, '0')
          )
    else (: seta o valor do campo mes :)
        if($field = const:DefaultMounth())
            then
                fn:concat 
                (
                    functx:left-offset(xs:string(fn:year-from-date($xmlDate)), 4, '0'),
                    "-",
                    functx:left-offset(xs:string($value), 2, '0'),
                    "-", 
                    functx:left-offset(xs:string(fn:day-from-date($xmlDate)), 2, '0')
                )
        else (: seta o valor do campo ano :)
            if($field = const:DefaultYear())
                then
                    fn:concat 
                    (
                      functx:left-offset(xs:string($value), 4, '0'),
                        "-", 
                      functx:left-offset(xs:string(fn:month-from-date($xmlDate)), 2, '0'),
                       "-",
                      functx:left-offset(xs:string(fn:day-from-date($xmlDate)), 2, '0')

                    )
            else  (: não set em nenhum campo da data :)
                fn:concat 
                    (
                        functx:left-offset(xs:string(fn:year-from-date($xmlDate)), 4, '0'),
                        "-",
                        functx:left-offset(xs:string(fn:month-from-date($xmlDate)), 2, '0'),
                        "-",
                        functx:left-offset(xs:string(fn:day-from-date($xmlDate)), 2, '0')
                    )  )
 };
 
 
(: 
- Cabeçalho ---------------------------------------------------------------------------------------------------------------------------------
Autor: Adriano Gomes 
Data: 28/07/2016
- Nome---------------------------------------------------------------------------------------------------------------------------------------
setValue-to-Date
- Objetivo ----------------------------------------------------------------------------------------------------------------------------------
Converter uma data hora para o padrão brasileiro .
- Campos de entrada -------------------------------------------------------------------------------------------------------------------------
$ABNTDateTime: data a ser formatada;
$hasHour: true -> indica se data deve ser formatada contendo horas, minuto e segundo; false -> apenas data e hora
dateTime: data que tera o valor setado
- Campo de saida ----------------------------------------------------------------------------------------------------------------------------
dateFormatada: data ( e hora se solicitado) formatada no padrão brasileiro

- Exemplo de uso ----------------------------------------------------------------------------------------------------------------------------
O exemplo abaixo seta o mês 10 na data corrente.
 
 <ns11:billingDate>
    {func:abnt-datetime-to-xml-dateStringBR(fn:current-date(), true)}
 </ns11:billingDate>
 
:)

declare function functx:abnt-datetime-to-xml-dateStringBR($ABNTDateTime as xs:dateTime, $hasHour as xs:boolean) as xs:string {

  if(not($hasHour))
  then
         fn:concat 
          (
              functx:left-offset(xs:string(fn:day-from-dateTime($ABNTDateTime)), 2, '0'),
              "/",
              functx:left-offset(xs:string(fn:month-from-dateTime($ABNTDateTime)), 2, '0'),
              "/",
              functx:left-offset(xs:string(fn:year-from-dateTime($ABNTDateTime)), 4, '0')
          ) 
    else (
          fn:concat 
          (
            functx:left-offset(xs:string(fn:day-from-dateTime($ABNTDateTime)), 2, '0'),
            "/",
            functx:left-offset(xs:string(fn:month-from-dateTime($ABNTDateTime)), 2, '0'),
            "/",
            functx:left-offset(xs:string(fn:year-from-dateTime($ABNTDateTime)), 4, '0'),
            " ",
            functx:left-offset(xs:string(hours-from-dateTime($ABNTDateTime)), 2, '0'),
            ":",
            functx:left-offset(xs:string(fn:minutes-from-dateTime($ABNTDateTime)), 2, '0'),
            ":",
            functx:left-offset(xs:string(fn:seconds-from-dateTime($ABNTDateTime)), 2, '0')
       )         
   )    
};


 declare function functx:abnt-datetime-to-format-YYYYMMDDHHmmss($ABNTDateTime as xs:dateTime) as xs:string {
   (
          fn:substring(
          fn:concat 
          (
            functx:left-offset(xs:string(fn:year-from-dateTime($ABNTDateTime)), 4, '0'),
            functx:left-offset(xs:string(fn:month-from-dateTime($ABNTDateTime)), 2, '0'),
            functx:left-offset(xs:string(fn:day-from-dateTime($ABNTDateTime)), 2, '0'),
            functx:left-offset(xs:string(hours-from-dateTime($ABNTDateTime)), 2, '0'),
            functx:left-offset(xs:string(fn:minutes-from-dateTime($ABNTDateTime)), 2, '0'),
            functx:left-offset(xs:string(fn:seconds-from-dateTime($ABNTDateTime)), 2, '0')
          ) ,1,13))
};
 
  declare function functx:abnt-current-datetime-GMTformat() as xs:string {
   (
          fn:replace
          (
            xs:string(fn:current-dateTime()), '-02:00', '-0300')
      
   )    
};
 


 
 
  declare function functx:abnt-datetime-to-format-YYYYMMDDHHmmssSSS($ABNTDateTime as xs:dateTime) as xs:string {
   (
          fn:concat 
          (
            functx:left-offset(xs:string(fn:year-from-dateTime($ABNTDateTime)), 4, '0'),
            functx:left-offset(xs:string(fn:month-from-dateTime($ABNTDateTime)), 2, '0'),
            functx:left-offset(xs:string(fn:day-from-dateTime($ABNTDateTime)), 2, '0'),
            functx:left-offset(xs:string(hours-from-dateTime($ABNTDateTime)), 2, '0'),
            functx:left-offset(xs:string(fn:minutes-from-dateTime($ABNTDateTime)), 2, '0'),
            functx:left-offset(xs:string(fn:seconds-from-dateTime($ABNTDateTime)), 3, '0')
       )         
   )    
};
 
declare function functx:abnt-date-to-xml-datetime($ABNTDate as xs:string) as xs:dateTime {

  if(fn:string-length($ABNTDate) <= 10)
  then
    xs:dateTime
    (
      fn:concat
      (
        fn:substring($ABNTDate, 7, 4),
        '-',
        fn:substring($ABNTDate, 4, 2),
        '-',
        fn:substring($ABNTDate, 1, 2),
        'T00:00:00'
      )
    )
  else
    xs:dateTime
    (
      fn:concat
      (
        fn:substring($ABNTDate, 7, 4),
        '-',
        fn:substring($ABNTDate, 4, 2),
        '-',
        fn:substring($ABNTDate, 1, 2),
        'T',
        fn:normalize-space(fn:substring($ABNTDate, 11))
      )
    )
};

declare function functx:xml-date-to-xml-datetime($xmlDate as xs:date) as xs:dateTime {

  xs:dateTime
  (
    fn:concat
    (
      xs:string($xmlDate),
      'T00:00:00'
    )
  )
  
};

declare function functx:date-of($datetime as xs:dateTime) as xs:date {

  xs:date
  (
    fn:substring(xs:string($datetime), 1, 10)
  )
};

declare function functx:left-offset($str as xs:string, $maxLength as xs:integer, $offset as xs:string) as xs:string {

  if(fn:string-length($str) >= $maxLength)
  then
    $str
  else
    functx:left-offset
    (
      fn:concat($offset, $str),
      $maxLength,
      $offset
    ) 
};

declare function functx:right-offset($str as xs:string, $maxLength as xs:integer, $offset as xs:string) as xs:string {

  if(fn:string-length($str) >= $maxLength)
  then
    $str
  else
    functx:right-offset
    (
      fn:concat($str,$offset),
      $maxLength,
      $offset
    ) 
};


declare function functx:fromSAPNumber($number as xs:string) as xs:integer {

  xs:integer(
    fn:replace(
      functx:substring-before-if-contains($number, ','),
      '\.',
      ''
    )
  )
  
};

declare function functx:to-iso-float-point($number as xs:string) as xs:double {

  xs:double(fn:replace($number, ',', '.'))
  
};

declare function functx:toSAPDate($value as xs:dateTime) as xs:integer {
  xs:integer
  (fn:concat(fn:substring(xs:string($value), 9, 2),fn:substring(xs:string($value), 6, 2),fn:substring(xs:string($value), 1, 4)))
  
};

declare function functx:toSAPDateString($value as xs:dateTime) as xs:string{
  fn:concat(fn:substring(xs:string($value), 9, 2),fn:substring(xs:string($value), 6, 2),fn:substring(xs:string($value), 1, 4))
  
};


declare function functx:toGMonth($dateTime as xs:dateTime) as xs:gMonth {

    xs:gMonth(
      fn:concat(
          '--', 
          functx:left-offset(xs:string(fn:month-from-dateTime($dateTime)), 2, '0')
      )
    )
  
};

declare function functx:has-value($element as element()*) as xs:boolean{
  
  if(fn:not(fn:empty($element)))
  then
    fn:not
    (
      fn:normalize-space($element) = ''
    )
  else
    false()
  
};

declare function functx:required-element($element as element()*, $path as xs:string) as element()? {
  if(fn:not(fn:empty($element)))
  then
    if(fn:normalize-space(fn:data($element)) = '')
    then
      <sb0:message>
        {const:EmptyElementMessage()} {fn:local-name($element)}@{fn:namespace-uri($element)}
      </sb0:message>
    else 
      ()
  else 
    <sb0:message>
       {const:AbsentElementMessage()} {$path}
    </sb0:message>
};

declare function functx:mimax-length($element as element()*, $minLength as xs:integer, $maxLength as xs:integer) as element()? {

  if(fn:not(fn:empty($element)))
  then
    if(
        fn:not
        (
          fn:string-length(fn:normalize-space(fn:data($element))) >= $minLength
          and 
          fn:string-length(fn:normalize-space(fn:data($element))) <= $maxLength
        )
      )
    then
      <sb0:message>
        {const:InvalidLengthMessage($minLength, $maxLength, fn:string-length(fn:normalize-space(fn:data($element))), fn:concat(fn:local-name($element), '@', fn:namespace-uri($element)))}
      </sb0:message>
    else
      ()
  else
    ()
};

declare function functx:expected-pattern($element as element()*, $pattern as xs:string) as element()? {

  if(fn:not(fn:empty($element)))
  then
    if(fn:not(fn:matches(fn:data($element), $pattern)))
    then
      <sb0:message>
        {const:InvalidFormatMessage(fn:data($element), $pattern, fn:concat(fn:local-name($element), '@', fn:namespace-uri($element)))}
      </sb0:message>
    else
      ()
  else
    ()
};

declare function functx:contains-value($element as element()*, $list as xs:anyAtomicType*) as xs:boolean {

  (fn:data($element) = $list)
  
};

declare function functx:expected-value-enum($element as element()*, $list as xs:anyAtomicType*) as element()? {

  if(fn:not(fn:empty($element)))
  then
    if(fn:not(functx:contains-value($element, $list)))
    then
      <sb0:message>
        {const:UnexpectedValueMessage(fn:data($element), fn:concat(fn:local-name($element), '@', fn:namespace-uri($element)))}
      </sb0:message>
    else
      ()
  else
    ()
    
};

declare function functx:expected-value($element as element()*, $expected as xs:anyAtomicType) as element()? {

  if(fn:not(fn:empty($element)))
  then
    if(fn:not(fn:data($element) = $expected))
    then
      <sb0:message>
        {const:UnexpectedValueMessage(fn:data($element), fn:concat(fn:local-name($element), '@', fn:namespace-uri($element)))}
      </sb0:message>
    else
      ()
  else
    ()
    
};

declare function functx:faultOf($soapfault as element()) as xs:string {

  if (fn:exists($soapfault/detail/*[1]))
  then
    fn:local-name($soapfault/detail/*[1])
  else
    ''
    
};

declare function functx:error($layer as xs:string,
                              $tam as xs:string, 
                              $provider as xs:string, 
                              $api as xs:string, 
                              $error as xs:string,
                              $description as xs:string,
                              $cause as element(),
                              $body as element()) as element() {

    <soap11:Fault>
        <faultcode>soap11:Server</faultcode>
        <faultstring>{fn:data($description)}</faultstring>
        
        <detail>
            <ns1:errorTrace>
                <ns1:code>
                    <!-- Fill by the Exposition Layer's flow -->
                    <ns1:service/>
                    <ns1:operation/>
                    
                    <ns1:layer>{fn:data($layer)}</ns1:layer>
                    <ns1:tamSystem>{fn:data($tam)}</ns1:tamSystem>
                    <ns1:legacySystem>{fn:data($provider)}</ns1:legacySystem>
                    <ns1:api>{fn:data($api)}</ns1:api>

                    {
                      if (fn:data($error) = const:NotAvailable())
                      then
                        if (fn:exists($body/soap11:Fault/detail/*[1]))
                        then
                          <ns1:error>{fn:local-name($body/soap11:Fault/detail/*[1])}@{fn:namespace-uri($body/soap11:Fault/detail/*[1])}</ns1:error>
                        else
                          <ns1:error>{const:DefaultError()}</ns1:error>
                      else
                        if(fn:data($error) = 'OSB-382505')(: OSB Validate action failed validation :)
                        then
                          <ns1:error>{const:DefaultValidateFailed()}</ns1:error>
                        else
                          if(fn:data($error) = 'OSB-380002')(: OSB Connection error :)
                          then
                            <ns1:error>{const:DefaultError()}</ns1:error>
                          else
                            <ns1:error>{fn:data($error)}</ns1:error>
                    }
                    
                </ns1:code>
                <ns1:description>{fn:data($description)}</ns1:description>
                <ns1:details>
                    <ns1:timeStamp>{fn:current-dateTime()}</ns1:timeStamp>
                    <ns1:cause>{fn-bea:serialize($cause)} </ns1:cause>
                </ns1:details>
            </ns1:errorTrace>
        </detail>
    </soap11:Fault>
};

declare function functx:newGeneralFault($service as xs:string,
                                        $operation as xs:string, 
                                        $layer as xs:string, 
                                        $tam as xs:string, 
                                        $provider as xs:string,
                                        $api as xs:string,
                                        $errorCode as xs:string,
                                        $fault as element(),
                                        $body as element()) as element() {

  <stub/>
  
};

declare function functx:newInputValidationFault() as element() {

  <stub/>
  
};

declare function functx:newMandatoryParameterMissingFault() as element() {

  <stub/>
  
};

declare function functx:newFault11($layer as xs:string,
                                   $tam as xs:string, 
                                   $provider as xs:string, 
                                   $api as xs:string, 
                                   $error as xs:string, 
                                   $fault as element(),
                                   $body as element()) as element() {

    if (fn:exists($body/soap11:Fault)) 
    then 
      functx:error($layer, $tam, $provider, $api, $error, $body/soap11:Fault/faultstring, $body/soap11:Fault, $body)
    else
      if (
            fn:matches(fn:data($fault/sb1:errorCode), const:ErrorPattern())
            or
            fn:matches(fn:data($fault/sb1:errorCode), const:OSBErrorPattern())
         )
      then
        if(fn:not(fn:empty($fault/sb1:reason)))
          then
            functx:error($layer, $tam, $provider, $api, fn:data($fault/sb1:errorCode), fn:data($fault/sb1:reason), $fault, $body)
          else
            functx:error($layer, $tam, $provider, $api, fn:data($fault/sb1:errorCode), fn:data($fault/sb1:errorCode), $fault, $body)
      else
        functx:error($layer, $tam, $provider, $api, $error, fn:data($fault/sb1:reason), $fault, $body)
};

declare function functx:trim
  ( $arg as xs:string? )  as xs:string {

   replace(replace($arg,'\s+$',''),'^\s+','')
 } ;
 
declare function functx:trimx($arg as xs:string, $char as xs:string) as xs:string {

  fn:replace(
    fn:replace(
      $arg, fn:concat($char, '+$'),
      ''
    ),
    fn:concat('^', $char, '+'),
    ''
  )
  
};
 
(:~
 : essa função recebe como argumento um documento XML e remove todos os seus elementos vazios.
 : elemento vazio
 :    - tags "barradas"...........: <tagname/>, <tagname></tagname>
 :    - tags com espaços em branco: <tagname>   </tagname>
 : @param $payload - documento XML 
 : @return payload sem elementos vazios
 : @author Fábio J. Moraes
 : @since 1.0
:)
declare function functx:remove-empty($payload as element()) as element()? {
  if($payload/* or $payload/text())
  then
    element {node-name($payload)}
      {$payload/@*,
        for $child in $payload/node()
          return
             if ($child instance of element())
               then functx:remove-empty($child)
               else $child
      }
  else
    ()
    
};
(:funcao extraida do barramento Q3:)
declare function functx:formatDDD($stringDDD as xs:string) as xs:string{
    if(fn:string-length($stringDDD) > 2)
      then
          fn:substring($stringDDD, 2)
    else
      $stringDDD
};

(: essa função recebe 3 parametros e retorna com o formato HH:MM:SS :)
declare function functx:time
  ( $hour ,
    $minute ,
    $second )  as xs:time {

   xs:time(
     concat(
       functx:left-offset(xs:string(xs:integer($hour)),2,'0'),':',
       functx:left-offset(xs:string(xs:integer($minute)),2,'0'),':',
       functx:left-offset(xs:string(xs:integer($second)),2,'0')))
};

(: essa função recebe timeStamp com milisegundos e retorna com o formato YYYY-MM-DDTHH:MM:SS :)
declare function functx:timeStampMiliToDateTime($timestamp){
  let $seconds := $timestamp div 1000 mod 60
  let $minutes := $timestamp div 1000 div 60 mod 60
  let $hours := $timestamp div 1000 div 60 div 60 mod 24
  let $days := xs:integer($timestamp div 1000 div 60 div 60 div 24)
  let $date := xs:date("1970-01-01") + xs:dayTimeDuration(fn:concat("P",$days,"D"))
  return
  	fn:concat($date,"T",functx:time($hours, $minutes, $seconds))
};