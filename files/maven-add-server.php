#!/usr/bin/php
<?php

$mavenSetttings = "/opt/apache-maven-3.9.2/conf/settings.xml";

// Open and parse the XML file
$xml = simplexml_load_file( $mavenSetttings );

$server = $xml->servers[0]->addChild( "server" );
$server->addChild( "id", "TomcatServer" );
$server->addChild( "username", "admin" );
$server->addChild( "password", "admin" );

$pluginGroup = $xml->pluginGroups[0]->addChild( "pluginGroup", "org.codehaus.cargo" );

// Display the new XML code
//echo $xml->asXML();
//var_dump( $server );

// Store new XML code in questions.xml
$xml->asXML( $mavenSetttings );

?>