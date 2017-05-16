xquery version "1.0" encoding "utf-8"; 


(:: OracleAnnotationVersion "1.0" ::)

module namespace cst="http://andre.br/Common/Constants";

declare function cst:BRareaCode() as xs:string{
  '55'
};

declare function cst:DefaultCountry() as xs:string {
  'BRA'
};

declare function cst:DefaultLanguage() as xs:string {
  'por'
};

declare function cst:DefaultError() as xs:string {
  '9999'
};

declare function cst:DefaultMounth() as xs:string {
  'MM'
};


declare function cst:DefaultYear() as xs:string {
  'YYYY'
};

declare function cst:DefaultDayOfMounth() as xs:string {
  'DD'
};


(: tradução do erro OSB-382505 :)
declare function cst:DefaultValidateFailed() as xs:string {
  '9998'
};

declare function cst:IntegrationLayerCode() as xs:string {
  '0001'
};

declare function cst:OrquestrationLayerCode() as xs:string {
  '0002'
};

declare function cst:ExpositionLayerCode() as xs:string {
  '0003'
};

declare function cst:RequestValidationsCode() as xs:string {
  'REQUEST_VALIDATIONS_ERROR'
};

declare function cst:ErrorPattern() as xs:string {
  '^[0-9]{1,}$'
};

declare function cst:FullErrorPattern () as xs:string {
  '^[0-9]{4}\.[0-9]{4}\.[0-9]{4}\.[0-9]{6}\.[0-9]{4}\.[0-9]{4}\.[0-9a-zA-Z\-]{1,15}$'
};

declare function cst:OSBErrorPattern() as xs:string {
  '^OSB-[0-9]{1,}$'
};

declare function cst:ISODateTimePattern() as xs:string {
  '^[0-9]{2}-[0-9]{2}-[0-9]{4}\s[0-9]{2}:[0-9]{2}:[0-9]{2}$'
};

declare function cst:ErrorTranslatorCodePattern() as xs:string {
  '^\(\([A-Z_]{1,}\)\)$'
};

declare function cst:TranslateErrorNotCatalogedCode() as xs:string {
  '((ERR_TRANSL_NOT_CATALOGED))'
};

declare function cst:TranslateErrorInvalidInputCode() as xs:string {
  '((ERR_TRANSL_INVALID_INPUT))'
};

declare function cst:TranslateErrorUnavailableCode() as xs:string {
  '((ERR_TRANSL_UNAVAILABLE))'
};

declare function cst:NotAvailable() as xs:string {
  'n/a'
};

declare function cst:TrueString() as xs:string {
  "TRUE"
};

declare function cst:TrueInteger() as xs:integer {
  1
};

declare function cst:FalseString() as xs:string {
  "FALSE"
};

declare function cst:FalseInteger() as xs:integer {
  0
};

declare function cst:ErrorTranslatorUnavailable() as xs:string {
  "Error Translator Unavailable"
};

declare function cst:EmptyElementMessage() as xs:string {
  "Required element is empty: "
};

declare function cst:AbsentElementMessage() as xs:string {
  "Required element does not exists: "
};

declare function cst:UnexpectedValueMessage($value as xs:string, $location as xs:string) as xs:string {
  fn:concat("Unexpected value '", $value, "' at ", $location)
};

declare function cst:InvalidLengthMessage($minLength as xs:integer, $maxLength as xs:integer, $actualLength as xs:integer, $location as xs:string) as xs:string {

  fn:concat("Invalid length at '", $location, "': mininum '", xs:string($minLength), "', maximum '", $maxLength, "', actual '", $actualLength, "'") 
};

declare function cst:InvalidFormatMessage($value as xs:string, $format as xs:string, $location as xs:string) as xs:string {

  fn:concat("Invalid format at '", $location, "': accepted format '", $format, "'")
  
};

declare function cst:DDDPattern() as xs:string {
  '^[1-9][1-9]$'
};

declare function cst:MobileNumberPattern() as xs:string {
  '^[1-9][1-9][0-9]{9}$'
};

