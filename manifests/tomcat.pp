class vs_java::tomcat (
	Hash $config           = {},
	String $tomcat_user    = 'vagrant',
	String $tomcat_group   = 'vagrant',
) {
	######################################################################
	# Reference: https://forge.puppet.com/modules/puppetlabs/tomcat
	######################################################################
	file { '/opt/tomcat':
        ensure  => directory,
        owner   => "${tomcat_user}",
        group   => "${tomcat_group}",
    }
    
    if $config['instances'] {
    	$config['instances'].each | String $instanceName, Hash $instanceConfig | {
    		vs_java::tomcat::instance { "${instanceName}":
                sourceUrl       => $instanceConfig['sourceUrl'],
    			catalinaHome	=> $instanceConfig['catalinaHome'],
			    catalinaBase	=> $instanceConfig['catalinaHome'],
			    serverPort		=> $instanceConfig['serverPort'],
			    connectorPort	=> $instanceConfig['connectorPort'],
                tomcat_user     => "${tomcat_user}",
                tomcat_group    => "${tomcat_group}",
		    }
            -> vs_java::tomcat::user { "${instanceName}-admin-user":
                catalinaHome    => "${instanceConfig['catalinaHome']}",
                username        => 'admin',
                password        => 'admin',
                owner           => "${tomcat_user}",
                group           => "${tomcat_group}",
            }
            -> vs_java::tomcat::service { "${instanceName}":
                catalinaHome    => "${instanceConfig['catalinaHome']}",
                tomcatUser      => "${tomcat_user}",
                tomcatGroup     => "${tomcat_group}",
            }
            -> vs_java::tomcat::remote_access { "${instanceName}":
                catalinaHome    => "${instanceConfig['catalinaHome']}",
            }
            
            #-> vs_java::tomcat::permissions{ "tomcat-${instanceName}":
            #    catalinaHome    => $instanceConfig['catalinaHome'],
            #    tomcat_users    => $tomcat_users,
            #    tomcat_group    => $tomcat_group,
            #}
    	}
    }
    
    
}