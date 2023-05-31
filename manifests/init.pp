class vs_java (
    Hash $tomcatConfig  = {},
) {
    ################################################################################################################
    # Add Class if Not Declared Already
    # https://github.com/puppetlabs/puppetlabs-stdlib/blob/main/lib/puppet/parser/functions/ensure_resource.rb
    ################################################################################################################
    ensure_resource( 'vs_core::openjdk', "openjdk-${tomcatConfig['jdkVersion']}", {
        jdkVersion  => "${tomcatConfig['jdkVersion']}",
    })
    
    Exec{ "Set Java Default ${tomcatConfig['jdkVersion']}":
        command => "/opt/vs_devenv/set_default_java.sh ${tomcatConfig['jdkVersion']}",
        require => Package["java-${tomcatConfig['jdkVersion']}-openjdk"],
    }
    
    class { '::vs_java::maven':
        mavenVersion    => $tomcatConfig['mavenVersion'],
    }
    
    class { '::vs_java::tomcat':
        config  => $tomcatConfig,
    }
}