<?php
ob_flush();
ob_start();
$xml = file_get_contents('php://input');
file_put_contents("/home/gyllescas/public_html/bw/kyleresponse.txt", ob_get_flush());
if (!function_exists('http_response_code')) {
    function http_response_code($newcode = null)
    {
        static $code = 200;
        if ($newcode !== null) {
            header('X-PHP-Response-Code: ' . $newcode, true, $newcode);
            if (!headers_sent()) {
                $code = $newcode;
            }
        }
        return $code;
    }
}
$xml = simplexml_load_string($xml);
http_response_code(200);
$errors = "";
$AccountNumber = FALSE;
$ZipCode = FALSE;
$SubscriberName = FALSE;

//AccountNumber
if(($xml->AccountNumber != NULL) && ($xml->AccountNumber == '5001396')){
  $AccountNumber = TRUE;
}
else{
if($xml->AccountNumber == NULL){
$errors .= "<Error><Code>7510</Code><Description>Required Account Code missing</Description></Error>";
}
else{
    $errors .= "<Error><Code>7511</Code><Description>Invalid Account Code</Description></Error>";
}
}

//ZipCode
if(($xml->ZipCode != NULL) &&  ($xml->ZipCode == '10013')){
  $ZipCode = TRUE;
}
else{
  if($xml->ZipCode == NULL){
    $errors .= "<Error><Code>7514</Code><Description>Required Zip Code missing</Description></Error>";
  }
  else{
    $errors .= "<Error><Code>7515</Code><Description>Invalid Zip Code</Description></Error>";
  }
}

//SubscriberName
if (($xml->SubscriberName != NULL) && (strtolower($xml->SubscriberName) == 'the plum group, inc.')) {
  $SubscriberName = TRUE;
}
else{
  $errors .= "<Error><Code>7519</Code><Description>Customer info does not match</Description></Error>";
}

if ($AccountNumber & $ZipCode & $SubscriberName){
  $ret = <<<XML
        <PortOutValidationResponse>
                <Portable>true</Portable>
        </PortOutValidationResponse>
XML;
  $ret = new SimpleXMLElement($ret);
  echo $ret->asXML();
  die();
}
else{
  $note=<<<XML
<PortOutValidationResponse>
        <Portable>false</Portable>
                <Errors>
                $errors
                </Errors>
              <AcceptableValues>
                      <AccountNumber>5001396</AccountNumber>
                      <ZipCode>10013</ZipCode>
                      <TelephoneNumbers>
                              <TelephoneNumber>9194430073</TelephoneNumber>
                      </TelephoneNumbers>
              </AcceptableValues>
</PortOutValidationResponse>
XML;
  $ret = new SimpleXMLElement($note);
  echo $ret->asXML();
  die();
}
