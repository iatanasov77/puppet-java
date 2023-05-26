class vs_java::tomcat (
	Hash $config    = {},
) {
	######################################################################
	# Reference: https://forge.puppet.com/modules/puppetlabs/tomcat
	######################################################################
	file { '/opt/tomcat':
        ensure => directory,
    } ->
	class { 'vs_java::tomcat::default' :
		jdkPackage		=> $config['jdkPackage'],
		sourceUrl		=> $config['sourceUrl'],
		catalinaHome	=> $config['catalinaHome'],
    }
    
    if $config['instances'] {
    	$config['instances'].each | String $instanceName, Hash $instanceConfig | {
    		tomcat::install { "${instanceConfig['catalinaHome']}":
		        source_url => $instanceConfig['sourceUrl'],
		    } ->
    		vs_java::tomcat::instance { "${instanceName}":
    			catalinaHome	=> $instanceConfig['catalinaHome'],
			    catalinaBase	=> $instanceConfig['catalinaHome'],
			    serverPort		=> $instanceConfig['serverPort'],
			    connectorPort	=> $instanceConfig['connectorPort'],
		    }
    	}
    }
}