declare function cst:DDDToUF($ddd as xs:string) as xs:string {

  if($ddd = '11') then 'SP' else 
  if($ddd = '12') then 'SP' else 
  if($ddd = '13') then 'SP' else 
  if($ddd = '14') then 'SP' else 
  if($ddd = '15') then 'SP' else 
  if($ddd = '16') then 'SP' else 
  if($ddd = '17') then 'SP' else 
  if($ddd = '18') then 'SP' else 
  if($ddd = '19') then 'SP' else 
  if($ddd = '21') then 'RJ' else 
  if($ddd = '22') then 'RJ' else 
  if($ddd = '24') then 'RJ' else  
  if($ddd = '27') then 'ES' else 
  if($ddd = '28') then 'ES' else 
  if($ddd = '31') then 'MG' else 
  if($ddd = '32') then 'MG' else 
  if($ddd = '33') then 'MG' else 
  if($ddd = '34') then 'MG' else 
  if($ddd = '35') then 'MG' else 
  if($ddd = '37') then 'MG' else 
  if($ddd = '38') then 'MG' else 
  if($ddd = '41') then 'PR' else 
  if($ddd = '42') then 'PR' else 
  if($ddd = '43') then 'PR' else 
  if($ddd = '44') then 'PR' else 
  if($ddd = '45') then 'PR' else 
  if($ddd = '46') then 'PR' else 
  if($ddd = '47') then 'SC' else 
  if($ddd = '48') then 'SC' else 
  if($ddd = '49') then 'SC' else 
  if($ddd = '51') then 'RS' else 
  if($ddd = '53') then 'RS' else 
  if($ddd = '54') then 'RS' else 
  if($ddd = '55') then 'RS' else 
  if($ddd = '61') then 'GF' else 
  if($ddd = '61') then 'DF' else 
  if($ddd = '62') then 'GO' else 
  if($ddd = '63') then 'TO' else 
  if($ddd = '64') then 'GO' else 
  if($ddd = '65') then 'MT' else 
  if($ddd = '66') then 'MT' else 
  if($ddd = '67') then 'MS' else 
  if($ddd = '68') then 'AC' else 
  if($ddd = '69') then 'RO' else 
  if($ddd = '71') then 'BA' else 
  if($ddd = '73') then 'BA' else 
  if($ddd = '74') then 'BA' else 
  if($ddd = '75') then 'BA' else 
  if($ddd = '77') then 'BA' else 
  if($ddd = '79') then 'SE' else 
  if($ddd = '81') then 'PE' else 
  if($ddd = '82') then 'AL' else 
  if($ddd = '83') then 'PB' else 
  if($ddd = '84') then 'RN' else 
  if($ddd = '85') then 'CE' else 
  if($ddd = '86') then 'PI' else 
  if($ddd = '87') then 'PE' else 
  if($ddd = '88') then 'CE' else 
  if($ddd = '89') then 'PI' else 
  if($ddd = '91') then 'PA' else 
  if($ddd = '92') then 'AM' else 
  if($ddd = '93') then 'PA' else 
  if($ddd = '94') then 'PA' else 
  if($ddd = '95') then 'RR' else 
  if($ddd = '96') then 'AP' else 
  if($ddd = '97') then 'AM' else 
  if($ddd = '98') then 'MA' else 
  if($ddd = '99') then 'MA' else() 

};

declare function cst:localityToCodeLocality($locality as xs:string) as xs:string {

  if($locality = '11') then 'SPO' else 
  if($locality = '12') then 'SJC' else 
  if($locality = '13') then 'STS' else 
  if($locality = '14') then 'BRU' else 
  if($locality = '15') then 'SOC' else 
  if($locality = '16') then 'RPO' else 
  if($locality = '17') then 'SRR' else 
  if($locality = '18') then 'PPE' else 
  if($locality = '19') then 'CAS' else 
  if($locality = '21') then 'RJO' else 
  if($locality = '22') then 'CPS' else 
  if($locality = '24') then 'VRD' else  
  if($locality = '27') then 'VTA' else 
  if($locality = '28') then 'CIM' else 
  if($locality = '31') then 'A31' else 
  if($locality = '32') then 'A32' else 
  if($locality = '33') then 'A33' else 
  if($locality = '34') then 'AXA' else 
  if($locality = '35') then 'VGA' else  
  if($locality = '37') then 'DVL' else  
  if($locality = '38') then 'A38' else 
  if($locality = '41') then 'CTA' else 
  if($locality = '42') then 'PGO' else 
  if($locality = '43') then 'LDA' else 
  if($locality = '44') then 'MGA' else 
  if($locality = '45') then 'FOZ' else 
  if($locality = '46') then 'PBC' else 
  if($locality = '47') then 'JVE' else 
  if($locality = '48') then 'FNS' else 
  if($locality = '49') then 'CCO' else 
  if($locality = '51') then 'PAE' else 
  if($locality = '53') then 'RGR' else 
  if($locality = '54') then 'CSL' else 
  if($locality = '55') then 'SMA' else 
  if($locality = '61') then 'BSA' else   
  if($locality = '62') then 'GNA' else 
  if($locality = '63') then 'PMJ' else 
  if($locality = '64') then 'RVD' else 
  if($locality = '65') then 'CBA' else 
  if($locality = '66') then 'SNO' else 
  if($locality = '67') then 'CPE' else 
  if($locality = '68') then 'RBO' else 
  if($locality = '69') then 'PVO' else 
  if($locality = '71') then 'SDR' else 
  if($locality = '73') then 'ILH' else 
  if($locality = '74') then 'JUO' else 
  if($locality = '75') then 'FSA' else 
  if($locality = '77') then 'VCA' else 
  if($locality = '79') then 'AJU' else 
  if($locality = '81') then 'RCE' else 
  if($locality = '82') then 'MCO' else 
  if($locality = '83') then 'JPA' else 
  if($locality = '84') then 'NTL' else 
  if($locality = '85') then 'FLA' else 
  if($locality = '86') then 'TSA' else 
  if($locality = '87') then 'PTA' else 
  if($locality = '88') then 'CTO' else 
  if($locality = '89') then 'PCZ' else 
  if($locality = '91') then 'BLM' else 
  if($locality = '92') then 'MNS' else 
  if($locality = '93') then 'ATM' else  
  if($locality = '94') then 'MBA' else 
  if($locality = '95') then 'BVA' else 
  if($locality = '96') then 'MPA' else  
  if($locality = '97') then 'TBN' else 	
  if($locality = '98') then 'SLS' else 
  if($locality = '99') then 'ITZ' else() 
  
};

