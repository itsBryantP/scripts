# this moves content from GHE to GH (IBM)
# the first arg is the org name
# the second arg is the repo name, which will be used for the new repo as well
# the third arg is the new org name
# created by https://github.com/stevemar/junk_drawer/blob/master/mover.sh

read -p "Did you forget to create the repo on github.com/itsBryantP? " -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yn]$ ]]
then
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1 # handle exits from shell or function but don't exit interactive shell
fi

org=$1
repo=$2
newOrg=$3

## clone the repo to be moved and cd into it
git clone git@github.ibm.com:$1/$2.git
cd $2

read -p "press [Enter] key to continue remote rename..."

## rename the origin branch to something else to avoid conflicts
git remote rename origin destination

## go to github and create an empty repo, add the new repo location
git remote add origin https://github.com/$3/$2.git

read -p "press [Enter] key to continue push..."

## push code up to new remote branch
git push -u origin main

## note that if using the below command with 2FA, you will need to
## use a personal access token as a password along with your username!
