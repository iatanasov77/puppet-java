class vs_java (
    $jdkVersion         = '17',
    $mavenVersion       = '3.9.2',
    Hash $tomcatConfig  = {},
) {
    ################################################################################################################
    # Add Class if Not Declared Already
    # https://github.com/puppetlabs/puppetlabs-stdlib/blob/main/lib/puppet/parser/functions/ensure_resource.rb
    ################################################################################################################
    ensure_resource( 'class', 'vs_java::openjdk', {
        jdkVersion  => $jdkVersion
    })
    
    Exec{ 'Set Java Default':
        command => "/opt/vs_devenv/set_default_java.sh ${jdkVersion}",
        require => [ Class['vs_java::openjdk'] ],
    }
    
    class { 'maven::maven':
        version => "${mavenVersion}",
    }
    
    class { '::vs_java::tomcat':
        config  => $tomcatConfig,
    }
}