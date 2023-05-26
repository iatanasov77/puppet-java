class vs_java (
    $jdkVersion     = '17',
) {
    class { '::vs_java::openjdk':
        jdkVersion  => $jdkVersion
    }
}