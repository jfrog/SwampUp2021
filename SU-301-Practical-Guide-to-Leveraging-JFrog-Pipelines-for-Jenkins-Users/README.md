# Pre requisites

1. Fork this github repository
2. Generate a [Github personnal access token](https://docs.github.com/en/github/authenticating-to-github/creating-a-personal-access-token) with the following [permissions](https://www.jfrog.com/confluence/display/JFROG/GitHub+Integration)
3. `git clone` the forked repo on your workstation

## Good to know 

The environment is provisionned with :
* a set of repositories
* a jenkins user and its permission
* 1 Xray policy and 1 Xray watch

Here is the procedure which was applied :

1. Edit and export  the following environment variables according to your own setup
```
# FOR EXAMPLE
export JPD_URL=https://swampup301.jfrog.io 
export ADMIN_USER=yannc@jfrog.com 
export ADMIN_PASS=guestwhatitis 
```
2. OPTIONAL :  edit the json files in **env_init**
3. Execute init script
```
env_init/init.sh 
```

# Labs 

Now please read the **README.md** in each lab folder

Enjoy !