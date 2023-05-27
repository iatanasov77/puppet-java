define vs_java::tomcat::remote_access (
    String $catalinaHome,
) {
    exec { "${catalinaHome} - Remove Docs Application - Valve 1":
        command  => "sed -i '/<Valve/d' ${catalinaHome}/webapps/docs/META-INF/context.xml" ,
    }
    exec { "${catalinaHome} - Rmove Docs Application - Valve 2":
        command  => "sed -i '/allow=\"127/d' ${catalinaHome}/webapps/docs/META-INF/context.xml" ,
    }
    
    exec { "${catalinaHome} - Remove Examples Application - Valve 1":
        command  => "sed -i '/<Valve/d' ${catalinaHome}/webapps/examples/META-INF/context.xml" ,
    }
    exec { "${catalinaHome} - Remove Examples Application - Valve 2":
        command  => "sed -i '/allow=\"127/d' ${catalinaHome}/webapps/examples/META-INF/context.xml" ,
    }
    
    exec { "${catalinaHome} - Remove Host Manager Application - Valve 1":
        command  => "sed -i '/<Valve/d' ${catalinaHome}/webapps/host-manager/META-INF/context.xml" ,
    }
    exec { "${catalinaHome} - Remove Host Manager Application - Valve 2":
        command  => "sed -i '/allow=\"127/d' ${catalinaHome}/webapps/host-manager/META-INF/context.xml" ,
    }
    
    exec { "${catalinaHome} - Remove Manager Application - Valve 1":
        command  => "sed -i '/<Valve/d' ${catalinaHome}/webapps/manager/META-INF/context.xml" ,
    }
    exec { "${catalinaHome} - Remove Manager Application - Valve 2":
        command  => "sed -i '/allow=\"127/d' ${catalinaHome}/webapps/manager/META-INF/context.xml" ,
    }
}