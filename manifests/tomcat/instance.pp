define vs_java::tomcat::instance (
    String $sourceUrl,
    String $catalinaHome,
    String $catalinaBase,
    Integer $serverPort,
    Integer $connectorPort,
    String $tomcat_user    = 'vagrant',
    String $tomcat_group   = 'vagrant',
) {
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
    
    tomcat::config::server::connector { "${name}-http":
        catalina_base         => "${catalinaBase}",
        port                  => "${connectorPort}",
        protocol              => 'HTTP/1.1',
        
        #additional_attributes => {
        #    'redirectPort' => '8443'
        #},
    }
}