declare function cst:CanalToIdCanal($canal as xs:string) as xs:string {

  if($canal = 'CRC')                then '1' else
  if($canal = 'LJ')                 then '2' else
  if($canal = 'GRE')                then '3' else
  if($canal = 'CRI')                then '4' else
  if($canal = 'WAP')                then '5' else
  if($canal = 'Mala Direta')        then '6' else
  if($canal = 'Carta')              then '7' else
  if($canal = 'Mens. Cham. Cobrar') then '8' else
  if($canal = 'URA')                then '9' else
  if($canal = 'CXP')                then '10' else
  if($canal = 'EM')                 then '11' else
  if($canal = 'Tel')                then '12' else
  if($canal = 'TAV')                then '13' else
  if($canal = 'SIEBEL')             then '14' else
  if($canal = 'VOL')                then '15' else
  if($canal = 'RETENCAO')           then '16' else
  if($canal = 'GSS')                then '18' else
  if($canal = 'CORPORATIVO')        then '19' else
  if($canal = 'CSS')                then '25' else
  if($canal = 'LJAUTO')             then '26' else
  if($canal = 'ECOM')               then '32' else
  if($canal = 'RETENCAO360')        then '80' else
  if($canal = 'HELL')               then '666' else
  if($canal = 'LJVIRT')             then '899' else
  if($canal = 'URAV')               then '919' else
  if($canal = 'DEAREV')             then '1262' else
  if($canal = 'DEAVAR')             then '1263' else
  if($canal = 'GCCE')               then '1264' else
  if($canal = 'CN')                 then '1265' else
  if($canal = 'PM')                 then '1266' else
  if($canal = 'LP')                 then '1267' else
  if($canal = 'FUNC')               then '1268' else
  if($canal = 'ACON')               then '1269' else
  if($canal = 'SRC')                then '1270' else
  if($canal = 'CLM')                then '1271' else
  if($canal = 'URAC')               then '1275' else
  if($canal = 'SMS')                then '1276' else
  if($canal = 'URAPARCEIRO')        then '1280' else
  if($canal = 'URAPARCEIROZUP')     then '1281' else
  if($canal = 'ATL')                then '11111' else
  if($canal = 'NGN')                then '22222' else
  if($canal = 'VOLE')               then '22244' else
  if($canal = 'SMAP')               then '22264' else
  if($canal = 'VIVOPORTAL')         then '22284' else
  if($canal = 'SDP')                then '22324' else
  if($canal = 'PROCON')             then '22344' else
  if($canal = 'SIA')                then '22387' else
  if($canal = 'NSIA')               then '22388' else
  if($canal = 'URA_MOVEL')          then '22389' else
  if($canal = 'URA_FIXA')           then '22390' else
  if($canal = 'URA_TV_CABO')        then '22391' else
  if($canal = 'URA_TV_DTH')         then '22392' else
  if($canal = 'AMDOCS_MCSS')        then '22393' else
  if($canal = 'MEUVIVO_PJ')         then '22394' else
  if($canal = 'MEUVIVO_PF_CABO')    then '22395' else
  if($canal = 'MEUVIVO_PJ_CABO')    then '22396' else
  if($canal = 'TAV_TABLETE')        then '22404' else
  if($canal = 'MVM')                then '23608' else
  if($canal = 'MVL')                then '23609' else
  if($canal = 'CHT')                then '23610' else
  if($canal = 'TLVD')               then '23611' else
  if($canal = 'MTSMS')              then '23612' else
  if($canal = 'MVSM')               then '23613' else
  if($canal = 'URAFIXA')            then '24152' else ()
  
};

declare function cst:envHML() as xs:string{
  'HML'
};

declare function cst:envPRD() as xs:string{
  'PRD'
};

declare function cst:entityCodeClearSale($env as xs:string) as xs:string {

  if($env = cst:envHML()) then '4A990CAD-35FC-4EE3-ABC1-2AE84541B9ED' else 
  if($env = cst:envPRD()) then 'N/A' else()
};