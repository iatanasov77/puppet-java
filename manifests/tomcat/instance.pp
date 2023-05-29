define vs_java::tomcat::instance (
    String $sourceUrl,
    String $catalinaHome,
    String $catalinaBase,
    String $serverPort,
    String $httpConnectorPort,
    String $ajpConnectorPort,
    String $tomcat_user    = 'vagrant',
    String $tomcat_group   = 'vagrant',
) {
    $defaultServerPort          = '8005'
    $defaultHttpConnectorPort   = '8080'
    $defaultAjpConnectorPort    = '8009'

    tomcat::install { "${catalinaHome}":
        source_url  => "${sourceUrl}",
        manage_user => ( $tomcat_user == 'tomcat' ),
        user        => "${tomcat_user}",
        group       => "${tomcat_group}",
    } ->
    tomcat::instance { "${name}":
        catalina_home   => "${catalinaHome}",
        catalina_base   => "${catalinaBase}",
        user            => "${tomcat_user}",
        group           => "${tomcat_group}",
    }

    tomcat::config::server { "${name}":
        catalina_base => "${catalinaBase}",
        port          => "${serverPort}",
    }
    
/*
    -> tomcat::config::server::connector { "${name}-http-absent":
        connector_ensure    => 'absent',
        port                => "${defaultHttpConnectorPort}",
        protocol            => 'HTTP/1.1',
    }
*/
    
    if ( $httpConnectorPort != $defaultHttpConnectorPort ) {
        tomcat::config::server::connector { "${name}-http":
            purge_connectors        => true,    
            catalina_base           => "${catalinaBase}",
            port                    => "${httpConnectorPort}",
            protocol                => 'HTTP/1.1',
            
            additional_attributes   => {
                'connectionTimeout' => '20000',
                #'redirectPort'      => '8443',
                'maxParameterCount' => '1000',
            },
        }
    }
    
    tomcat::config::server::connector { "${name}-ajp":
        catalina_base         => "${catalinaBase}",
        port                  => "${ajpConnectorPort}",
        protocol              => 'AJP/1.3',
        
        additional_attributes => {
            #'address'           => '::1'
            #'redirectPort'      => '8443'
            'maxParameterCount' => '1000',
        },
    }
}