### Replication

Installation method ->

a) Relevant configs:

/var/gerrit/etc/replication.config

    [remote "aricg-compliance"]
      url = git@github.com:username/${name}.git
      push = +refs/heads/*:refs/heads/*
      push = +refs/tags/*:refs/tags/*
      timeout = 30
      threads = 3
      remoteNameStyle = basenameOnly
      createMissingRepositories = false
      authGroup = GitHub Replication


/var/gerrit/.ssh/config

    Host github.com
        User git
        IdentityFile /var/gerrit/.ssh/id_rsa
        StrictHostKeyChecking no
        UserKnownHostsFile /dev/null

note: test sshing as the gerrit user to the remote server

b) Gerrit autorization:

Group Name: GitHub Replication
GitHub Replication denied read to refs/* in all projects
GitHub Replication allowed read to refs/* in in Project compliance/tests

c) enable plugin and start replication:

    ssh -p 29418 server.address gerrit plugin ls
    Name                           Version    Status   File
    -------------------------------------------------------------------------------
    replication                    v2.8       ENABLED  replication.jar


    ssh -p 29418 server.address gerrit plugin reload replication


    ssh -p 29418 server.address replication start --wait --all
    Replicate compliance/tests to aricgardner.com, Succeeded!
    ----------------------------------------------
    Replication completed successfully!


### Add verified label

    [label "Verified"]
        function = MaxWithBlock
        value = -1 Fails
        value =  0 No score
        value = +1 Verified


### Create jenkins user

`ssh -p 29418 gdyuldin@localhost gerrit create-account jenkins --full-name Jenkins --group '"Non-Interactive Users"' --ssh-key - < key`
