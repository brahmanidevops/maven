#!/bin/sh

echo ""
echo "*******************"
echo "* NOTE: Usage for this script is: 'sh ./install.sh /path/to/install/target /path/to/local/repo'"
echo "*******************"
echo ""
    
(
    # First, ensure that the repoclean library has been built.
    
    echo "-----------------------------------------------------------------------"
    echo " Building a clean copy of repoclean ... "
    echo "-----------------------------------------------------------------------"  
    m2 clean:clean package
    ret=$?; if [ $ret != 0 ]; then exit $ret; fi
)
ret=$?; if [ $ret != 0 ]; then exit $ret; fi

(
    # Now, install the bash script and dependencies to the specified target dir.

    echo ""
    echo "-----------------------------------------------------------------------"
    echo " Installing repoclean to ${1} ... "
    echo "-----------------------------------------------------------------------"  
    echo ""

    mkdir -p $1/lib && \

    echo "Copying application libraries..."
    echo ""
    
    cp target/repoclean-1.0-SNAPSHOT.jar $1/lib && \
    cp $2/plexus/jars/plexus-container-default-1.0-alpha-2-SNAPSHOT.jar $1/lib && \
    cp $2/plexus/jars/plexus-utils-1.0-alpha-2-SNAPSHOT.jar $1/lib && \
    cp $2/classworlds/jars/classworlds-1.1-alpha-1.jar $1/lib && \

    echo "Copying startup script, and changing its permissions to '+x'..."
    echo ""
    
    cp src/main/bash/repoclean.sh $1 && \
    chmod +x $1/repoclean.sh
    
    ret=$?; if [ $ret != 0 ]; then exit $ret; fi

)
ret=$?; if [ $ret != 0 ]; then exit $ret; fi

echo ""
echo "*******************"
echo "* repoclean utility has been installed to: ${1}."
echo "*"
echo "* To run, change to '${1}' and execute './repoclean.sh', which will give further usage instructions."
echo "*******************"
echo ""
