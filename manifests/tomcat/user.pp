define vs_java::tomcat::user (
    String $catalinaHome,
    String $username,
    String $password,
    String $owner       = 'vagrant',
    String $group       = 'vagrant',
) {    
    
    tomcat::config::server::tomcat_users {
        "instance-role-admin-gui-${title}":
            ensure          => present,
            catalina_base   => "${catalinaHome}",
            element         => 'role',
            element_name    => 'admin-gui',
            owner           => "${owner}",         
            group           => "${group}";
        "instance-role-admin-script-${title}":
            ensure        => present,
            catalina_base => "${catalinaHome}",
            element       => 'role',
            element_name  => 'admin-script',
            owner           => "${owner}",         
            group           => "${group}";
        "instance-role-manager-gui-${title}":
            ensure        => present,
            catalina_base => "${catalinaHome}",
            element       => 'role',
            element_name  => 'manager-gui',
            owner           => "${owner}",         
            group           => "${group}";
        "instance-role-manager-script-${title}":
            ensure        => present,
            catalina_base => "${catalinaHome}",
            element       => 'role',
            element_name  => 'manager-script',
            owner           => "${owner}",         
            group           => "${group}";
        "instance-user-admin-${title}":
            ensure        => present,
            catalina_base => "${catalinaHome}",
            element       => 'user',
            element_name  => "${username}",
            password      => "${password}",
            roles         => ['standard', 'admin-script', 'admin-gui', 'manager-script', 'manager-gui'],
            owner           => "${owner}",         
            group           => "${group}";
    }
}