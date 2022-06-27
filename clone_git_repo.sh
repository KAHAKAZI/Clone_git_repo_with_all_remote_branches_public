#/usr/bin/bash

function check_if_parameter_provided() {
    # Check if parameter provided
    if ! [ -z "$1"  ]; then
        echo Cloning $1
    else
        echo No repository URL given in parameter
        exit 0
    fi
}

function checkout_branches() {
    # Iterate over remote branches
    for value in $branches; do
        # cd ../

        # Remove 'origin/' from the beginning of the remote branch name
        remote_branch=$(echo $value | awk '{print substr($0, 8, length($0) - 2)}')

        # Break loop when HEAD encountered
        if [ $remote_branch == "HEAD" ]; then
            break;
        fi

        echo -e "\n\n"
        echo $remote_branch

        mkdir $remote_branch
        cd $remote_branch

        # Clone master in new directory and checkout
        git clone $1
        cd $directory
        git checkout $remote_branch
        echo -e "\n\nCurrent branch" && git branch
        cd ../../
    done
}

##########################################################################

check_if_parameter_provided "$1"

echo Start checkouting branches...

# Clone git repository ( master )
git clone $1

# # Change directory to the one created by git clone
directory=$(ls -d */)
cd $directory

# Get remote branches
branches=$(git branch -r)

checkout_branches "$1"

echo End of checkouting branches
##########################################################################
