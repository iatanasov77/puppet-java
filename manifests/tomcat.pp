class vs_java::tomcat (
	Hash $config   = {},
) {
	######################################################################
	# Reference: https://forge.puppet.com/modules/puppetlabs/tomcat
	######################################################################
	file { '/opt/tomcat':
        ensure  => directory,
        owner   => "${config['tomcatUser']}",
        group   => "${config['tomcatGroup']}",
    }
    
    if $config['instances'] {
    	$config['instances'].each | String $instanceName, Hash $instanceConfig | {
    		vs_java::tomcat::instance{ "${instanceName}":
                sourceUrl           => $instanceConfig['sourceUrl'],
                catalinaHome        => $instanceConfig['catalinaHome'],
                catalinaBase        => $instanceConfig['catalinaHome'],
                serverPort          => "${instanceConfig['serverPort']}",
                httpConnectorPort	=> "${instanceConfig['httpConnectorPort']}",
                ajpConnectorPort    => "${instanceConfig['ajpConnectorPort']}",
                tomcat_user         => "${config['tomcatUser']}",
                tomcat_group        => "${config['tomcatGroup']}",
		    }
            -> vs_java::tomcat::user{ "${instanceName}-admin-user":
                catalinaHome    => "${instanceConfig['catalinaHome']}",
                username        => 'admin',
                password        => 'admin',
                owner           => "${config['tomcatUser']}",
                group           => "${config['tomcatGroup']}",
            }
            -> vs_java::tomcat::service{ "${instanceName}":
                catalinaHome    => "${instanceConfig['catalinaHome']}",
                tomcatUser      => "${config['tomcatUser']}",
                tomcatGroup     => "${config['tomcatGroup']}",
            }
            -> vs_java::tomcat::remote_access{ "${instanceName}":
                catalinaHome    => "${instanceConfig['catalinaHome']}",
            }
            
            /*
            -> vs_java::tomcat::permissions{ "tomcat-${instanceName}":
                catalinaHome    => $instanceConfig['catalinaHome'],
                tomcat_users    => "${config['tomcatUser']}",
                tomcat_group    => "${config['tomcatGroup']}",
            }
            */
    	}
    }
}