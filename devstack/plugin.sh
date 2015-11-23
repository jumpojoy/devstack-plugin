# plugin.sh - DevStack plugin.sh dispatch script template

GENERIC_SWITCH_REPO=${GENERIC_SWITCH_REPO:-'https://github.com/jumpojoy/generic_switch.git'}
GENERIC_SWITCH_DIR=${GENERIC_SWITCH_DIR:-$DEST/generic_switch_f}
GENERIC_SWITCH_BRANCH=${GENERIC_SWITCH_BRANCH:-'master'}

GENERIC_SWITCH_INI_FILE='/etc/neutron/plugins/ml2/ml2_conf_genericswitch.ini'


GITDIR["netmiko"]=$DEST/netmiko
GITREPO["netmiko"]=${NETMIKO_REPO:-'https://github.com/ktbyers/netmiko.git'}
GITBRANCH["netmiko"]=${NETMIKO_BRANCH:-master}

function install_netmiko_lib {
# Untill netmiko with https://github.com/ktbyers/netmiko/commit/261c8ae22b078635f1371666d267dc77e3e17ddc
# is released, install netmiko with this commit
    git_clone_by_name netmiko
    setup_dev_lib netmiko
}

function install_generic_switch {
    install_netmiko_lib
    git_clone $GENERIC_SWITCH_REPO $GENERIC_SWITCH_DIR $GENERIC_SWITCH_BRANCH
    setup_develop $GENERIC_SWITCH_DIR

}

# check for service enabled
if is_service_enabled generic_switch; then

    if [[ "$1" == "stack" && "$2" == "pre-install" ]]; then
        # Set up system services
        echo_summary "Installing Generic_swtich ML2"
        install_generic_switch

#    elif [[ "$1" == "stack" && "$2" == "install" ]]; then
#        # Perform installation of service source
#        echo_summary "Installing Generic_swtich ML2"
#        install_generic_switch

#    elif [[ "$1" == "stack" && "$2" == "post-config" ]]; then
#        # Configure after the other layer 1 and 2 services have been configured
#        echo_summary "Configuring Generic_swtich Ml2"
#        configure_generic_switch

#    elif [[ "$1" == "stack" && "$2" == "extra" ]]; then
#        # Initialize and start the template service
#        echo_summary "Initializing Template"
#        init_template
    fi

#    if [[ "$1" == "unstack" ]]; then
#        # Shut down template services
#        # no-op
#        :
#    fi

#    if [[ "$1" == "clean" ]]; then
#        # Remove state and transient data
#        # Remember clean.sh first calls unstack.sh
#        # no-op
#        :
#    fi
fi
