define vs_java::tomcat::permissions (
    String $catalinaHome,
) {
    $tomcat_users.each |$user| {
        exec { "tomcat-system-user-${user}":
            command => "/usr/sbin/usermod -aG ${tomcat_group} ${user}",
            unless  => "/bin/cat /etc/group | grep '^${tomcat_group}:' | grep -qw ${user}",
        }
    }
    
    file { "${catalinaHome}/logs":
        ensure  => directory ,
        mode    => '0770',
    }
    
    file { "${catalinaHome}/conf":
        ensure  => directory ,
        mode    => '0750',
    }
    
    exec { "${catalinaHome} Conf Files Permissions":
        command  => "chmod 0660  ${catalinaHome}/conf/* " ,
    }
}