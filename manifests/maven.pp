class vs_java::maven (
    $mavenVersion       = '3.9.2',
) {
    class { 'maven::maven':
        version => "${mavenVersion}",
    } ->
    file { '/opt/vs_devenv/maven-add-server.php':
        ensure  => present,
        owner   => 'root',
        group   => 'root',
        mode    => '0777',
        source  => 'puppet:///modules/vs_java/maven-add-server.php',
    } ->
    Exec { 'Maven Tomcat Server Settings':
        command => "/usr/bin/php /opt/vs_devenv/maven-add-server.php",
    }
}